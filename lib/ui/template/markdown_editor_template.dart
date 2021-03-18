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
import 'package:padong/core/service/session.dart';
import 'package:padong/core/shared/constants.dart';
import 'package:padong/core/shared/types.dart';
import 'package:padong/core/padong_router.dart';
import 'package:padong/ui/shared/types.dart';
import 'package:padong/ui/template/safe_padding_template.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/widget/bar/back_app_bar.dart';
import 'package:padong/ui/widget/button/button.dart';
import 'package:padong/ui/widget/button/switch_button.dart';
import 'package:padong/ui/widget/component/title_header.dart';
import 'package:padong/ui/widget/input/input.dart';
import 'package:padong/ui/widget/input/markdown_supporter.dart';
import 'package:padong/ui/widget/padong_markdown.dart';

class MarkdownEditorTemplate extends StatefulWidget {
  final List<Widget> children;
  final bool withAnonym;
  final Widget topArea;
  final String editTxt;
  final String titleHint;
  final String contentHint;
  final String title;
  final String content;
  final PIP initPIP;
  final Function(Map) onSubmit;

  MarkdownEditorTemplate({
    this.children,
    this.withAnonym = false,
    this.editTxt = 'make',
    this.topArea,
    this.titleHint = 'Title of Board',
    this.contentHint,
    this.title,
    this.content,
    this.initPIP,
    @required this.onSubmit,
  });

  @override
  _MarkdownEditorTemplateState createState() => _MarkdownEditorTemplateState();
}

class _MarkdownEditorTemplateState extends State<MarkdownEditorTemplate> {
  int pipIdx;
  bool isPreview = false;
  TextEditingController _titleController = TextEditingController();
  TextEditingController _mdController = TextEditingController();

  @override
  void initState() {
    super.initState();
    this.pipIdx = widget.initPIP != null
        ? [PIP.PUBLIC, PIP.INTERNAL, PIP.PRIVATE].indexOf(widget.initPIP)
        : 0;
    this._titleController.text = widget.title;
    this._mdController.text = widget.content;
  }

  @override
  Widget build(BuildContext context) {
    return SafePaddingTemplate(
        appBar: BackAppBar(
            isClose: true,
            switchButton: this.prevSwitch(),
            actions: [
              Button('Ok',
                  buttonSize: ButtonSize.SMALL,
                  borderColor: AppTheme.colors.primary,
                  onTap: this.onTabOk,
                  shadow: false)
            ]),
        floatingBottomBar: MarkdownSupporter(this._mdController,
            withAnonym: widget.withAnonym),
        children: [
          this.topArea(),
          ...(this.isPreview
              ? [
                  TitleHeader(this._titleController.text, link: ''),
                  PadongMarkdown(this._mdController.text)
                ]
              : [
                  Input(
                      controller: this._titleController,
                      hintText: widget.titleHint,
                      type: InputType.UNDERLINE),
                  Input(
                      controller: this._mdController,
                      hintText: widget.contentHint ?? PIP_HINT,
                      type: InputType.PLAIN)
                ]),
          SizedBox(height: 20),
          ...(widget.children ?? [])
        ]);
  }

  Widget prevSwitch() {
    return SwitchButton(
        options: [widget.editTxt, 'prev'],
        onChange: (String selected) {
          setState(() {
            this.isPreview = selected == 'prev';
          });
        });
  }

  Widget topArea() {
    return Container(
        height: 55,
        alignment: Alignment.centerLeft,
        child: widget.topArea ??
            SwitchButton(
                options: PIPs,
                buttonType: SwitchButtonType.SHADOW,
                initIdx: this.pipIdx,
                onChange: (String selected) {
                  setState(() {
                    this.pipIdx = PIPs.indexOf(selected);
                  });
                }));
  }

  void onTabOk() {
    if(this._titleController.text.isNotEmpty && this._mdController.text.isNotEmpty) {
      Map data = {
        'title': this._titleController.text,
        'description': this._mdController.text,
        'ownerId': Session.user.id,
      };
      if (widget.topArea == null)
        data['pip'] =
            pipToString([PIP.PUBLIC, PIP.INTERNAL, PIP.PRIVATE][this.pipIdx]);
      widget.onSubmit(data);
      PadongRouter.goBack();
    }
    // TODO: alert no empty title & description
  }
}

