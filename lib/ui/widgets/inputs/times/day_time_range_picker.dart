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
import 'package:padong/ui/widgets/inputs/list_picker.dart';
import 'package:padong/ui/widgets/inputs/times/time_range_picker.dart';

class DayTimeRangePicker extends TimeRangePicker {
  final String hintText;
  final int minuteGap;
  final int initStartHour;
  final int initFinishHour;
  final TextEditingController controller;

  DayTimeRangePicker(this.controller,
      {this.hintText = 'Day | Start ~ Finish',
      this.minuteGap = 1,
      this.initStartHour = 0,
      this.initFinishHour = 23})
      : super(controller, hintText: hintText, minuteGap: minuteGap);

  @override
  Widget build(BuildContext context) {
    return ListPicker.multiple(
      this.controller,
      hintText: this.hintText,
      lists: [
        ['Mon', 'Tue', 'Wed', 'Thu', 'Fri'],
        ...this.getTimeRange()
      ],
      initIdxs: [0, ...this.getInitIdxs()],
      separators: [' | ', ':', ' ', ' ', ':'],
      titles: [' ', 'Start', ' ', 'End'],
    );
  }
}
