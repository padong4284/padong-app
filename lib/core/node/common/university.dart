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
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:padong/core/node/title_node.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:padong/core/service/padong_fb.dart';

// parent: PADONG (one and only)
class University extends TitleNode {
  String emblemImgURL;
  LatLng location; // TODO: get Building
  String address;

  University();

  University.fromMap(String id, Map snapshot)
      : this.emblemImgURL = snapshot['emblemImgURL'],
        this.location = LatLng.fromJson(snapshot['location']),
        this.address = snapshot['address'],
        super.fromMap(id, snapshot);

  @override
  generateFromMap(String id, Map snapshot) => University.fromMap(id, snapshot);

  @override
  Map<String, dynamic> toJson() {
    return {
      ...super.toJson(),
      'emblemImgURL': this.emblemImgURL,
      'location': this.location.toJson(),
      'address': this.address,
    };
  }

  static Future<University> getUniversityByName(String universityName) async {
    List<DocumentSnapshot> results = await PadongFB.getDocsByRule(
        University().type,
        rule: (Query q) => (q.where("title", isEqualTo: universityName)));
    if (results.isEmpty) throw Exception("There's no University");
    return University.fromMap(results.first.id, results.first.data());
  }
}
