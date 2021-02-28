import 'package:flutter/material.dart';
import 'package:padong/core/apis/deck.dart';
import 'package:padong/ui/views/cover/compare_view.dart';
import 'package:padong/ui/views/cover/edit_view.dart';
import 'package:padong/ui/views/cover/wiki_view.dart';
import 'package:padong/ui/views/deck/board_view.dart';
import 'package:padong/ui/views/deck/make_view.dart';
import 'package:padong/ui/views/deck/post_view.dart';
import 'package:padong/ui/views/deck/write_view.dart';
import 'package:padong/ui/views/schedule/ask_view.dart';
import 'package:padong/ui/views/schedule/event_view.dart';
import 'package:padong/ui/views/schedule/lecture_view.dart';
import 'package:padong/ui/views/schedule/rail_view.dart';
import 'package:padong/ui/views/schedule/review_view.dart';
import 'package:padong/ui/views/schedule/update_view.dart';
import 'package:padong/ui/views/search/search_view.dart';
import 'package:padong/ui/views/sign/sign_in_view.dart';
import 'package:padong/ui/views/sign/sign_up_view.dart';
import 'package:padong/ui/views/sign/forgot_view.dart';
import 'package:padong/ui/views/route_view.dart';
import 'package:padong/core/apis/session.dart' as Session;

const List<Offset> SLIDE = [
  Offset(0, 1), // to TOP
  Offset(-1, 0), // to RIGHT
  Offset(0, -1), // to BOTTOM
  Offset(1, 0) // to LEFT
];

class PadongRouter {
  static BuildContext context;

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final Map<String, dynamic> args =
        new Map<String, dynamic>.from(settings.arguments ?? {});
    switch (settings.name) {
      case '/main':
        Session.currentUniv = getUnivAPI(args['univId']);
        return MaterialPageRoute(builder: (_) => RouteView());
      case '/p_main':
        Session.currentUniv = getUnivAPI('uPADONG'); // PADONG Univ Id
        return MaterialPageRoute(builder: (_) => RouteView());
      case '/':
        return PageRouteBuilder(pageBuilder: (_, __, ___) => SignInView());
      case '/sign_up':
        return PageRouteBuilder(
          pageBuilder: (_, __, ___) => SignUpView(),
        );
      case '/forgot':
        return MaterialPageRoute(builder: (_) => ForgotView());

      case '/board':
        return slideRouter(
            pageBuilder: (_, __, ___) => BoardView(args['id']), direction: 1);
      case '/post':
        return sizeRouter(pageBuilder: (_, __, ___) => PostView(args['id']));
      case '/write':
        return slideRouter(pageBuilder: (_, __, ___) => WriteView(args['id']));
      case '/make':
        return slideRouter(pageBuilder: (_, __, ___) => MakeView(args['id']));

      case '/wiki':
        return slideRouter(
            pageBuilder: (_, __, ___) => WikiView(args['id']), direction: 1);
      case '/edit':
        return slideRouter(
            pageBuilder: (_, __, ___) =>
                EditView(args['id'], wikiId: args['wikiId']));
      case '/compare':
        return sizeRouter(
            pageBuilder: (_, __, ___) =>
                CompareView(args['id'], wikiId: args['wikiId']));

      case '/event':
        return slideRouter(
            pageBuilder: (_, __, ___) => EventView(args['id']), direction: 1);
      case '/lecture':
        return slideRouter(
            pageBuilder: (_, __, ___) => LectureView(args['id']), direction: 1);
      case '/review':
        return slideRouter(
            pageBuilder: (_, __, ___) => ReviewView(args['id']), direction: 1);
      case '/rail':
        return slideRouter(pageBuilder: (_, __, ___) => RailView(args['id']), direction: 1);
      case '/update':
        return slideRouter(pageBuilder: (_, __, ___) => UpdateView(args['id']));
      case '/ask':
        return slideRouter(pageBuilder: (_, __, ___) => AskView(args['id']));

      case '/search':
        return PageRouteBuilder(pageBuilder: (_, __, ___) => SearchView());

      default:
        return PageRouteBuilder(
            pageBuilder: (_, __, ___) => Scaffold(
                    body: Center(
                  child: Text('No route defined for ${settings.name}'),
                )));
    }
  }

  static void registerContext(BuildContext context) {
    PadongRouter.context = context;
  }

  static void routeURL(String url) {
    Map<String, dynamic> arguments = {};
    if (url.startsWith('/')) url = url.substring(1);
    List<String> parsed = url.split('/');
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

  static PageRouteBuilder slideRouter(
      {Function(BuildContext, Animation<double>, Animation<double>) pageBuilder,
      int direction = 0}) {
    return PageRouteBuilder(
        pageBuilder: pageBuilder,
        transitionsBuilder: (
          BuildContext _,
          Animation<double> animation,
          Animation<double> __,
          Widget child,
        ) =>
            SlideTransition(
              position: animation.drive(
                  Tween(begin: SLIDE[direction], end: Offset.zero)
                      .chain(CurveTween(curve: Curves.ease))),
              child: child,
            ));
  }

  static PageRouteBuilder sizeRouter({
    Function(BuildContext, Animation<double>, Animation<double>) pageBuilder,
  }) {
    return PageRouteBuilder(
        pageBuilder: pageBuilder,
        transitionsBuilder: (
          BuildContext _,
          Animation<double> animation,
          Animation<double> __,
          Widget child,
        ) =>
            Align(
              child: SizeTransition(sizeFactor: animation, child: child),
            ));
  }
}
