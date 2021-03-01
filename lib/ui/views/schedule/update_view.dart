import 'package:flutter/material.dart';
import 'package:padong/core/apis/schedule.dart';
import 'package:padong/core/padong_router.dart';
import 'package:padong/ui/shared/types.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/widgets/inputs/appending_input.dart';
import 'package:padong/ui/widgets/inputs/times/date_time_range_picker.dart';
import 'package:padong/ui/widgets/inputs/times/day_time_range_picker.dart';
import 'package:padong/ui/widgets/inputs/times/time_list_picker.dart';
import 'package:padong/ui/widgets/title_header.dart';
import 'package:padong/ui/widgets/bars/back_app_bar.dart';
import 'package:padong/ui/widgets/buttons/button.dart';
import 'package:padong/ui/widgets/buttons/switch_button.dart';
import 'package:padong/ui/widgets/inputs/input.dart';
import 'package:padong/ui/views/templates/safe_padding_template.dart';

const List<String> routines = ['Annually', 'Monthly', 'Weekly'];

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
  AppendsController _timeController = AppendsController();
  AppendsController _alertController = AppendsController();

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
              hintText: 'Plain text Content\nNot support Markdown' + '\n' * 6,
              type: InputType.PLAIN),
          ...(this.isLecture ? [] : []),
          SizedBox(height: 40),
          TitleHeader('Time', isInputHead: true),
          ...(this.routine == routines[2] || this.isLecture
              ? [
                  new AppendingInput(this._timeController,
                      input: (ctrl) => DayTimeRangePicker(ctrl)),
                  SizedBox.shrink()
                ]
              : [
                  SizedBox.shrink(),
                  new AppendingInput(this._timeController,
                      input: (ctrl) => DateTimeRangePicker(ctrl))
                ]),
          ...this.bottomInputs()
        ]);
  }

  Widget lectureSwitch() {
    return SwitchButton(
        options: ['event', 'lecture'],
        onChange: (String selected) {
          setState(() {
            this.isLecture = selected == 'lecture';
            this.routine = null;
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
    return [
      SizedBox(height: 70),
      TitleHeader('Alert', isInputHead: true),
      ...(this.isLecture
          ? ['Room', 'Grade', 'Exam', 'Attendance', 'Book'].map((hint) =>
              Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Input(hintText: hint)))
          : [
              AppendingInput(this._alertController,
                  input: (ctrl) =>
                      TimeListPicker(ctrl, hintText: 'Alert', minuteGap: 5))
            ])
    ];
  }

  void onTabOk() {
    Map data = {
      'title': this._titleController.text,
      'description': this._contentController.text,
    };
    if (this.isLecture)
      data['professor'] = '';
    else
      data['periodicity'] = this.routine ?? 'none';

    print(this._alertController.getList());
    createEventAPI(data);
    PadongRouter.goBack();
    // TODO: show dialog or snackBar to alert submit complete
  }
}
