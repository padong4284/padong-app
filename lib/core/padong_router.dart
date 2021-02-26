import 'package:flutter/material.dart';
import 'package:padong/core/apis/deck.dart';
import 'package:padong/ui/views/deck/board_view.dart';
import 'package:padong/ui/views/deck/post_view.dart';
import 'package:padong/ui/views/search/search_view.dart';
import 'package:padong/ui/views/sign/sign_in_view.dart';
import 'package:padong/ui/views/sign/sign_up_view.dart';
import 'package:padong/ui/views/sign/forgot_view.dart';
import 'package:padong/ui/views/route_view.dart';
import 'package:padong/core/apis/session.dart' as Session;

class PadongRouter {
  static BuildContext context;
  static Function(String url) routeURL;

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final Map<String, dynamic> args =
        new Map<String, dynamic>.from(settings.arguments ?? {});
    switch (settings.name) {
      case '/main':
        Session.currentUniv = getUnivAPI(args['univId']);
        return PageRouteBuilder(
          pageBuilder: (_, __, ___) => RouteView(),
        );
      case '/p_main':
        Session.currentUniv = getUnivAPI('uPADONG'); // PADONG Univ Id
        return PageRouteBuilder(
          pageBuilder: (_, __, ___) => RouteView(),
        );
      case '/':
        return PageRouteBuilder(pageBuilder: (_, __, ___) => SignInView());
      case '/sign_up':
        return PageRouteBuilder(
          pageBuilder: (_, __, ___) => SignUpView(),
        );
      case '/forgot':
        return PageRouteBuilder(pageBuilder: (_, __, ___) => ForgotView());
      case '/post':
        return PageRouteBuilder(
            pageBuilder: (_, __, ___) => PostView(args['id']));
      case '/search':
        return PageRouteBuilder(pageBuilder: (_, __, ___) => SearchView());

      case '/board':
        return PageRouteBuilder(
            pageBuilder: (_, __, ___) => BoardView(args['id']));
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
    PadongRouter.routeURL = (String url) {
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
    };
  }
}
