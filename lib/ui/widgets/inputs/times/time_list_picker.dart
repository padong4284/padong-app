import 'package:flutter/material.dart';
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
      List.generate(24, this.numFormatting),
      List.generate(60 ~/ this.minuteGap,
          (m) => this.numFormatting(m * this.minuteGap))
    ];
  }

  String numFormatting(int num) {
    String numStr = num.toString();
    if (numStr.length == 2)
      return numStr;
    else
      return '0' + numStr;
  }
}
