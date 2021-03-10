import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'core/padong_router.dart';
import './ui/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
