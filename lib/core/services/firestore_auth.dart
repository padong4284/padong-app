import 'package:firebase_auth/firebase_auth.dart';

class FirestoreAuth{
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<bool> registerWithEamil(String email, String pw) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: pw,
      );
      userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
      return false;
    } catch (e) {
      print(e);
    }

    return true;
  }

}