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
import 'package:padong/core/node/map/building.dart';
import 'package:padong/core/node/map/service.dart';
import 'package:padong/core/shared/types.dart';
import 'package:padong/ui/template/markdown_editor_template.dart';
import 'package:padong/ui/widget/input/marker_selector.dart';

class ServeView extends StatelessWidget {
  final Building building;
  final Map<String, int> marker = {'selected': 1};

  ServeView(this.building);

  @override
  Widget build(BuildContext context) {
    return MarkdownEditorTemplate(
      editTxt: 'serve',
      titleHint: 'Title of Service',
      topArea: MarkerSelector(
        setMarkers: (idx) => this.marker['selected'] = SERVICE_CODES[idx],
        isOnlyOne: true,
      ),
      contentHint: this.building.description,
      onSubmit: this.createService,
    );
  }

  void createService(Map data) async {
    await Service.fromMap('', {
      ...data,
      'pip': pipToString(this.building.pip),
      'parentId': this.building.id,
      'serviceCode': serviceToString(SERVICE(this.marker['selected'])),
      'anonymity': false,
      'rate': 0.0,
    }).create();
    this.building.serviceCheckBits |= this.marker['selected'];
    this.building.update();
  }
}
