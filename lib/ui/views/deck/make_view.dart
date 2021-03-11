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
import 'package:padong/core/apis/deck.dart';
import 'package:padong/ui/shared/types.dart';
import 'package:padong/ui/views/templates/markdown_editor_template.dart';
import 'package:padong/ui/widgets/inputs/input.dart';
import 'package:padong/ui/widgets/title_header.dart';

class MakeView extends StatelessWidget {
  final String deckId;
  final TextEditingController _ruleController = TextEditingController();

  MakeView(this.deckId);

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

  void createBoard(Map data) {
    data['parentId'] = this.deckId;
    data['rule'] = this._ruleController.text;
    createBoardAPI(data);
  }
}
