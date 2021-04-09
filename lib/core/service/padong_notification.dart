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
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'padong_fb.dart';
import 'session.dart';

class PadongNotification {
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  static void _configLocalNotification() {
    var initializationSettingsAndroid = new AndroidInitializationSettings('noti_filled_icon');
    var initializationSettingsIOS = new IOSInitializationSettings();
    var initializationSettings = new InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  static void _produceMessageListener() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        'app.padong',
        'Padong chat',
        'Padong channel',
        playSound: true,
        enableVibration: true,
        importance: Importance.max,
        priority: Priority.high,
      );
      var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
      var platformChannelSpecifics =
      new NotificationDetails(
          android: androidPlatformChannelSpecifics,
          iOS: iOSPlatformChannelSpecifics
      );
      flutterLocalNotificationsPlugin.show(
        0, message.notification.title, message.notification.body, platformChannelSpecifics,
      );
    });
  }

  static void registerNotification() async {
    FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
    await firebaseMessaging.requestPermission();
    var token = await firebaseMessaging.getToken();
    _configLocalNotification();
    _produceMessageListener();
    PadongFB.updateDoc('user', Session.user.id, {'notificationToken': token});
  }
}