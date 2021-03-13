import 'package:flutter/material.dart';

class NotFoundView extends StatelessWidget {
  final String url;

  NotFoundView(this.url);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Text('No route defined for ${this.url}'),
        ));
  }
}