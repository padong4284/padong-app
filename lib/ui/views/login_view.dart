import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Login'))
      ),
      body: Container(
        child: Text('Login Body',
            style: TextStyle(fontSize: AppTheme.fontSizes.giant),
),
      )
    );
  }
}