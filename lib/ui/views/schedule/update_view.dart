import 'package:flutter/material.dart';
import 'package:padong/core/models/pip.dart';
import 'package:padong/core/padong_router.dart';
import 'package:padong/ui/shared/types.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/widgets/inputs/appending_input.dart';
import 'package:padong/ui/widgets/inputs/list_picker.dart';
import 'package:padong/ui/widgets/inputs/times/date_time_range_picker.dart';
import 'package:padong/ui/widgets/inputs/times/day_time_range_picker.dart';
import 'package:padong/ui/widgets/title_header.dart';
import 'package:padong/ui/widgets/paddong_markdown.dart';
import 'package:padong/ui/widgets/bars/back_app_bar.dart';
import 'package:padong/ui/widgets/buttons/button.dart';
import 'package:padong/ui/widgets/buttons/switch_button.dart';
import 'package:padong/ui/widgets/inputs/input.dart';
import 'package:padong/ui/widgets/inputs/markdown_supporter.dart';
import 'package:padong/ui/views/templates/safe_padding_template.dart';

const List<String> routines = ['Annual', 'Monthly', 'Weekly'];

class UpdateView extends StatefulWidget {
  final String id;

  UpdateView(this.id);

  @override
  _UpdateViewState createState() => _UpdateViewState();
}

class _UpdateViewState extends State<UpdateView> {
  String routine;
  bool isLecture = false;
  TextEditingController _titleController = TextEditingController();
  TextEditingController _contentController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafePaddingTemplate(
        appBar: BackAppBar(
            isClose: true,
            switchButton: this.lectureSwitch(),
            actions: [
              Button(
                  title: 'Ok',
                  buttonSize: ButtonSize.SMALL,
                  borderColor: AppTheme.colors.primary,
                  callback: this.onTabOk,
                  shadow: false)
            ]),
        children: [
          this.topArea(),
          Input(
              controller: this._titleController,
              hintText: 'Title of ${this.isLecture ? 'Lecture' : 'Event'}',
              type: InputType.UNDERLINE),
          Input(
              controller: this._contentController,
              hintText:
                  'Plain text Content\nDo not support Markdown\n\n\n\n\n\n',
              type: InputType.PLAIN),
          ...(this.isLecture ? [] : []),
          SizedBox(height: 40),
          TitleHeader('Time', isInputHead: true),
          this.routine == routines[2] || this.isLecture
              ? AppendingInput(input: () => DayTimeRangePicker())
              : AppendingInput(input: () => DateTimeRangePicker()),
          ...this.bottomInputs()
        ]);
  }

  Widget lectureSwitch() {
    return SwitchButton(
        options: ['event', 'lecture'],
        onChange: (String selected) {
          setState(() {
            this.isLecture = selected == 'lecture';
          });
        });
  }

  Widget topArea() {
    return Container(
        height: 55,
        alignment: Alignment.centerLeft,
        child: this.isLecture
            ? Input(hintText: 'Professor')
            : SwitchButton(
                options: routines,
                buttonType: SwitchButtonType.SHADOW,
                initIdx: -1,
                cancelAble: true,
                onChange: (String selected) {
                  setState(() {
                    this.routine = selected;
                  });
                }));
  }

  List<Widget> bottomInputs() {
    return [SizedBox(height: 70), TitleHeader('Alert', isInputHead: true)];
  }

  void onTabOk() {
    Map data = {
      'title': this._titleController.text,
      'description': this._contentController.text,
    };
    if (!this.isLecture) data['routine'] = this.routine ?? 'none';
    // TODO: call create API
    PadongRouter.goBack();
    // TODO: show dialog or snackBar to alert submit complete
  }
}
