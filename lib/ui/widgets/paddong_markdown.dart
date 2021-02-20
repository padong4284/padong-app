import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class PadongMarkdown extends StatelessWidget {
  final double bottomPadding;

  PadongMarkdown({this.bottomPadding = 200});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: rootBundle.loadString("assets/test.md"),
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          if (snapshot.hasData) {
            return MarkdownBody(
                data: snapshot.data,
                styleSheet: MarkdownStyleSheet(
                    h1: TextStyle(color: Colors.blue, fontSize: 40)));
          }
          return Container(
            width: 100,
            height: 100,
            child: Center(child: CircularProgressIndicator()),
          );
        });
  }
}
