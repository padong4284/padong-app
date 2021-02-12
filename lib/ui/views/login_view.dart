import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/app_theme.dart';
import '../widgets/button.dart';
import '../widgets/wave_clipper.dart';
import '../shared/types.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          top: false, // only Sign In & Up View
          child: Stack(
            children: <Widget>[
              ClipPath(
                child: Container(
                  color: AppTheme.colors.semiPrimary,
                  height: 700,
                  child: Container(
                    padding: EdgeInsets.only(top: 300.0, right: 40.0),
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.centerRight,
                          child: Text(
                              'Welcome\nBack',
                              textAlign: TextAlign.right,
                              style: TextStyle(fontSize: AppTheme.fontSizes.xlarge, fontWeight: FontWeight.bold, color: AppTheme.colors.support))
                        ),
                      ]
                    )
                  )
                ),
                clipper: SecondaryWaveClipper(),
              ),
              ClipPath(
                child: Container(
                    color: AppTheme.colors.primary,
                    height: 400,
                    child: Container(
                      alignment: Alignment.centerLeft,
                      margin: const EdgeInsets.only(top: 0.0, left: 50.0),
                      child: Text(
                          'PADONG',
                          style: TextStyle(fontSize: AppTheme.fontSizes.giant, fontWeight: FontWeight.bold, color: AppTheme.colors.base)),
                    )
                ),
                clipper: PrimaryWaveClipper(),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 40, right: 40, bottom: 30),
                  child:Button(
                    title: 'Sign Up',
                    color: AppTheme.colors.support,
                    type: ButtonType.STADIUM,
                    buttonSize: ButtonSize.LARGE,
                  )
                )
              )
            ]
          ),
        )
    );
  }
}