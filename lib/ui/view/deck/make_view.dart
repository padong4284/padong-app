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
import 'package:padong/core/node/deck/board.dart';
import 'package:padong/core/node/deck/deck.dart';
import 'package:padong/ui/shared/types.dart';
import 'package:padong/ui/template/markdown_editor_template.dart';
import 'package:padong/ui/widget/component/title_header.dart';
import 'package:padong/ui/widget/input/input.dart';

class MakeView extends StatelessWidget {
  final Deck deck;
  final TextEditingController _ruleController = TextEditingController();

  MakeView(this.deck);

  @override
  Widget build(BuildContext context) {
    return MarkdownEditorTemplate(
      onSubmit: this.createBoard,
      children: [
        TitleHeader('Rule'),
        Input(
            controller: this._ruleController,
            hintText: """- You have to define the rules

- Users read this rule
  when writing the post on this board.

* Caution
If the sentence is too long,
it may be cut off, so break the line.
""",
            type: InputType.PLAIN)
      ],
    );
  }

  void createBoard(Map data) async {
    await Board.fromMap('', {
      ...data,
      'parentId': this.deck.id,
      'rule': this._ruleController.text,
    }).create();
  }
}
