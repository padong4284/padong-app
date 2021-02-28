import 'package:flutter/material.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/widgets/inputs/list_picker.dart';
import 'package:padong/ui/widgets/inputs/times/time_range_picker.dart';

class DateTimeRangePicker extends TimeRangePicker {
  final String hintText;
  final int minuteGap;
  final int initStartHour;
  final int initFinishHour;

  DateTimeRangePicker(
      {this.hintText = 'Date | Start ~ Finish',
      this.minuteGap = 1,
      this.initStartHour = 0,
      this.initFinishHour = 23})
      : super(hintText: hintText, minuteGap: minuteGap);

  @override
  Widget build(BuildContext context) {
    return ListPicker.multiple(
      hintText: this.hintText,
      lists: [...this.getTimeRange()],
      initIdxs: [...this.getInitIdxs()],
      separators: [':', ' ', ' ', ':'],
      titles: ['Start', ' ', 'Finish'],
      beforePick: this.pickDate,
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
    if (date != null) update(date.toString().split(' ')[0]);
    else update(DateTime.now().toString().split(' ')[0]);
  }
}
