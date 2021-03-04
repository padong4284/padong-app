import 'package:flutter/material.dart';
import 'package:padong/core/services/firestore_api.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:padong/locator.dart';
import 'package:padong/core/node/common/user.dart' as userNode;

enum RegistrationReturns {
  success,
  failed,
  weak_password,
  emailAlreadyInUse,
  IdAlreadyInUse
}

enum SignInReturns { success, failed, wrongEmailOrPassword }

class PadongAuth {
  final FirebaseAuth auth = FirebaseAuth.instance;
  FirestoreAPI _userDB = locator<FirestoreAPI>('Firesetore:user');

  Future<userNode.User> get currentSession async {
    // TODO: current Univ
    await auth.currentUser.reload();
    if (auth.currentUser == null) {
      throw Exception("Not logged in");
    }
    DocumentSnapshot user = await _userDB.ref.doc(auth.currentUser.uid).get();
    if (!user.exists) {
      throw Exception("There's no user");
    }
    return userNode.User.fromMap(auth.currentUser.uid, user.data());
  }

  Future<SignInReturns> signIn(String id, String pw) async {
    QuerySnapshot user = await _userDB.ref.where("userId", isEqualTo: id).get();
    if (user.size == 0) {
      return SignInReturns.wrongEmailOrPassword;
    }
    QueryDocumentSnapshot docSnapshot = user.docs.first;
    userNode.User docUser = userNode.User.fromMap(docSnapshot.id, docSnapshot.data());

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
    @required String name,
    @required String email,
  }) async {
    QuerySnapshot user = await _userDB.ref.where("userId", isEqualTo: id).get();
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

    _userDB.ref.doc(currentUser.uid).set({
      'userId': id,
      'name': name,
      'userEmails': [email],
      'isVerified': false,
      'profileImageURL': "",
      'createdAt': DateTime.now().toIso8601String(),
    });

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

    userNode.User docUser = userNode.User.fromMap(queryUser.id, queryUser.data());

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

    docUser.userEmails = [user.email, email];

    await _userDB.setDocument(docUser.toJson(), docUser.id);
    await auth.signOut();
    return true;
  }
}

// TODO: move! FIXME: !!
getChatRoomList() async {
  final PadongAuth auth = locator<PadongAuth>();

  ModelUser user = await auth.currentSession;
  List<ModelChatroom> result;
  List<String> chatroomIds;

  QuerySnapshot queryResult = await _participantDB.ref.where('ownerId',isEqualTo: user.id).get();
  for(var i in queryResult.docs){
    chatroomIds.add(i.data()['parentNodeId']);
  }

  queryResult = await _chatroomDB.ref.where('id', whereIn: chatroomIds ).get();
  for(var i in queryResult.docs){
    result.add(ModelChatroom.fromMap(i.id, i.data()));
  }

  return result;
}