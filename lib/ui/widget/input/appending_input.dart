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

class AppendsController {
  List<TextEditingController> ctrls;

  AppendsController() : this.ctrls = [];

  void init() => this.ctrls = [];

  void add(TextEditingController ctrl) => this.ctrls.add(ctrl);

  void removeAt(int idx) => this.ctrls.removeAt(idx);

  List get list => Set.from(this.ctrls.map((ctrl) => ctrl.text))
      .where((elm) => elm.length > 0)
      .toList();

  set list(List texts) {
    this.ctrls = [];
    for (String text in texts) {
      TextEditingController ctrl = TextEditingController();
      ctrl.text = text;
      this.ctrls.add(ctrl);
    }
  }
}

// only last one is + else x
class AppendingInput extends StatefulWidget {
  final bool initialized;
  final AppendsController controller;
  final Widget Function(TextEditingController ctrl) input;

  AppendingInput(this.controller,
      {@required this.input, this.initialized = false});

  @override
  _AppendingInputState createState() => _AppendingInputState();
}

class _AppendingInputState extends State<AppendingInput> {
  List<Widget> inputs = [];

  @override
  void initState() {
    super.initState();
    if (widget.initialized) {
      for (TextEditingController ctrl in widget.controller.ctrls)
        this.inputs.add(widget.input(ctrl));
    } else {
      widget.controller.init();
      TextEditingController ctrl = TextEditingController();
      this.inputs.add(widget.input(ctrl));
      widget.controller.add(ctrl);
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width -
        2 * (AppTheme.horizontalPadding + 30);
    return Column(
        children:
            this.inputs.map((input) => this.getLine(width, input)).toList());
  }

  Widget getLine(double width, Widget input) {
    int idx = this.inputs.indexOf(input);
    return new Row(children: [
      Container(width: width, child: input),
      Container(
          margin: const EdgeInsets.only(left: 10),
          child: IconButton(
            iconSize: 30,
            icon: Icon(
                this.inputs.length - 1 == idx
                    ? Icons.add_rounded
                    : Icons.remove_rounded,
                color: AppTheme.colors.primary),
            onPressed: this.reLine(idx),
          ))
    ]);
  }

  Function reLine(int idx) {
    return () => this.setState(() {
          if (this.inputs.length - 1 == idx) {
            TextEditingController ctrl = TextEditingController();
            widget.controller.add(ctrl);
            this.inputs.add(widget.input(ctrl));
          } else {
            this.inputs.removeAt(idx);
            widget.controller.removeAt(idx);
          }
        });
  }
}
