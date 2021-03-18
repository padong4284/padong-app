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
import 'package:padong/ui/template/safe_padding_template.dart';
import 'package:padong/ui/widget/bar/back_app_bar.dart';
import 'package:padong/ui/widget/container/spinner.dart';

class ForgotView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafePaddingTemplate(
      appBar: BackAppBar(title: 'Forgot'),
      children: [
        Center(
            child: Spinner(
          radius: 150,
          actions: [
            Icon(Icons.home, size: 50),
            Icon(Icons.wysiwyg, size: 50),
            Icon(Icons.book, size: 50)
          ],
          actionSize: 50,
          padding: 20,
          resistance: 0.7,
        ))
      ],
    );
  }
}
