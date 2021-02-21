import 'package:flutter/material.dart';

Function pushCallback(BuildContext context, Widget view) {
  return () =>
      Navigator.push(context, MaterialPageRoute(builder: (context) => view));
}

Function pushNamedCallback(BuildContext context) {
  return (String url) {
    Map arguments = {};
    List<String> parsed = url.split('/');
    for (String parse in parsed.sublist(2)) {
      assert(parse.indexOf('=') > 0);
      List<String> keyVal = parse.split('=');
      arguments[keyVal[0]] = keyVal[1];
    }
    Navigator.pushNamed(context, '/' + parsed[1], arguments: arguments);
  };
}

Function registeredPushNamed;
