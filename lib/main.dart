import 'package:flutter/material.dart';
import './ui/router.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'NotoSans',
        primaryColor: Color(0xFF00A1E0),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      onGenerateRoute: PadongRouter.generateRoute,
    );
  }
}