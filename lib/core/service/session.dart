import 'dart:convert';

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
import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:padong/core/node/node.dart';
import 'package:padong/core/padong_router.dart';
import 'package:padong/core/service/padong_auth.dart';
import 'package:padong/core/node/common/user.dart';
import 'package:padong/core/node/common/university.dart';
import 'package:padong/core/service/padong_fb.dart';
import 'package:padong/core/shared/types.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:http/http.dart' as http;
import 'package:padong/core/shared/validator.dart';

class Session {
  static User user;
  static University userUniversity;
  static University currUniversity;

  static bool get inMyUniv => userUniversity.id == currUniversity.id;

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
    await Session.currUniversity.initUniversity();
  }

  static Future<SignInResult> signInUser(String userId, String pw) async {
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
      String email, String university, int entranceYear) async {
    User user = await User.getByUserId(userId);
    if (user != null) return SignUpResult.IdAlreadyInUse;

    University univ = await University.getUniversityByName(university);
    if (univ == null) return SignUpResult.UniversityNotFound;

    if (!Validator.universityEmailVerification(univ, email)) {
      return SignUpResult.InvalidUniversityEmail;
    }

    SignUpResult result = await PadongAuth.signUp(email, pw);
    if (result == SignUpResult.success) {
      String uid = await PadongAuth.getUid();
      user = await User.fromMap(uid, {
        'pip': pipToString(PIP.PUBLIC),
        'parentId': univ.id,
        'ownerId': uid,
        'name': name,
        'userId': userId,
        'isVerified': false,
        'university': university,
        'entranceYear': entranceYear,
        'userEmails': [email],
        'profileImageURL': "",
        'friendIds': <String>[],
        'lectureIds': <String>[],
      }).set(uid);
      await _registerUser(user, univ);
    } else if (result == SignUpResult.EmailAlreadyInUse) {
      return SignUpResult.EmailAlreadyInUse;
    }
    return result;
  }

  static Future<bool> signOutUser(BuildContext context) async {
    return await PadongAuth.signOut().then((_) {
      Navigator.popUntil(context, (route) => route.isFirst);
      _initSession();
      return true;
    }).catchError((e) => false);
  }

  static Future<void> changeUserEmail(
      String email, BuildContext context) async {
    // at view, update user's parentId, university
    String uid = await PadongAuth.getUid();
    if (user == null || user.id != uid)
      throw Exception('Invalid User try to Change Email');

    String currEmail = await PadongAuth.changeEmail(email);
    if (currEmail == null)
      throw Exception('Change Email Failed');
    else {
      user.userEmails = [currEmail, email];
      await user.update();
      await signOutUser(context);
    }
  }

  static Future<bool> changeCurrentUniversity(University university) async {
    try {
      currUniversity = university;
      await university.initUniversity();
      PadongRouter.routeURL('/main');
      return true;
    } catch (e) {
      log(e);
      return false;
    }
  }

  static ACCESS checkAccess(Node node) {
    // TODO: check it's right?
    if (node.ownerId == user.id) return ACCESS.READWRITE;
    if (node.pip == PIP.PUBLIC) {
      return ACCESS.READWRITE;
    } else if (node.pip == PIP.INTERNAL) {
      if (inMyUniv && node.type == 'board') return ACCESS.READWRITE;
      return ACCESS.READONLY;
    } else if (inMyUniv && node.type == 'board') return ACCESS.READWRITE;
    return ACCESS.DENIED;
  }

  static Future<void> updateUserPassword(String pw) async =>
      await PadongAuth.changePassword(pw);

  static Future<ResetPasswordResult> sendResetPasswordEmail(
      String id, String email) async {
    User targetUser = await User.getByUserId(id);
    if (targetUser == null) return ResetPasswordResult.InvalidUser;
    if (!targetUser.userEmails.contains(email))
      return ResetPasswordResult.InvalidEmail;

    try {
      await PadongAuth.resetPassword(email);
    } on fb.FirebaseAuthException catch (e) {
      if (e.code == "invalid-email") {
        return ResetPasswordResult.InvalidEmail;
      } else if (e.code == "user-not-found") {
        return ResetPasswordResult.InvalidEmail;
      }
    } catch (e) {
      return ResetPasswordResult.Failed;
    }
    return ResetPasswordResult.Success;
  }

  static Future<void> refreshUser() async {
    bool emailVerified = await PadongAuth.isEmailVerified();
    if (user.isVerified != emailVerified) {
      user.isVerified = emailVerified;
      await user.update();
    }
  }

  static Future<Map<String, dynamic>> _getAdminInfo(String id) async {
    DocumentSnapshot document = await PadongFB.getDoc('admin', id);
    return document?.data();
  }

  static Future<bool> sendReport(
      String title, String body, List<String> labels) async {
    Map<String, dynamic> adminInfo = await _getAdminInfo('github');
    if (adminInfo == null) return false;

    var client = http.Client();
    try {
      String token = adminInfo['token'];
      String issueUrl = adminInfo['issueUrl'];
      var uriResponse = await client.post(Uri.parse(issueUrl),
          body: json.encode({
            'title': title,
            'body': body,
            'labels': labels,
          }),
          headers: {
            HttpHeaders.contentTypeHeader: "application/json",
            'Authorization': "token $token"
          });
      if (uriResponse.statusCode == 201)
        return true;
      else
        return false;
    } finally {
      client.close();
    }
  }

  static Future<bool> makeNewUniversityIssue(
      String email, String university) async {
    String title = 'Request to add a new university from $email';
    String body = 'Email from: $email\nUniversity: $university';
    List<String> labels = ['request'];
    return await sendReport(title, body, labels);
  }
}
