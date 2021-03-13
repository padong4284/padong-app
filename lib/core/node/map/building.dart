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
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:padong/core/node/common/user.dart';
import 'package:padong/core/node/title_node.dart';
import 'package:padong/core/shared/statistics.dart';
import 'package:padong/core/shared/types.dart';

// parent: Mappa
class Building extends TitleNode with Statistics {
  LatLng location;
  int serviceCheckBits; // TODO transaction!

  Building();

  Building.fromMap(String id, Map snapshot)
      : this.location = LatLng.fromJson(snapshot['location']),
        this.serviceCheckBits = snapshot['serviceCheckBits'],
        super.fromMap(id, snapshot) {
    this.likes = <String>[...snapshot['likes']];
    this.bookmarks = <String>[...snapshot['bookmarks']];
  }

  @override
  generateFromMap(String id, Map snapshot) => Building.fromMap(id, snapshot);

  @override
  Map<String, dynamic> toJson() {
    return {
      ...super.toJson(),
      'location': this.location.toJson(),
      'serviceCheckBits': this.serviceCheckBits,
    };
  }

  bool isServiceOn(SERVICE service) {
    // check bit mask with service's code
    return (this.serviceCheckBits & service.code) > 0;
  }

  @override
  Future<List<int>> getStatisticsWithoutMe(User me) async {
    return [
      // no count me
      (this.likes ?? []).where((id) => id != me.id).length,
      null,
      (this.bookmarks ?? []).where((id) => id != me.id).length,
    ];
  }
}
