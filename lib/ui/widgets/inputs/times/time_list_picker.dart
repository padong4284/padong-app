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
import 'package:padong/ui/utils/time_manager.dart';
import 'package:padong/ui/widgets/inputs/list_picker.dart';

class TimeListPicker extends StatelessWidget {
  final String hintText;
  final int minuteGap;
  final int initHour;
  final TextEditingController controller;

  TimeListPicker(this.controller,
      {this.hintText, this.minuteGap = 1, this.initHour = 8});

  @override
  Widget build(BuildContext context) {
    return ListPicker.multiple(
      this.controller,
      hintText: this.hintText,
      lists: this.getHourNMinute(),
      initIdxs: [this.initHour, 30 ~/ this.minuteGap],
      separators: [':'],
    );
  }

  List<List> getHourNMinute() {
    return [
      List.generate(24, TimeManager.formatHM),
      List.generate(
          60 ~/ this.minuteGap, (m) => TimeManager.formatHM(m * this.minuteGap))
    ];
  }
}
