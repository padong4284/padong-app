import 'dart:ui';
import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/button.dart';
import '../../widgets/transp_button.dart';
import '../../utils/wave/wave_clipper.dart';
import '../../utils/wave/wave.dart';
import '../../shared/types.dart';

Wave primaryWave = new Wave(50, -5, 280, 4);
Wave secondaryWave = new Wave(-75, 25, 500, 4);

class SignView extends StatefulWidget {
  final bool isSignIn;
  final String welcomeMsg;

  SignView(this.isSignIn, this.welcomeMsg);

  @override
  _SignViewState createState() =>
      _SignViewState(this.isSignIn, this.welcomeMsg);
}

class _SignViewState extends State<SignView>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation animation;
  bool startAnimate = true;

  bool isSignIn = true;
  String welcomeMsg = "Welcome\nBack";

  _SignViewState(this.isSignIn, this.welcomeMsg);

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
      setState(() {
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
    primaryWave.updating();
    secondaryWave.updating();
    this.startAnimate = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: Container(
            padding: const EdgeInsets.only(right: 10.0, bottom: 90.0),
            child: FloatingActionButton(
              child: Icon(Icons.east, color: AppTheme.colors.base),
              backgroundColor: AppTheme.colors.primary,
              onPressed: () {},
            )),
        body: SafeArea(
          top: false, // only Sign In & Up View
          child: Stack(children: <Widget>[
            Hero(
              tag: 'secondaryWave',
              child: ClipPath(
                clipper: WaveClipper(secondaryWave),
                child: Container(
                  color: AppTheme.colors.semiPrimary,
                  height: 700,
                  padding: const EdgeInsets.only(right: 50.0),
                  child: Container(
                      alignment: Alignment.centerRight,
                      child: Text(this.welcomeMsg,
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              fontSize: AppTheme.fontSizes.xlarge,
                              fontWeight: FontWeight.bold,
                              color: AppTheme.colors.support))),
                ),
              ),
            ),
            Hero(
                tag: 'primaryWave',
                child: ClipPath(
                  clipper: WaveClipper(primaryWave),
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
                )),
            Container(
                alignment: Alignment.bottomLeft,
                padding: const EdgeInsets.only(left: 40, right: 40, bottom: 30),
                child: Button(
                  title: this.isSignIn ? 'Sign Up' : 'Sign In',
                  color: AppTheme.colors.support,
                  type: ButtonType.STADIUM,
                  buttonSize: ButtonSize.LARGE,
                  callback: this.isSignIn
                      ? () => Navigator.pushNamed(context, '/sign_up')
                      : () => Navigator.pop(context),
                )),
            Container(
                alignment: Alignment.bottomRight,
                padding: const EdgeInsets.only(left: 40, right: 45, bottom: 40),
                child: TranspButton(
                    title: 'Forgot Password?',
                    color: AppTheme.colors.semiPrimary,
                    buttonSize: ButtonSize.REGULAR))
          ]),
        ));
  }
}
