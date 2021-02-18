import 'package:flutter/material.dart';

Function dialogCallback(BuildContext context, String title, String message) {
  return () => showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)),
            title: new Text(title),
            content: SingleChildScrollView(child: new Text(message)),
            actions: <Widget>[
              new FlatButton(
                  child: new Text("Close"),
                  onPressed: () {
                    Navigator.pop(context);
                  })
            ]);
      });
}
