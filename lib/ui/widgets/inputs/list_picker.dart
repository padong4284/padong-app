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
import 'package:flutter/cupertino.dart';
import 'package:padong/ui/shared/types.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/widgets/buttons/transp_button.dart';
import 'package:padong/ui/widgets/inputs/input.dart';

final hPadding = AppTheme.horizontalPadding + 20;

class ListPicker extends StatefulWidget {
  final String hintText;
  final bool looping;
  final List<List> lists;
  final List<int> initIdxs;
  final List<String> separators;
  final List<String> titles;
  final EdgeInsets margin;
  final Function beforePick;
  final TextEditingController controller;

  ListPicker(this.controller,
      {this.hintText,
      @required List list,
      String title,
      int initIdx,
      this.beforePick,
      this.looping = false,
      this.margin})
      : assert(list != null && list.length > 0),
        assert(initIdx == null || list.length > initIdx),
        this.lists = <List>[list],
        this.initIdxs = initIdx != null ? [initIdx] : null,
        this.separators = null,
        this.titles = [title];

  ListPicker.multiple(this.controller,
      {this.hintText,
      @required List<List> lists,
      List<String> separators,
      List<String> titles,
      List<int> initIdxs,
      this.beforePick,
      this.looping = false,
      this.margin})
      : assert(initIdxs == null || (lists.length == initIdxs.length)),
        assert(separators == null || (lists.length == separators.length + 1)),
        this.lists = lists,
        this.initIdxs = initIdxs,
        this.separators = separators,
        this.titles = titles ?? [];

  @override
  _ListPickerState createState() => new _ListPickerState();
}

class _ListPickerState extends State<ListPicker> {
  List selectedIdxs;
  String beforePickInfo = '';

  @override
  void initState() {
    super.initState();
    this.beforePickInfo = '';
    this.selectedIdxs =
        widget.initIdxs ?? List.generate(widget.lists.length, (_) => 0);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          this.showPicker(context);
        },
        child: Input(
          hintText: widget.hintText,
          enabled: false,
          toNext: false,
          margin: widget.margin,
          controller: widget.controller,
          onPressIcon: () {
            this.showPicker(context);
          },
          icon: Icon(Icons.expand_more_rounded,
              color: AppTheme.colors.primary, size: 30),
        ));
  }

  void showPicker(BuildContext context) async {
    int len = widget.lists.length;
    if (widget.beforePick != null)
      await widget.beforePick(
          context,
          (info) => setState(() {
                this.beforePickInfo = info;
              }));
    this.setText(0, this.selectedIdxs[0]);
    showCupertinoModalPopup(
        context: context,
        useRootNavigator: true,
        builder: (_) => Stack(children: [
              Container(
                  height: 250.0 + (widget.titles.length > 0 ? 50 : 0),
                  color: AppTheme.colors.base,
                  padding:
                      EdgeInsets.only(top: 40, left: hPadding, right: hPadding),
                  child: Row(
                    children: List.generate(
                        len,
                        (listIdx) => Expanded(
                                child: CupertinoPicker(
                              looping: widget.looping,
                              itemExtent: 35,
                              scrollController: FixedExtentScrollController(
                                  initialItem: widget.initIdxs != null
                                      ? widget.initIdxs[listIdx]
                                      : -1),
                              children: widget.lists[listIdx]
                                  .map((elm) =>
                                      Center(child: Text(elm.toString())))
                                  .toList(),
                              onSelectedItemChanged: (idx) {
                                this.setText(listIdx, idx);
                              },
                            ))), // Add other Lists
                  )),
              this.topArea()
            ]));
  }

  Widget topArea() {
    return Stack(children: [
      Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TranspButton(
                  title: 'CANCEL',
                  buttonSize: ButtonSize.LARGE,
                  callback: () {
                    widget.controller.text = '';
                    Navigator.pop(context);
                  }),
              TranspButton(
                  title: 'OK',
                  buttonSize: ButtonSize.LARGE,
                  callback: () => Navigator.pop(context))
            ],
          )),
      widget.titles.length > 0
          ? Padding(
              padding: const EdgeInsets.only(top: 45), child: this.titleArea())
          : SizedBox.shrink()
    ]);
  }

  Widget titleArea() {
    return Container(
        height: 40,
        color: AppTheme.colors.base,
        padding: EdgeInsets.only(bottom: 10, left: hPadding, right: hPadding),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: widget.titles
                .where((title) => title != null)
                .map((title) => Text(
                      title,
                      style: AppTheme.getFont(
                          color: AppTheme.colors.semiPrimary,
                          fontSize: AppTheme.fontSizes.large),
                    ))
                .toList()));
  }

  void setText(int listIdx, int idx) {
    int len = this.selectedIdxs.length;
    setState(() {
      this.selectedIdxs[listIdx] = idx;
      String current = this.beforePickInfo;
      if (current.length > 0) current += ' | ';
      for (int i = 0; i < len; i++)
        current += widget.lists[i][this.selectedIdxs[i]].toString() +
            (i != len - 1
                ? (widget.separators != null ? widget.separators[i] : ' ')
                : '');
      widget.controller.text = current;
    });
  }
}
