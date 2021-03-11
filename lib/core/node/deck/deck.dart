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
import 'package:padong/core/node/deck/board.dart';
import 'package:padong/core/node/node.dart';

// parent: University
class Deck extends Node {
  Deck();

  Deck.fromMap(String id, Map snapshot) : super.fromMap(id, snapshot);

  @override
  generateFromMap(String id, Map snapshot) => Deck.fromMap(id, snapshot);

  Map<String, Board> getFixedBoards() {
    // TODO: get fixed boards!
    // exclude this boards from getChildren
    // TODO: move to university
    return {
      'Global': null,
      'Public': null,
      'Internal': null,
      'Popular': null,
      'Favorite': null,
      'Inform': null,
    };
  }
}
