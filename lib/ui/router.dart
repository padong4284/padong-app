import 'package:flutter/material.dart';
import './views/sign/sign_in_view.dart';
import './views/sign/sign_up_view.dart';
import './views/main/route_view.dart';
import './views/main/p_main_view.dart';

class PadongRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/main':
        return MaterialPageRoute(
            builder: (_) => RouteView(),
        );
      case '/p_main':
        return MaterialPageRoute(
            builder: (_) => RouteView(),
        );
      case '/':
        return MaterialPageRoute(
          builder: (_) => SignInView()
        );
      case '/sign_up':
        return PageRouteBuilder(
            pageBuilder: (_, __ ,___ ) => SignUpView(),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            )
          )
        );
    }
  }
}