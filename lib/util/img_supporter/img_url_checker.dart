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
import 'package:http/http.dart' as http;
import 'package:padong/core/shared/validator.dart';

class ImgUrlChecker {
  static Future<String> checkHeader(
      String url, Map<String, String> compareHeader) async {
    var res = await http.head(Uri.parse(url));
    if (res.statusCode != 200) {
      return null;
    }
    for (var i in compareHeader.keys)
      if (!Validator.isValid(RegExp(compareHeader[i]), res.headers[i]))
        return null;
    return url;
  }

  static Future<List<String>> checkImgUrls(List<String> urls) async {
    if(urls.isEmpty) return [];
    return await Future.wait(
            urls.map((url) => checkHeader(url, {'Content-Type': "image/.+"})))
        .timeout(Duration(seconds: 15))
        .then((urls) => urls.where((url) => url != null).toList());
  }
}
