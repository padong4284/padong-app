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
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/widget/input/list_picker.dart';
import 'package:padong/ui/widget/input/time/time_range_picker.dart';

class DateTimeRangePicker extends TimeRangePicker {
  final String hintText;
  final int minuteGap;
  final int initStartHour;
  final int initFinishHour;
  final TextEditingController controller;

  DateTimeRangePicker(this.controller,
      {this.hintText = 'Date | Start ~ Finish',
      this.minuteGap = 1,
      this.initStartHour = 0,
      this.initFinishHour = 23})
      : super(controller, hintText: hintText, minuteGap: minuteGap);

  @override
  Widget build(BuildContext context) {
    return ListPicker.multiple(
      this.controller,
      hintText: this.hintText,
      lists: [...this.getTimeRange()],
      initIdxs: [...this.getInitIdxs()],
      separators: [':', ' ', ' ', ':'],
      titles: ['Start', ' ', 'End'],
      beforePick: this.pickDate,
      formator: this.orderRange,
    );
  }

  void pickDate(BuildContext context, Function(String) update) async {
    DateTime date = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(DateTime.now().year - 5),
        lastDate: DateTime(DateTime.now().year + 5),
        builder: (BuildContext context, Widget child) {
          return Theme(
              data: ThemeData.light().copyWith(
                  primaryColor: AppTheme.colors.primary,
                  accentColor: AppTheme.colors.primary,
                  backgroundColor: AppTheme.colors.base,
                  highlightColor: AppTheme.colors.primary,
                  splashColor: AppTheme.colors.primary,
                  colorScheme: ColorScheme.dark(
                    primary: AppTheme.colors.primary,
                    onPrimary: AppTheme.colors.base,
                    surface: AppTheme.colors.base,
                    background: AppTheme.colors.base,
                    onSurface: AppTheme.colors.support,
                  )),
              child: child);
        });
    if (date != null)
      update(date.toString().split(' ')[0]);
    else
      update(DateTime.now().toString().split(' ')[0]);
  }
}
