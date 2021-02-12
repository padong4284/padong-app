import 'package:flutter/material.dart';
import './views/sign/sign_in_view.dart';
import './views/sign/sign_up_view.dart';

class PadongRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => SignInView()
        );
      case '/sign_up':
        return PageRouteBuilder(
            pageBuilder: (_, __ ,___ ) => SignUpView(),
            transitionsBuilder: (_, a, __, c) => FadeTransition(opacity: a, child: c)
        );
      case '/sign_up':
        return MaterialPageRoute(
            builder: (_) => SignUpView()
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