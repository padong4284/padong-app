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
import 'package:padong/core/node/node.dart';
import 'package:padong/core/node/schedule/event.dart';
import 'package:padong/core/node/schedule/lecture.dart';
import 'package:padong/core/node/schedule/schedule.dart';
import 'package:padong/core/padong_router.dart';
import 'package:padong/core/service/session.dart';
import 'package:padong/core/shared/types.dart';
import 'package:padong/ui/shared/types.dart';
import 'package:padong/ui/template/safe_padding_template.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/widget/bar/back_app_bar.dart';
import 'package:padong/ui/widget/button/button.dart';
import 'package:padong/ui/widget/button/switch_button.dart';
import 'package:padong/ui/widget/component/title_header.dart';
import 'package:padong/ui/widget/input/appending_input.dart';
import 'package:padong/ui/widget/input/input.dart';
import 'package:padong/ui/widget/input/time/date_time_range_picker.dart';
import 'package:padong/ui/widget/input/time/day_time_range_picker.dart';
import 'package:padong/ui/widget/input/time/time_list_picker.dart';
import 'package:padong/util/time_manager.dart';

class UpdateView extends StatefulWidget {
  final Node node;

  UpdateView(this.node);

  @override
  _UpdateViewState createState() => _UpdateViewState();
}

class _UpdateViewState extends State<UpdateView> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _contentController = TextEditingController();
  TextEditingController _professorController = TextEditingController();
  AppendsController _timeController = AppendsController();
  AppendsController _alertController = AppendsController();
  Map<String, TextEditingController> _lectureInfoControllers = {};

  Schedule schedule;
  Event event;
  Lecture lecture;
  bool isEditing = false;

  String routine;
  bool isLecture = false;
  int initRoutine = -1;

  @override
  void initState() {
    super.initState();
    for (String info in ['Room', 'Grade', 'Exam', 'Attendance', 'Book'])
      this._lectureInfoControllers[info] = TextEditingController();
    if (widget.node.type == 'schedule')
      this.schedule = widget.node as Schedule;
    else {
      this.isEditing = true;
      if (widget.node.type == 'event')
        this.editEvent();
      else
        this.editLecture();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafePaddingTemplate(
        appBar: BackAppBar(
            isClose: true,
            switchButton: this.isEditing ? null : this.lectureSwitch(),
            actions: [
              Button('Ok',
                  buttonSize: ButtonSize.SMALL,
                  borderColor: AppTheme.colors.primary,
                  onTap: this.onTabOk,
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
              options: PERIODICITYS.sublist(0, 3),
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
    return this.routine == PERIODICITYS[2] || this.isLecture
        ? [
            AppendingInput(this._timeController,
                initialized: this.isEditing,
                input: (ctrl) => DayTimeRangePicker(ctrl)),
            SizedBox.shrink()
          ]
        : [
            SizedBox.shrink(),
            AppendingInput(this._timeController,
                initialized: this.isEditing,
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
    this.event = widget.node as Event;
    this._titleController.text = this.event.title;
    this._contentController.text = this.event.description;
    this.initRoutine = PERIODICITY.values.indexOf(this.event.periodicity);
    this._timeController.list =
        this.event.times.map((tm) => tm.toString()).toList();
    this._alertController.list = this.event.alerts;
  }

  void editLecture() {
    this.isLecture = true;
    this.lecture = widget.node as Lecture;
    this._titleController.text = this.lecture.title;
    this._contentController.text = this.lecture.description;
    this._professorController.text = this.lecture.professor;
    this._timeController.list =
        this.lecture.times.map((tm) => tm.toString()).toList();
    Map<String, dynamic> _infos = this.lecture.toJson();
    for (String info in ['Room', 'Grade', 'Exam', 'Attendance', 'Book'])
      this._lectureInfoControllers[info].text = _infos[info.toLowerCase()];
  }

  void onTabOk() async {
    Map data = {
      'pip': PIP.INTERNAL,
      'ownerId': Session.user.id,
      'title': this._titleController.text,
      'description': this._contentController.text,
    };

    data['times'] = this._timeController.list;
    if (this.isLecture) {
      data['professor'] = this._professorController.text;
      for (String info in this._lectureInfoControllers.keys)
        data[info.toLowerCase()] = this._lectureInfoControllers[info].text;
    } else {
      data['periodicity'] = parsePERIODICITY(this.routine ?? 'none');
      data['alerts'] = <String>[...this._alertController.list];
    }

    if (this.isEditing) {
      data['times'] = this
          ._timeController
          .list
          .map((time) => TimeManager.fromString(time))
          .toList();
      Event _edited = this.isLecture ? this.lecture : this.event;
      _edited.setDataWithMap(data);
      _edited.update();
    } else {
      data['pip'] = 'Internal';
      data['parentId'] = this.isLecture ? this.schedule.id : Session.user.id;
      Event _event = await [Event(), Lecture()][this.isLecture ? 1 : 0]
          .generateFromMap('', data)
          .create();

      if (this.isLecture) {
        Session.user.lectureIds.add(_event.id);
        Session.user.update();
      }
    }
    PadongRouter.goBack();
  }
}
