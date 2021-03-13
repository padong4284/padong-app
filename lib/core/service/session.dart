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
import 'package:flutter/material.dart';
import 'package:padong/core/service/padong_auth.dart';
import 'package:padong/core/node/common/user.dart';
import 'package:padong/core/node/common/university.dart';
import 'package:padong/core/shared/types.dart';

class Session {
  static User user;
  static University userUniversity;
  static University currUniversity;

  static _initSession() {
    user = null;
    userUniversity = null;
    currUniversity = null;
  }

  static Future<void> _registerUser(User user, [University university]) async {
    if (user == null) throw Exception('Null User try to register');
    Session.user = user;
    university = university ?? (await user.getParent(University()));
    Session.userUniversity = university;
    Session.currUniversity = university;
  }

  static Future<SignInResult> signInUser(String userId, String pw) async {
    userId = userId.toLowerCase();
    User user = await User.getByUserId(userId);
    if (user == null) return SignInResult.wrongUserId;

    SignInResult result = await PadongAuth.signIn(user.userEmails, pw);
    if (result == SignInResult.success) {
      // because, user email verify completed or changed Email
      bool emailVerified = await PadongAuth.isEmailVerified();
      if (user.isVerified != emailVerified) {
        user.isVerified = emailVerified;
        await user.update();
      }
      await _registerUser(user);
    }
    return result;
  }

  static Future<SignUpResult> signUpUser(String userId, String pw, String name,
      String email, String universityName, int entranceYear) async {
    userId = userId.toLowerCase();
    User user = await User.getByUserId(userId);
    if (user != null) return SignUpResult.IdAlreadyInUse;

    University univ = await University.getUniversityByName(universityName);
    if (univ == null) return SignUpResult.UniversityNotFound;

    SignUpResult result = await PadongAuth.signUp(email, pw);
    if (result == SignUpResult.success) {
      String uid = await PadongAuth.getUid();
      user = await User.fromMap(uid, {
        'name': name,
        'userId': userId,
        'isVerified': false,
        'entranceYear': entranceYear,
        'userEmails': [email],
        'profileImageURL': "",
        'friendIds': <String>[],
        'pip': pipToString(PIP.PUBLIC),
        'parentId': univ.id,
        'ownerId': uid,
      }).set(uid);
      await _registerUser(user, univ);
    }
    return result;
  }

  static Future<bool> signOutUser(BuildContext context) async {
    return await PadongAuth.signOut().then((_) {
      _initSession();
      Navigator.pushNamed(context, '/');
      return true;
    }).catchError((e) => false);
  }

  static Future changeUserEmail(String email, BuildContext context) async {
    String uid = await PadongAuth.getUid();
    if (user == null || user.id != uid)
      throw Exception('Invalid User try to Change Email');

    // TODO: user's parentId
    String currEmail = await PadongAuth.changeEmail(email);
    user.userEmails = [currEmail, email];
    await user.update();
    await signOutUser(context);
  }

  static Future<bool> changeCurrentUniversity(
      University university, BuildContext context) async {
    // TODO: use Provider, alert all view
    currUniversity = university;
    Navigator.pushNamed(context, '/main');
    return true; // TODO: check success
  }
}
