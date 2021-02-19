import 'package:flutter/material.dart';
import 'package:padong/ui/widgets/inputs/list_picker.dart';
import 'package:padong/ui/widgets/inputs/time_list_picker.dart';

class TimeRangePicker extends TimeListPicker {
  final String hintText;
  final int minuteGap;
  final int initStartHour;
  final int initFinishHour;

  TimeRangePicker(
      {this.hintText = 'Start ~ Finish',
      this.minuteGap = 1,
      this.initStartHour = 0,
      this.initFinishHour = 23})
      : super(hintText: hintText, minuteGap: minuteGap);

  @override
  Widget build(BuildContext context) {
    return ListPicker.multiple(
      hintText: this.hintText,
      lists: [...this.getHourNMinute(), ['~'], ...this.getHourNMinute()],
      initIdxs: [
        this.initStartHour,
        30 ~/ this.minuteGap,
        0,
        this.initFinishHour,
        30 ~/ this.minuteGap
      ],
      separators: [':', ' ', ' ', ':'],
      titles: ['Start', ' ', 'Finish'],
    );
  }
}
