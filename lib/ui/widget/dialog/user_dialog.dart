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
import 'package:padong/core/node/common/user.dart';
import 'package:padong/ui/widget/button/button.dart';
import 'package:padong/ui/widget/dialog/base_dialog.dart';

class UserDialog extends StatelessWidget {
  final User user;

  UserDialog(this.user);

  static void show(BuildContext context, User user) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return UserDialog(user);
        });
  }

  @override
  Widget build(BuildContext context) {
    return BaseDialog(
      children: [],
      actions: [
        this.user.isVerified
            ? Button(
                'Revoke Verification',
                onTap: () {
                  // TODO: ask do you really want
                  this.user.isVerified = false;
                  this.user.update();
                },
              )
            : SizedBox.shrink(),
        SizedBox(height: 5),
        Button('Withdraw', onTap: () {
          // TODO: Remove User node, Remove user data
          // TODO: ProfileButton with withdrawn user or friends
        }),
      ],
    );
  }
}
