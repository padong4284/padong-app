import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:padong/core/models/user/user.dart';
import 'package:padong/core/services/firestore_api.dart';
import 'package:padong/locator.dart';

enum RegistrationReturns { success, failed, weak_password, emailAlreadyInUse, IdAlreadyInUse }

enum SignInReturns { success, failed, wrongEmailOrPassword }

class PadongAuth {
  final FirebaseAuth auth = FirebaseAuth.instance;
  FirestoreAPI _userDB = locator<FirestoreAPI>('Firesetore:user');

  Future<ModelUser> get currentSession async {
    await auth.currentUser.reload();
    if (auth.currentUser == null){
      throw Exception("Not logged in");
    }
    DocumentSnapshot user =  await _userDB.ref.doc(auth.currentUser.uid).get();
    if (!user.exists){
      throw Exception("There's no user");
    }
    return ModelUser.fromMap(user.data(), auth.currentUser.uid);
  }

  Future<SignInReturns> signIn(String id, String pw) async {
    QuerySnapshot user =
        await _userDB.ref.where("userId", isEqualTo: id).get();
    if (user.size == 0) {
      return SignInReturns.wrongEmailOrPassword;
    }
    QueryDocumentSnapshot docSnapshot = user.docs.first;
    ModelUser docUser = ModelUser.fromMap(docSnapshot.data(), docSnapshot.id);

    SignInReturns lastStatus;
    for (String email in docUser.userEmails) {
      lastStatus = SignInReturns.success;
      try {
        await auth.signInWithEmailAndPassword(email: email, password: pw);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found' || e.code == 'wrong-password') {
          lastStatus = SignInReturns.wrongEmailOrPassword;
        } else {
          lastStatus = SignInReturns.failed;
        }
      } on Exception {
        lastStatus = SignInReturns.failed;
      }
      if (lastStatus == SignInReturns.success) {
        break;
      }
    }
    if (lastStatus != SignInReturns.success) {
      return lastStatus;
    }

    User sessionUser = auth.currentUser;

    if (sessionUser == null) {
      return SignInReturns.failed;
    }

    //user email verify completed or changed Email
    if (sessionUser.emailVerified != docUser.isVerified) {
      docUser.isVerified = sessionUser.emailVerified;
    }

    _userDB.setDocument(docUser.toJson(), docUser.id);
    return SignInReturns.success;
  }

  /// signOut make State of authentication to Sign out.
  Future<void> signOut() async {
    auth.signOut();
  }

  /// When registerWithEmail returned AuthError.success,
  /// the verification email has sent. so, View must notify it to user.
  Future<RegistrationReturns> registerWithEmail({
    @required String id,
    @required String pw,
    @required String userName,
    @required String email,
  }) async {
    QuerySnapshot user =
        await _userDB.ref.where("userId", isEqualTo: id).get();
    if (user.size > 0) {
      return RegistrationReturns.IdAlreadyInUse;
    }

    try {
      await auth.createUserWithEmailAndPassword(
        email: email,
        password: pw,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return RegistrationReturns.weak_password;
      } else if (e.code == 'email-already-in-use') {
        return RegistrationReturns.emailAlreadyInUse;
      }
      return RegistrationReturns.failed;
    } catch (e) {
      return RegistrationReturns.failed;
    }

    User currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser == null) {
      return RegistrationReturns.failed;
    }

    if (!currentUser.emailVerified) {
      await currentUser.sendEmailVerification();
    }

    _userDB.ref.doc(currentUser.uid).set ({
      'userName': userName,
      'userId': id,
      'userEmails': [email],
      'profileImage': "",
      'isVerified': false,
      'createdAt': DateTime.now().toIso8601String(),
    });
    //ModelUser user = ModelUser.fromMap(docUser.data(), sessionUser.uid);
    /*@required this.userName, @required this.userNickName, @required this.userId, @required this.userEmail,
    @required this.profileImage, @required this.isVerified, @required this.friendIds,
    parentNodeId, ownerId, pip,
    createdAt, deletedAt, modifiedAt*/

    return RegistrationReturns.success;
  }

  Future<bool> changeEmail(String email) async {
    await auth.currentUser.reload();
    User user = auth.currentUser;
    if (user == null) {
      return false;
    }

    DocumentSnapshot queryUser = await _userDB.ref.doc(user.uid).get();

    if (queryUser.exists == false) {
      return false;
    }

    ModelUser docUser = ModelUser.fromMap(queryUser.data(), queryUser.id);

    try {
      //ToDo: Must Check changeEmail with exist email.
      // In Firebase Auth Document, verifyBeforeUpdateEmail's Error code doesn't
      // have [auth/email-already-in-use].
      await user.verifyBeforeUpdateEmail(email);
    } on FirebaseAuthException {
      return false;
    } on Exception {
      return false;
    }

    docUser.userEmails = [ user.email, email ];

    await _userDB.setDocument(docUser.toJson(), docUser.id);
    await auth.signOut();
    return true;
  }
}
