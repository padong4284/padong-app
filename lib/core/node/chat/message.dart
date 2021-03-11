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
import 'package:padong/core/node/node.dart';

class Message extends Node {
  String message;
  bool isImage;

  Message();

  Message.fromMap(String id, Map snapshot)
      : this.message = snapshot['message'],
        this.isImage = snapshot['isImage'],
        super.fromMap(id, snapshot);

  @override
  generateFromMap(String id, Map snapshot) => Message.fromMap(id, snapshot);

  @override
  Map<String, dynamic> toJson() {
    return {
      ...super.toJson(),
      'message': this.message,
      'isImage': this.isImage,
    };
  }
}
