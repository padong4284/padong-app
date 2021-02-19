import 'package:flutter/material.dart';
import 'package:padong/ui/widgets/inputs/list_picker.dart';

class TimeListPicker extends StatelessWidget {
  final String hintText;
  final int minuteGap;

  TimeListPicker({this.hintText, this.minuteGap = 1});

  @override
  Widget build(BuildContext context) {
    return ListPicker.multiple(
      hintText: this.hintText,
      lists: [
        Iterable<int>.generate(24)
            .map((h) => this.numFormatting(h + 1))
            .toList(),
        Iterable<int>.generate(60 ~/ this.minuteGap)
            .map((m) => this.numFormatting(m * this.minuteGap))
            .toList()
      ],
      initIdxs: [8, 30 ~/ this.minuteGap],
      separators: [':'],
    );
  }

  String numFormatting(int num) {
    String numStr = num.toString();
    if (numStr.length == 2)
      return numStr;
    else
      return '0' + numStr;
  }
}
