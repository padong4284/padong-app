
import 'package:firebase_auth/firebase_auth.dart';


enum RegistrationReturns{
  success,
  failed,
  weak_password,
  emailAlreadyInUse
}

enum SignInReturns{
  success,
  failed,
  wrongEmailOrPassword
}
class PadongAuth{
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<SignInReturns> signIn(String email, String pw) async {
    try {
      await auth.signInWithEmailAndPassword(
          email: email,
          password: pw
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        return SignInReturns.wrongEmailOrPassword;
      }
      return SignInReturns.failed;
    }

    if (auth.currentUser == null){
      return SignInReturns.failed;
    }
    return SignInReturns.success;
  }

  /// signOut make State of authentication to Sign out.
  Future<void> signOut() async {
    auth.signOut();
  }

  /// When registerWithEmail returned AuthError.success,
  /// the verification email has sent. so, View must notify it to user.
  Future<RegistrationReturns> registerWithEmail(String email, String pw) async {
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


    User user = FirebaseAuth.instance.currentUser;
    if (user == null){
      return RegistrationReturns.failed;
    }
    if (!user.emailVerified) {
      await user.sendEmailVerification();
    }
    return RegistrationReturns.success;
  }

  Future<bool> emailVerification() async {
    User user = auth.currentUser;
    if (user==null){
      return false;
    }
    if (user.emailVerified == false){
      await user.sendEmailVerification();
      return true;
    }
    return false;
  }
}