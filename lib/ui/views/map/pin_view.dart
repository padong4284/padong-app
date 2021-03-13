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
import 'package:padong/core/apis/map.dart';
import 'package:padong/ui/views/templates/markdown_editor_template.dart';
import 'package:padong/ui/widgets/cards/location_card.dart';

class PinView extends StatelessWidget {
  final String mappaId;
  final LatLng location;

  PinView(this.mappaId, String lat, String lng)
      : this.location = LatLng(double.parse(lat), double.parse(lng));

  @override
  Widget build(BuildContext context) {
    print(this.location.toJson());
    return MarkdownEditorTemplate(
      editTxt: 'pin',
      onSubmit: this.createBoard,
      titleHint: 'Title of Building',
      children: [
        SizedBox(height: 20),
        LocationCard(this.location, mark: 'support',)
      ],
    );
  }

  void createBoard(Map data) {
    data['parentId'] = this.mappaId;
    createBuildingAPI(data);
  }
}