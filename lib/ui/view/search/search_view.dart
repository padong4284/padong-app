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
import 'package:padong/core/node/title_node.dart';
import 'package:padong/core/search_engine.dart';
import 'package:padong/ui/shared/types.dart';
import 'package:padong/ui/template/safe_padding_template.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/view/search/result_view.dart';
import 'package:padong/ui/widget/bar/top_app_bar.dart';
import 'package:padong/ui/widget/input/bottom_sender.dart';

class SearchView extends StatefulWidget {
  final String level1;
  final String level2;
  final TextEditingController _searchController = TextEditingController();

  SearchView(this.level1, this.level2);

  _SearchViewState createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  bool isSearched = false;
  bool isRendered = false;
  List<TitleNode> result = [];

  @override
  Widget build(BuildContext context) {
    return SafePaddingTemplate(
        appBar: TopAppBar('', withClose: true),
        floatingBottomBar: BottomSender(BottomSenderType.SEARCH,
            msgController: widget._searchController, onSubmit: () async {
          if (widget._searchController.text.isNotEmpty) {
            String type = {
                  'Univ.': 'university',
                  'Save': 'bookmark'
                }[widget.level2] ??
                widget.level2.toLowerCase();
            this.isSearched = true;
            this.result =
                await SearchEngine.search(type, widget._searchController.text);
            setState(() {});
          }
          widget._searchController.text = '';
        }),
        children: [
          this.level(),
          SizedBox(height: 30),
          ResultView(this.result, this.isSearched)
        ]);
  }

  Widget level() {
    return Row(
        children: [widget.level1, '', widget.level2]
            .map((level) => level.isEmpty
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Icon(Icons.arrow_forward_ios_rounded, size: 15))
                : Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    decoration: BoxDecoration(
                        color: AppTheme.colors.lightSupport,
                        borderRadius: BorderRadius.circular(5)),
                    child: Text(level)))
            .toList());
  }

  @override
  void initState() {
    super.initState();
    this.setRendered();
  }

  void setRendered() async {
    await Future.delayed(Duration(milliseconds: 250));
    if (this.mounted) setState(() => this.isRendered = true);
  }
}
