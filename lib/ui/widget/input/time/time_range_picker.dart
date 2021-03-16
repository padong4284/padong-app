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
import 'package:padong/ui/widget/input/list_picker.dart';
import 'package:padong/ui/widget/input/time/time_list_picker.dart';

class TimeRangePicker extends TimeListPicker {
  final String hintText;
  final int minuteGap;
  final int initStartHour;
  final int initFinishHour;
  final TextEditingController controller;

  TimeRangePicker(this.controller,
      {this.hintText = 'Start ~ Finish',
      this.minuteGap = 1,
      this.initStartHour = 0,
      this.initFinishHour = 23})
      : super(controller, hintText: hintText, minuteGap: minuteGap);

  @override
  Widget build(BuildContext context) {
    return ListPicker.multiple(
      this.controller,
      hintText: this.hintText,
      lists: this.getTimeRange(),
      initIdxs: this.getInitIdxs(),
      separators: [':', ' ', ' ', ':'],
      titles: ['Start', ' ', 'End'],
    );
  }

  List<List> getTimeRange() {
    return [
      ...this.getHourNMinute(),
      ['~'],
      ...this.getHourNMinute()
    ];
  }

  List<int> getInitIdxs() {
    return [
      this.initStartHour,
      30 ~/ this.minuteGap,
      0,
      this.initFinishHour,
      30 ~/ this.minuteGap
    ];
  }
}
