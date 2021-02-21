import 'package:flutter/material.dart';

Function pushCallback(BuildContext context, Widget view) {
  return () =>
      Navigator.push(context, MaterialPageRoute(builder: (context) => view));
}

Function pushNamedCallback(BuildContext context) {
  return (String url) {
    Map<String, dynamic> arguments = {};
    if (url.startsWith('/')) url = url.substring(1);
    List<String> parsed = url.split('/');
    if (parsed.length > 2) {
      for (String parse in parsed[1].split('&')) {
        assert(parse.indexOf('=') > 0);
        List<String> keyVal = parse.split('=');
        arguments[keyVal[0]] = keyVal[1];
      }
    }
    Navigator.pushNamed(context, '/' + parsed[0], arguments: arguments);
  };
}

Function registeredPushNamed;
