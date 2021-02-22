import 'package:flutter/material.dart';

Function dialogCallback(BuildContext context, String title,
    List<Widget> content, List<Widget> actions) {
  return () => showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)),
            title: new Text(title),
            content: SingleChildScrollView(
                child: Column(
              children: content,
            )),
            actions: actions);
      });
}
