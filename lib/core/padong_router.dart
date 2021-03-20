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
import 'package:padong/core/node/node.dart';
import 'package:padong/core/node/nodes.dart';
import 'package:padong/ui/view/chat/chat_room_view.dart';
import 'package:padong/ui/view/chat/chat_view.dart';
import 'package:padong/ui/view/chat/chats_view.dart';
import 'package:padong/ui/view/cover/compare_view.dart';
import 'package:padong/ui/view/cover/edit_view.dart';
import 'package:padong/ui/view/cover/wiki_view.dart';
import 'package:padong/ui/view/deck/board_view.dart';
import 'package:padong/ui/view/deck/make_view.dart';
import 'package:padong/ui/view/deck/post_view.dart';
import 'package:padong/ui/view/deck/write_view.dart';
import 'package:padong/ui/view/main_view.dart';
import 'package:padong/ui/view/map/building_view.dart';
import 'package:padong/ui/view/map/pin_view.dart';
import 'package:padong/ui/view/map/serve_view.dart';
import 'package:padong/ui/view/map/service_view.dart';
import 'package:padong/ui/view/not_found_view.dart';
import 'package:padong/ui/view/profile/configure_view.dart';
import 'package:padong/ui/view/profile/friends_view.dart';
import 'package:padong/ui/view/profile/profile_view.dart';
import 'package:padong/ui/view/schedule/ask_view.dart';
import 'package:padong/ui/view/schedule/memo_view.dart';
import 'package:padong/ui/view/schedule/review_view.dart';
import 'package:padong/ui/view/schedule/event_view.dart';
import 'package:padong/ui/view/schedule/lecture_view.dart';
import 'package:padong/ui/view/schedule/rail_view.dart';
import 'package:padong/ui/view/schedule/update_view.dart';
import 'package:padong/ui/view/search/search_view.dart';
import 'package:padong/ui/view/sign/forgot_view.dart';
import 'package:padong/ui/view/sign/sign_in_view.dart';
import 'package:padong/ui/view/sign/sign_up_view.dart';
import 'package:padong/util/animation_routers.dart';

class PadongRouter {
  static BuildContext context;
  static Function() refresh;

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final Map<String, dynamic> args =
        new Map<String, dynamic>.from(settings.arguments ?? {});

    switch (settings.name) {
      case '/':
        return PageRouteBuilder(pageBuilder: (_, __, ___) => SignInView());
      case '/sign_up':
        return fadeRouter(pageBuilder: (_, __, ___) => SignUpView());
      case '/forgot':
        return slideRouter(
            pageBuilder: (_, __, ___) => ForgotView(), direction: 1);

      case '/main':
        return slideRouter(
            pageBuilder: (_, __, ___) => MainView(), direction: 3);
      case '/search':
        return fadeRouter(
            pageBuilder: (_, __, ___) => SearchView(args['l1'], args['l2']));

      case '/wiki':
        return slideRouter(
            pageBuilder: (_, __, ___) => WikiView(args['node']), direction: 1);
      case '/edit':
        return slideRouter(pageBuilder: (_, __, ___) => EditView(args['node']));
      case '/compare':
        return sizeRouter(
            pageBuilder: (_, __, ___) => CompareView(args['node']));

      case '/board':
        return slideRouter(
            pageBuilder: (_, __, ___) => BoardView(args['node']), direction: 1);
      case '/post':
        return sizeRouter(pageBuilder: (_, __, ___) => PostView(args['node']));
      case '/make':
        return slideRouter(pageBuilder: (_, __, ___) => MakeView(args['node']));
      case '/write':
        return slideRouter(
            pageBuilder: (_, __, ___) => WriteView(args['node']));

      case '/event':
        return slideRouter(
            pageBuilder: (_, __, ___) => EventView(args['node']), direction: 1);
      case '/lecture':
        return slideRouter(
            pageBuilder: (_, __, ___) => LectureView(args['node']),
            direction: 1);
      case '/review':
        return slideRouter(
            pageBuilder: (_, __, ___) => ReviewView(args['node']),
            direction: 1);
      case '/rail':
        return slideRouter(
            pageBuilder: (_, __, ___) => RailView(args['node']), direction: 1);
      case '/update':
        return slideRouter(
            pageBuilder: (_, __, ___) => UpdateView(args['node']));
      case '/ask':
        return slideRouter(pageBuilder: (_, __, ___) => AskView(args['node']));
      case '/memo':
        return slideRouter(pageBuilder: (_, __, ___) => MemoView(args['node']));

      case '/building':
        return fadeRouter(
            pageBuilder: (_, __, ___) => BuildingView(args['node']));
      case '/service':
        return sizeRouter(
            pageBuilder: (_, __, ___) => ServiceView(args['node']));
      case '/pin':
        return slideRouter(
            pageBuilder: (_, __, ___) =>
                PinView(args['node'], lat: args['lat'], lng: args['lng']));
      case '/serve':
        return slideRouter(
            pageBuilder: (_, __, ___) => ServeView(args['node']));

      case '/chats':
        return slideRouter(
            pageBuilder: (_, __, ___) => ChatsView(), direction: 1);
      case '/chatroom':
        return slideRouter(
            pageBuilder: (_, __, ___) => ChatRoomView(args['node']),
            direction: 2);
      case '/chat':
        return slideRouter(pageBuilder: (_, __, ___) => ChatView(args['node']));

      case '/profile':
        return slideRouter(
            pageBuilder: (_, __, ___) => ProfileView(args['node']),
            direction: 1);
      case '/configure':
        return fadeRouter(pageBuilder: (_, __, ___) => ConfigureView());
      case '/friends':
        return sizeRouter(
            pageBuilder: (_, __, ___) => FriendsView(args['node']));

      default:
        return PageRouteBuilder(
            pageBuilder: (_, __, ___) => NotFoundView('/${settings.name}'));
    }
  }

  static void registerContext(BuildContext context) =>
      PadongRouter.context = context;

  static void routeURL(String url, [Node node]) async {
    /// url := '${path (maybe type)}?id=${node.id}&type=${node.type (opt)}'
    /// path is may be same as node's type.
    /// id is required.
    /// if different, should pass "type" parameter.
    /// passing node to avoid async calls.
    Map<String, dynamic> arguments = {};
    if (url.startsWith('/')) url = url.substring(1);
    List<String> parsed = url.split('?');

    arguments['type'] = parsed[0];
    if (parsed.length >= 2) {
      for (String parse in parsed[1].split('&')) {
        assert(parse.indexOf('=') > 0);
        List<String> keyVal = parse.split('=');
        if (keyVal[0] == 'type') arguments['type'] = keyVal[1];
        arguments[keyVal[0]] = keyVal[1];
      }
    }
    if (node != null) arguments['type'] = node.type;
    if (arguments['id'] != null)
      arguments['node'] = // no node : configure, chats, sign, forgot, main
          node ?? (await Nodes.getNodeById(arguments['type'], arguments['id']));

    // arguments := {id: String, node: Node, type: String}
    Navigator.pushNamed(PadongRouter.context, '/' + parsed[0],
        arguments: arguments);
  }

  static goBack() {
    Navigator.pop(PadongRouter.context);
    if (refresh != null) refresh();
    refresh = null;
  }
}
