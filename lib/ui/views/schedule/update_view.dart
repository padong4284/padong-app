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

const List<String> ROUTINES = ['Annually', 'Monthly', 'Weekly'];

class UpdateView extends StatefulWidget {
  final String id; // scheduleId
  final String eventId;
  final String lectureId;
  final bool isEditing;

  UpdateView(this.id, {this.eventId, this.lectureId})
      : assert((eventId == null) || (lectureId == null)),
        this.isEditing = (eventId != null) || (lectureId != null);

  @override
  _UpdateViewState createState() => _UpdateViewState();
}

class _UpdateViewState extends State<UpdateView> {
  String routine;
  bool isLecture = false;
  int initRoutine = -1;
  TextEditingController _titleController = TextEditingController();
  TextEditingController _contentController = TextEditingController();
  TextEditingController _professorController = TextEditingController();
  AppendsController _timeController = AppendsController();
  AppendsController _alertController = AppendsController();
  Map<String, TextEditingController> _lectureInfoControllers = {};

  @override
  void initState() {
    super.initState();
    for (String info in ['Room', 'Grade', 'Exam', 'Attendance', 'Book'])
      this._lectureInfoControllers[info] = TextEditingController();
    if (widget.lectureId != null)
      this.editLecture();
    else if (widget.eventId != null) this.editEvent();
  }

  @override
  Widget build(BuildContext context) {
    return SafePaddingTemplate(
        appBar: BackAppBar(
            isClose: true,
            switchButton: widget.isEditing ? null : this.lectureSwitch(),
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
          ...this.timeInput(),
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
          ? Input(hintText: 'Professor', controller: this._professorController)
          : SwitchButton(
              options: ROUTINES,
              buttonType: SwitchButtonType.SHADOW,
              initIdx: this.initRoutine,
              cancelAble: true,
              onChange: (String selected) {
                setState(() {
                  this.routine = selected;
                });
              }),
    );
  }

  List<Widget> timeInput() {
    return this.routine == ROUTINES[2] || this.isLecture
        ? [
            AppendingInput(this._timeController,
                initialized: widget.isEditing,
                input: (ctrl) => DayTimeRangePicker(ctrl)),
            SizedBox.shrink()
          ]
        : [
            SizedBox.shrink(),
            AppendingInput(this._timeController,
                initialized: widget.isEditing,
                input: (ctrl) => DateTimeRangePicker(ctrl))
          ];
  }

  List<Widget> bottomInputs() {
    return [
      SizedBox(height: 70),
      TitleHeader('Alert', isInputHead: true),
      ...(this.isLecture
          ? this._lectureInfoControllers.keys.map((info) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Input(
                hintText: info,
                controller: this._lectureInfoControllers[info],
              )))
          : [
              AppendingInput(this._alertController,
                  input: (ctrl) =>
                      TimeListPicker(ctrl, hintText: 'Alert', minuteGap: 5))
            ])
    ];
  }

  void editEvent() {
    Map event = getEventAPI(widget.eventId);
    this._titleController.text = event['title'];
    this._contentController.text = event['description'];
    this.initRoutine = ROUTINES.indexOf(event['periodicity']);
    this._timeController.list = event['times'];
    this._alertController.list = event['alerts'];
  }

  void editLecture() {
    this.isLecture = true;
    Map lecture = getLectureAPI(widget.lectureId);
    this._titleController.text = lecture['title'];
    this._contentController.text = lecture['description'];
    this._professorController.text = lecture['professor'];
    this._timeController.list = lecture['times'];
    for (String info in ['Room', 'Grade', 'Exam', 'Attendance', 'Book'])
      this._lectureInfoControllers[info].text = lecture[info];
  }

  void onTabOk() {
    Map data = {
      'title': this._titleController.text,
      'description': this._contentController.text,
    };
    data['times'] = this._timeController.list;
    if (this.isLecture) {
      data['professor'] = this._professorController.text;
      for (String info in this._lectureInfoControllers.keys)
        data[info] = this._lectureInfoControllers[info].text;
    } else {
      data['periodicity'] = this.routine ?? 'none';
      data['alerts'] = this._alertController.list;
    }
    if (widget.isEditing) {
      data['id'] = widget.lectureId ?? widget.eventId;
      updateEventAPI(data);
    } else
      createEventAPI(data); // TODO: edit or create
    PadongRouter.goBack();
    // TODO: show dialog or snackBar to alert submit complete
  }
}
