import 'package:flutter/material.dart';
import 'package:padong/ui/utils/time_manager.dart';
import 'package:padong/ui/widgets/inputs/list_picker.dart';

class TimeListPicker extends StatelessWidget {
  final String hintText;
  final int minuteGap;
  final int initHour;

  TimeListPicker({this.hintText, this.minuteGap = 1, this.initHour = 8});

  @override
  Widget build(BuildContext context) {
    return ListPicker.multiple(
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
