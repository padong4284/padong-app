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
import 'package:padong/ui/view/not_found_view.dart';
import 'package:padong/ui/view/sign/forgot_view.dart';
import 'package:padong/ui/view/sign/sign_in_view.dart';
import 'package:padong/ui/view/sign/sign_up_view.dart';
import 'package:padong/util/animation_routers.dart';

class PadongRouter {
  static BuildContext context;

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final Map<String, dynamic> args =
        new Map<String, dynamic>.from(settings.arguments ?? {});
    switch (settings.name) {
      case '/':
        return PageRouteBuilder(pageBuilder: (_, __, ___) => SignInView());
      case '/sign_up':
        return fadeRouter(pageBuilder: (_, __, ___) => SignUpView());
      case '/forgot':
        return slideRouter(pageBuilder: (_, __, ___) => ForgotView(), direction: 1);

      default:
        return PageRouteBuilder(
            pageBuilder: (_, __, ___) => NotFoundView('/${settings.name}'));
    }
  }

  static void registerContext(BuildContext context) =>
      PadongRouter.context = context;

  static void routeURL(String url) async {
    Map<String, dynamic> arguments = {};
    if (url.startsWith('/')) url = url.substring(1);
    List<String> parsed = url.split('?');
    if (parsed.length >= 2) {
      for (String parse in parsed[1].split('&')) {
        assert(parse.indexOf('=') > 0);
        List<String> keyVal = parse.split('=');
        arguments[keyVal[0]] = keyVal[1];
      }
    }
    Navigator.pushNamed(PadongRouter.context, '/' + parsed[0],
        arguments: arguments);
  }

  static goBack() => Navigator.pop(PadongRouter.context);
}
