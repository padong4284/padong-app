import 'package:flutter/material.dart';
import 'package:padong/ui/widgets/bars/back_app_bar.dart';
import 'package:padong/ui/widgets/safe_padding_template.dart';

class BoardView extends StatelessWidget {
  final String title;
  final String description;

  const BoardView({this.title, this.description});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafePaddingTemplate(
        appBar: BackAppBar(title: this.title),
        children: [
          Container(
            padding: EdgeInsets.only(left: 20.0, top: 10.0),
            alignment: Alignment.centerLeft,
            child: Text(
                description,
                style: TextStyle()
            ),
          ),
        ],
      )
    );
  }
}