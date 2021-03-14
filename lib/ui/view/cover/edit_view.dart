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
import 'package:padong/core/node/cover/cover.dart';
import 'package:padong/core/node/cover/item.dart';
import 'package:padong/core/node/cover/wiki.dart';
import 'package:padong/core/node/node.dart';
import 'package:padong/ui/template/markdown_editor_template.dart';

class EditView extends StatelessWidget {
  final Cover cover;
  final Wiki wiki;
  final bool isCreateWiki;

  EditView(Node node)
      : this.wiki = node.type == 'wiki' ? node : null,
        this.cover = node.type == 'cover' ? node : null,
        this.isCreateWiki = node.type == 'cover';

  @override
  Widget build(BuildContext context) {
    return MarkdownEditorTemplate(
      editTxt: 'edit',
      titleHint: 'Title of Wiki',
      initPIP: this.isCreateWiki ? null : wiki.pip,
      title: this.isCreateWiki ? null : wiki.title,
      content: this.isCreateWiki ? null : wiki.description,
      onSubmit: this.isCreateWiki ? this.createWiki : this.updateWiki,
    );
  }

  void createWiki(Map data) async {
    Wiki _wiki = await Wiki.fromMap('', {
      ...data,
      'parentId': this.cover.id,
    }).create();
    await Item.fromMap('', {
      ...data,
      'parentId': _wiki.id,
      'prevDescription': '',
    }).create();
  }

  void updateWiki(Map data) async {
    Item _item = await Item.fromMap('', {
      ...data,
      'parentId': this.wiki.id,
      'prevDescription': this.wiki.description,
    }).create();
    this.wiki.title = _item.title;
    this.wiki.description = _item.description;
    this.wiki.pip = _item.pip;
    this.wiki.update();
  }
}
