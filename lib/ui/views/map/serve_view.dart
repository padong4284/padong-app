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
import 'package:padong/core/apis/map.dart';
import 'package:padong/core/shared/types.dart';
import 'package:padong/ui/views/templates/markdown_editor_template.dart';
import 'package:padong/ui/widgets/inputs/marker_selector.dart';

class ServeView extends StatelessWidget {
  final String buildingId;
  final Map<String, dynamic> building;
  final Map<String, int> marker = {'selected': 0};

  ServeView(buildingId)
      : this.buildingId = buildingId,
        this.building = getBuildingAPI(buildingId);

  @override
  Widget build(BuildContext context) {
    return MarkdownEditorTemplate(
      editTxt: 'serve',
      titleHint: 'Title of Service',
      topArea: MarkerSelector(
        setMarkers: (idx) => this.marker['selected'] = SERVICE_CODES[idx],
        isOnlyOne: true,
      ),
      contentHint: this.building['rule'],
      onSubmit: this.createService,
    );
  }

  void createService(Map data) {
    data['parentId'] = this.building['id'];
    data['serviceCode'] = SERVICE(this.marker['selected']);
    createSericeAPI(data);
  }
}