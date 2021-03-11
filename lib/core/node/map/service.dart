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
import 'package:padong/core/node/schedule/evaluation.dart';
import 'package:padong/core/shared/types.dart';

// parent: Building
class Service extends Evaluation {
  SERVICE serviceCode;

  Service();

  Service.fromMap(String id, Map snapshot)
      : this.serviceCode = parseSERVICE(snapshot['serviceCode']),
        super.fromMap(id, {...snapshot, 'anonymity': false});

  @override
  generateFromMap(String id, Map snapshot) => Service.fromMap(id, snapshot);

  @override
  Map<String, dynamic> toJson() {
    return {
      ...super.toJson(),
      'serviceCode': serviceToString(this.serviceCode),
    };
  }

// TODO: when CRUD Service, update building's serviceCheckBit
// One building can serve same type of services, not only one.
}
