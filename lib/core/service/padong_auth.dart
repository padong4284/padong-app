import 'dart:developer';

///*********************************************************************
///* Copyright (C) 2021-2021 Taejun Jang <padong4284@gmail.com>
///* All Rights Reserved.
///* This file is part of PADONG.
///*
///* PADONG can not be copied and/or distributed without the express
///* permission of Taejun Jang, Daewoong Ko, Hyunsik Kim, Seongbin Hong
///*
///* Github [https://github.com/padong4284]
///*********************************************************************
import 'package:firebase_auth/firebase_auth.dart';
import 'package:padong/core/shared/types.dart';

class PadongAuth {
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  static Future<bool> isEmailVerified() async {
    if (_auth.currentUser == null) throw Exception('No Current User');
    await _auth.currentUser.reload();
    return _auth.currentUser.emailVerified;
  }

  static Future<String> getUid() async {
    if (_auth.currentUser == null) throw Exception('No Current User');
    await _auth.currentUser.reload();
    return _auth.currentUser.uid;
  }

  static Future<SignInResult> signIn(List<String> emails, String pw) async {
    // signIn with user's userEmail
    SignInResult lastStatus = SignInResult.success;
    for (String email in emails) {
      try {
        await _auth.signInWithEmailAndPassword(email: email, password: pw);
      } on FirebaseAuthException catch (e) {
        lastStatus = SignInResult.failed;
        if (e.code == 'user-not-found' || e.code == 'wrong-password')
          lastStatus = SignInResult.wrongEmailOrPassword;
      } on Exception catch (_) {
        lastStatus = SignInResult.failed;
      }
      if (lastStatus == SignInResult.success) break;
    }
    return lastStatus;
  }

  static Future<void> signOut() async {
    // signOut make State of authentication to Sign out.
    await _auth.signOut();
  }

  static Future<SignUpResult> signUp(String email, String pw) async {
    // When registerWithEmail returned AuthError.success,
    // the verification email has sent. so, TODO: View must notify it to user.
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: pw);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password')
        return SignUpResult.weak_password;
      else if (e.code == 'email-already-in-use')
        return SignUpResult.emailAlreadyInUse;
      log(e.toString());
      return SignUpResult.failed;
    } catch (e) {
      log(e.toString());
      return SignUpResult.failed;
    }

    User currentUser = _auth.currentUser;
    if (currentUser == null) return SignUpResult.failed;
    if (!currentUser.emailVerified) // TODO: notify email send
      await currentUser.sendEmailVerification();
    return SignUpResult.success;
  }

  static Future<String> changeEmail(String email) async {
    await _auth.currentUser.reload();
    User sessionUser = _auth.currentUser;
    if (sessionUser == null) return null;

    try {
      // TODO: Must Check changeEmail with exist email.
      // In Firebase Auth Document, verifyBeforeUpdateEmail's Error code doesn't
      // have [auth/email-already-in-use].
      await sessionUser.verifyBeforeUpdateEmail(email);
    } on Exception {
      return null;
    }
    return sessionUser.email;
  }
}
