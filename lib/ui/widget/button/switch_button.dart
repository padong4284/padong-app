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
import 'package:padong/ui/shared/types.dart';
import 'package:padong/ui/widget/container/tip_container.dart';

class SwitchButton extends StatelessWidget {
  final List<String> options;
  final SwitchButtonType buttonType; // BORDER, SHADOW, TOOLTIP
  final bool cancelAble;
  final int initIdx;
  final void Function(String selected) onChange;

  SwitchButton(
      {@required this.options,
      buttonType,
      this.onChange,
      this.initIdx = 0,
      this.cancelAble = false})
      : this.buttonType = buttonType ?? SwitchButtonType.BORDER;

  @override
  Widget build(BuildContext context) {
    SwitchButtonBase button = SwitchButtonBase(
        options: this.options,
        buttonType: this.buttonType,
        onChange: this.onChange,
        initIdx: this.initIdx,
        cancelAble: this.cancelAble);
    if (this.buttonType == SwitchButtonType.TOOLTIP)
      return TipContainer(width: 140, child: button);
    return button;
  }
}

class SwitchButtonBase extends StatefulWidget {
  final List<String> options;
  final SwitchButtonType buttonType; // BORDER, SHADOW, TOOLTIP
  final bool cancelAble;
  final int initIdx;
  final void Function(String option) onChange;

  SwitchButtonBase(
      {@required this.options,
      this.buttonType,
      this.onChange,
      this.initIdx,
      this.cancelAble = false});

  @override
  _SwitchButtonBaseState createState() => _SwitchButtonBaseState();
}

class _SwitchButtonBaseState extends State<SwitchButtonBase> {
  int curIdx;

  @override
  void initState() {
    super.initState();
    this.curIdx = widget.initIdx;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: AppTheme.colors.base,
            border: Border.all(
                color: widget.buttonType == SwitchButtonType.BORDER
                    ? AppTheme.colors.primary
                    : AppTheme.colors.transparent,
                width: 1),
            borderRadius: BorderRadius.all(Radius.circular(20)),
            boxShadow: widget.buttonType == SwitchButtonType.SHADOW
                ? [
                    BoxShadow(
                        color: Colors.black12,
                        blurRadius: 5.0,
                        spreadRadius: 0.0,
                        offset: Offset(0.0, 0.0))
                  ]
                : []),
        height: 40.0,
        width: widget.options.length == 2 ? 140 : 210,
        padding: const EdgeInsets.all(0),
        child: Stack(children: [
          AnimatedPositioned(
            child: Container(
                decoration: BoxDecoration(
                    color: AppTheme.colors.primary,
                    borderRadius: BorderRadius.circular(15)),
                width: this.curIdx >= 0 ? 70 : 0,
                height: 30),
            duration: Duration(milliseconds: 200),
            top: 4,
            left: 5 + this.curIdx * (widget.options.length == 2 ? 59.0 : 64.0),
          ),
          Padding(
              padding: const EdgeInsets.only(left: 5, right: 5),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(
                    widget.options.length,
                    (idx) => InkWell(
                        onTap: () {
                          setState(() {
                            if (widget.cancelAble && this.curIdx == idx) {
                              this.curIdx = -1;
                            } else
                              this.curIdx = idx;
                          });
                          if (widget.onChange != null)
                            widget.onChange(
                                idx >= 0 ? widget.options[idx] : null);
                        },
                        child: Container(
                          width: widget.options.length == 2 ? 55.0 : 65.0,
                          height: 38,
                          alignment: Alignment.center,
                          child: Text(widget.options[idx],
                              style: TextStyle(
                                  color: this.curIdx == idx
                                      ? AppTheme.colors.base
                                      : AppTheme.colors.primary,
                                  fontSize: AppTheme.fontSizes.small)),
                        )),
                  )))
        ]));
  }
}
