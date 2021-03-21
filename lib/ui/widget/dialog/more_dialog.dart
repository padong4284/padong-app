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
import 'package:padong/ui/widget/dialog/base_dialog.dart';

class MoreDialog extends StatelessWidget {
  static void show(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return MoreDialog();
        });
  }

  @override
  Widget build(BuildContext context) {
    return BaseDialog(

    );
  }
}
