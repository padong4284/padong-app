import 'package:flutter/material.dart';

Function pushCallback(BuildContext context, Widget view) {
  return () =>
      Navigator.push(context, MaterialPageRoute(builder: (context) => view));
}

Function pushNamedCallback(BuildContext context) {
  return (String name, arguments) => Navigator.pushNamed(context, name, arguments: arguments);
}