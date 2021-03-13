///*********************************************************************
///* Copyright (C) 2021-2021 Taejun Jang <padong4284@gmail.com>
///* All Rights Reserved.
///* This file is part of PADONG.
///*
///* PADONG can not be copied and/or distributed without the express
///* permission of Taejun Jang, Daewoong Ko, Hyunsik Kim, Seongbin Hong
///
///* Github [https://github.com/padong4284]
///*********************************************************************

import 'package:padong/core/apis/dummy.dart';
import 'package:padong/core/node/cover/wiki.dart';
import 'package:padong/core/node/deck/board.dart';
import 'package:padong/core/node/map/building.dart';

/// When Create University, should create follows!
///   1. University
///     => Cover ✓
///
///    -> Wiki
///      Vision, Mission, History
///
///    => Deck ✓
///      -> Board
///        Global, Public, Internal
///
///    => Schedule ✓
///
///    => Mappa ✓
///
///    -> Building
///      Center
///
///    -> Board
///      Popular, Favorite, Informs

Future<void> initUniversity() async {
  // -> Wiki init
  for (String title in ['Vision', 'Mission', 'History'])
    await Wiki.fromMap('', {...wiki, 'title': title, 'parentId': univ.id})
        .create();

  // => Deck -> Board
  for (String title in ['Global', 'Public', 'Internal'])
    await Board.fromMap(
        '', {...board, 'title': title, 'parentId': univ.deck.id}).create();

  // -> Building
  await Building.fromMap('', {...building, 'parentId': univ.id, 'title': univ.title}).create();

  // -> Board
  for (String title in ['Popular', 'Favorite', 'Informs'])
    await Board.fromMap('', {...board, 'title': title, 'parentId': univ.id})
        .create();
}
