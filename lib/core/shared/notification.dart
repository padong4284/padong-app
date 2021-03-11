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
import 'package:padong/core/node/common/subscribe.dart';
import 'package:padong/core/node/common/user.dart';
import 'package:padong/core/node/node.dart';

mixin Notification on Node {
  bool isSubscribed(User me) {
    // TODO: get user's Alert setting
    return false;
  }

  void updateSubscribe(User me, bool isSubscribed) {
    // TODO: update user's Subscribe setting
    Subscribe.fromMap('', {});
  }
}