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
import 'package:padong/core/apis/session.dart' as Session;

void updateRelationAPI(String userId, int relation) {
  // relation 0: friend, 1: received, 2: send, 3: none
}

void signOutAPI() {
  // Session refresh
}

void updateProfileAPI(Map<String, dynamic> data) {
  Session.user = {
    ...Session.user,
    ...data
  };
  print(Session.user);
}

void updatePasswordAPI(String password) {}