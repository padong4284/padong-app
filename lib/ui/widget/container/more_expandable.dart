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
import 'package:padong/ui/widget/button/more_button.dart';

class MoreExpandable extends StatefulWidget {
  final int folded;
  final Widget title;
  final List<Widget> children;

  MoreExpandable({@required this.children, this.title, this.folded});

  _MoreExpandableState createState() => _MoreExpandableState();
}

class _MoreExpandableState extends State<MoreExpandable> {
  int limit;

  @override
  void initState() {
    super.initState();
    this.limit = widget.folded;
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            widget.title ?? SizedBox.shrink(),
            Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: MoreButton('',
                    expanded: this.limit == null,
                    expandFunction: () => setState(() => this.limit =
                        this.limit == null ? widget.folded : null)))
          ]),
      ...(this.limit == null
          ? widget.children
          : List.generate(this.limit, (idx) => widget.children[idx]))
    ]);
  }
}
