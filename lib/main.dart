import 'package:flutter/material.dart';
import 'core/apis/padong_router.dart';
import './ui/theme/app_theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PADONG',
      theme: AppTheme.define(),
      onGenerateRoute: PadongRouter.generateRoute,
    );
  }
}
