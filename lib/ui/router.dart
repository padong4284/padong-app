import 'package:flutter/material.dart';
import 'package:padong/ui/views/deck/board_view.dart';
import 'package:padong/ui/views/deck/post_view.dart';
import 'package:padong/ui/widgets/markdown_editor_template.dart';
import './views/sign/sign_in_view.dart';
import './views/sign/sign_up_view.dart';
import './views/sign/forgot_view.dart';
import './views/main/route_view.dart';

class PadongRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final Map<String, dynamic> args = new Map<String, dynamic>.from(settings.arguments ?? {});
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
        return MaterialPageRoute(builder: (_) => SignInView());
      case '/sign_up':
        return PageRouteBuilder(
          pageBuilder: (_, __, ___) => SignUpView(),
        );
      case '/forgot':
        return MaterialPageRoute(builder: (_) => ForgotView());
      case '/post':
        return MaterialPageRoute(
            builder: (_) => PostView(
                  args['id']
            ));
      case '/search':
        return PageRouteBuilder(
          //pageBuilder: (_, __, ___) => SearchView(),
            pageBuilder: (_, __, ___) => MarkdownEditorTemplate(),
        );

      /// Deck related routes
      case '/board':
        return PageRouteBuilder(
            pageBuilder: (_, __, ___) => BoardView(
                  args['id'],
                ));
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                    body: Center(
                  child: Text('No route defined for ${settings.name}'),
                )));
    }
  }
}
