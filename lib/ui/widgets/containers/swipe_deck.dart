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
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:padong/ui/theme/app_theme.dart';

class SwipeDeck extends StatefulWidget {
  final List cards;
  final int numCards;
  final double height;

  SwipeDeck({@required children, this.height=205})
      : this.cards = children.reversed.toList(),
        numCards = children.length;

  @override
  _SwipeDeckState createState() => _SwipeDeckState();
}

class _SwipeDeckState extends State<SwipeDeck> {
  List<Widget> cardList;
  List<Widget> tempList = [];
  int curr = 0;

  @override
  void initState() {
    super.initState();
    this.cardList = this._getCards();
  }

  @override
  Widget build(BuildContext context) {
    int numLeftCard = min(3, cardList.length);
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Container(
            height: widget.height,
            alignment: Alignment.bottomCenter,
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              ...List.generate(
                  widget.numCards,
                  (idx) => Padding(
                      padding: const EdgeInsets.only(left: 1, right: 1),
                      child: Icon(
                          this.curr == idx
                              ? Icons.circle
                              : Icons.radio_button_unchecked,
                          color: AppTheme.colors.support,
                          size: 9)))
            ])),
        ...List.generate(
            numLeftCard,
            (idx) => Container(
                margin: EdgeInsets.only(
                    top: 16.0 * (numLeftCard - 1) - idx * 16.0),
                child: Transform.scale(
                    scale: 1 / (1 + 0.1 * (numLeftCard - 1 - idx)),
                    child: cardList[idx])))
      ],
    );
  }

  List<Widget> _getCards() {
    List<Widget> cardList = new List();
    for (int idx = 0; idx < widget.numCards; idx++) {
      cardList.add(
        Draggable(
            onDragEnd: (drag) {
              _removeCard(idx);
            },
            childWhenDragging: Container(),
            feedback: widget.cards[idx],
            child: widget.cards[idx]),
      );
    }
    return cardList;
  }

  void _removeCard(index) {
    setState(() {
      this.curr += 1;
      this.tempList.add(this.cardList.removeLast());
      if (this.cardList.isEmpty) {
        for (int _ = 0; _ < widget.numCards; _++)
          this.cardList.add(this.tempList.removeLast());
        this.curr = 0;
      }
    });
  }
}
