import 'dart:ui';
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/button.dart';
import '../utils/wave/wave_clipper.dart';
import '../utils/wave/wave.dart';
import '../shared/types.dart';

class SignUpView extends StatefulWidget {
  @override
  _SignUpViewState createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation animation;
  bool startAnimate = true;
  Wave primaryWave = new Wave(50, -5, 280, 4);
  Wave secondaryWave = new Wave(-75, 25, 500, 4);

  @override
  void initState() {
    super.initState();
    this._controller =
        AnimationController(duration: Duration(seconds: 5), vsync: this);
    this.animation = CurvedAnimation(
        parent: this._controller, // using controller, not this.controller
        curve: Curves.bounceInOut);
    this.animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        this._controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        this._controller.forward();
      }
    });

    this.animation.addListener(() {
      this.setState(() {
        if (this.startAnimate) {
          this.startAnimate = false;
          this.animateWave();
        }
      });
    });
    this._controller.forward(); // start animation
  }

  @override
  void dispose() {
    this._controller.dispose(); // finish animation
    super.dispose(); // due to lifecycle, call after controller disposed
  }

  void animateWave() async {
    await Future.delayed(Duration(milliseconds: 50));
    this.primaryWave.updating();
    this.secondaryWave.updating();
    this.startAnimate = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      top: false, // only Sign In & Up View
      child: Stack(children: <Widget>[
        ClipPath(
          child: Container(
            color: AppTheme.colors.semiPrimary,
            height: 700,
            padding: const EdgeInsets.only(right: 50.0),
            child: Container(
                alignment: Alignment.centerRight,
                child: Text('Welcome',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                        fontSize: AppTheme.fontSizes.xlarge,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.colors.support))),
          ),
          clipper: WaveClipper(secondaryWave),
        ),
        ClipPath(
          child: Container(
              color: AppTheme.colors.primary,
              height: 400,
              padding: const EdgeInsets.only(left: 50.0),
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text('PADONG',
                    style: TextStyle(
                        fontSize: AppTheme.fontSizes.giant,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.colors.base)),
              )),
          clipper: WaveClipper(primaryWave),
        ),
        Container(
            alignment: Alignment.bottomLeft,
            padding: const EdgeInsets.only(left: 40, right: 40, bottom: 30),
            child: Button(
              title: 'Sign In',
              color: AppTheme.colors.support,
              type: ButtonType.STADIUM,
              buttonSize: ButtonSize.LARGE,
              callback: () => Navigator.pop(context),
            ))
      ]),
    ));
  }
}
