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
///
///
///
import 'package:crypto/crypto.dart';
import 'dart:convert';

class Anonymity{
  static String SHA256(String target){
    List<int> bytes = utf8.encode(target);
    return sha256.convert(bytes).toString();
  }

  static Map<String,dynamic> MaskingOwnerId(Map<String,dynamic> target){
    if((target["anonymity"] ?? false) == true){
      target["ownerId"] =  SHA256(target["parentId"] + target["ownerId"]);
    }

    return target;
  }

}