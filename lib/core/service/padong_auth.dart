import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:padong/core/node/common/university.dart';
import 'package:padong/core/shared/types.dart';
import 'package:padong/core/service/padong_fb.dart';
import 'package:padong/core/node/common/user.dart' as userNode;

class PadongAuth {
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  static Future<userNode.User> get currentUser async {
    await _auth.currentUser.reload();
    if (_auth.currentUser == null) return null;
    userNode.User user =
        await PadongFB.getNode(userNode.User, _auth.currentUser.uid);
    if (user == null)
      throw Exception("There's no User ${_auth.currentUser.uid}");
    return user;
  }

  static Future<SignInReturns> signIn(String id, String pw) async {
    userNode.User user = await userNode.User.getByUserId(id);
    if (user == null) return SignInReturns.wrongEmailOrPassword;

    SignInReturns lastStatus; // signIn with user's userEmail
    for (String email in user.userEmails) {
      lastStatus = SignInReturns.success;
      try {
        await _auth.signInWithEmailAndPassword(email: email, password: pw);
      } on FirebaseAuthException catch (e) {
        log(e.code);
        if (e.code == 'user-not-found' || e.code == 'wrong-password')
          lastStatus = SignInReturns.wrongEmailOrPassword;
        else
          lastStatus = SignInReturns.failed;
      } on Exception catch (e) {
        lastStatus = SignInReturns.failed;
      }
      if (lastStatus == SignInReturns.success) break;
    }
    if (lastStatus != SignInReturns.success) return lastStatus;

    User sessionUser = _auth.currentUser;
    if (sessionUser == null) return SignInReturns.failed;

    // because, user email verify completed or changed Email
    user.isVerified = sessionUser.emailVerified;
    await user.update();
    return SignInReturns.success;
  }

  static Future<void> signOut() async {
    // signOut make State of authentication to Sign out.
    await _auth.signOut();
  }

  static Future<RegistrationReturns> signUp(
    String id,
    String pw,
    String name,
    String email,
    String universityName,
    int entranceYear,
  ) async {
    // When registerWithEmail returned AuthError.success,
    // the verification email has sent. so, TODO: View must notify it to user.
    userNode.User user = await userNode.User.getByUserId(id);
    if (user != null) {
      log("user already exists");
      return RegistrationReturns.IdAlreadyInUse;
    }

    University university;
    try {
      university = await University.getUniversityByName(universityName);
    } catch (e) {
      log("university not found");
      return RegistrationReturns.UniversityNotFound;
    }

    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: pw);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password')
        return RegistrationReturns.weak_password;
      else if (e.code == 'email-already-in-use')
        return RegistrationReturns.emailAlreadyInUse;
      return RegistrationReturns.failed;
    } catch (e) {
      return RegistrationReturns.failed;
    }

    User currentUser = _auth.currentUser;
    if (currentUser == null) return RegistrationReturns.failed;
    if (!currentUser.emailVerified) // TODO: notify email send
      await currentUser.sendEmailVerification();

    PadongFB.setNode(
        userNode.User,
        {
          'name': name,
          'userId': id,
          'isVerified': false,
          'entranceYear': entranceYear,
          'userEmails': [email],
          'profileImageURL': "",
          'friendIds': [],
          'pip': PIP.PUBLIC,
          'parentId': university.id,
          'ownerId': currentUser.uid,
        },
        currentUser.uid);
    return RegistrationReturns.success;
  }

  static Future<bool> changeEmail(String email) async {
    await _auth.currentUser.reload();
    User sessionUser = _auth.currentUser;
    if (sessionUser == null) return false;

    userNode.User user = await PadongFB.getNode(userNode.User, sessionUser.uid);
    if (user == null) return false;

    try {
      //ToDo: Must Check changeEmail with exist email.
      // In Firebase Auth Document, verifyBeforeUpdateEmail's Error code doesn't
      // have [auth/email-already-in-use].
      await sessionUser.verifyBeforeUpdateEmail(email);
    } on FirebaseAuthException {
      return false;
    } on Exception {
      return false;
    }

    user.userEmails = [sessionUser.email, email];
    await user.update();
    await _auth.signOut();
    return true;
  }
}
