import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/button.dart';
import '../theme/app_theme.dart';
import '../shared/types.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
              Container(
                color: AppTheme.colors.primary,
                child: Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.only(top: 100.0, bottom: 140.0, left: 50.0),
                  child: Text('PADONG', style: TextStyle(fontSize: AppTheme.fontSizes.giant, fontWeight: FontWeight.bold, color: AppTheme.colors.base)),
                )
              ),
              Container(
                color: AppTheme.colors.semiPrimary,
                width: double.infinity,
                child: Container(
                  padding: EdgeInsets.only(top: 50.0, bottom: 90.0, right: 40.0),
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.centerRight,
                        width: double.infinity,
                        child: Text('Welcome', style: TextStyle(fontSize: AppTheme.fontSizes.xlarge, fontWeight: FontWeight.bold, color: AppTheme.colors.support))
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        width: double.infinity,
                        child: Text('Back', style: TextStyle(fontSize: AppTheme.fontSizes.xlarge, fontWeight: FontWeight.bold, color: AppTheme.colors.support)),
                      )
                    ]
                  )
                )
              ),
              Button(
                  title: 'Sign Up',
                  color: AppTheme.colors.primary,
                  type: ButtonType.STADIUM,
                  buttonSize: ButtonSize.SMALL,
              )
          ]
        ),
      )
    );
  }
}