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
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:padong/core/node/map/building.dart';
import 'package:padong/core/node/map/mappa.dart';
import 'package:padong/ui/template/markdown_editor_template.dart';
import 'package:padong/ui/widget/card/location_card.dart';

class PinView extends StatelessWidget {
  final Mappa mappa;
  final LatLng location;

  PinView(this.mappa, {String lat, String lng}):
    this.location = LatLng(double.tryParse(lat), double.tryParse(lng));

  @override
  Widget build(BuildContext context) {
    return MarkdownEditorTemplate(
      editTxt: 'pin',
      onSubmit: this.createBuilding,
      titleHint: 'Title of Building',
      children: [
        SizedBox(height: 20),
        LocationCard(this.location, mark: 'support',)
      ],
    );
  }

  void createBuilding(Map data) async {
    await Building.fromMap('', {
      ...data,
      'parentId': this.mappa.id,
      'location': this.location.toJson(),
      'serviceCheckBits': 0,
    }).create();
  }
}
