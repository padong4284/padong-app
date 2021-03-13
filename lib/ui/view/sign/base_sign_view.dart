///*********************************************************************
///* Copyright (C) 2021-2021 Taejun Jang <padong4284@gmail.com>
///* All Rights Reserved.
///* This file is part of PADONG.
///*
///* PADONG can not be copied and/or distributed without the express
///* permission of Taejun Jang, Daewoong Ko, Hyunsik Kim, Seongbin Hong
///*
///* Github [https://github.com/padong4284]
///*********************************************************************
import 'dart:ui';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:padong/ui/widget/input/input.dart';
import 'package:padong/util/wave/wave_clipper.dart';
import 'package:padong/util/wave/wave.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/widget/button/button.dart';
import 'package:padong/ui/widget/button/simple_button.dart';
import 'package:padong/ui/shared/types.dart';

Wave primaryWave = new Wave(50, -5, 280, 4);
Wave secondaryWave = new Wave(-75, 25, 500, 4);

class BaseSignView extends StatefulWidget {
  final bool isSignIn;
  final String welcomeMsg;
  final List<Widget> forms;
  final Future<bool> Function() onTapEnter;
  final TextEditingController idController;

  //final bool func() onSignUp;
  BaseSignView(
      {this.isSignIn,
      this.welcomeMsg,
      this.idController,
      this.forms,
      this.onTapEnter});

  @override
  _BaseSignViewState createState() => _BaseSignViewState();
}

class _BaseSignViewState extends State<BaseSignView>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation animation;
  bool startAnimate = true;
  bool isButtonDisabled = false;

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
    double bottomPadding = MediaQuery.of(context).padding.bottom;
    double height = MediaQuery.of(context).size.height - bottomPadding;
    return Scaffold(
        floatingActionButton: this.enterButton(bottomPadding),
        body: GestureDetector(
            onTap: () {
              FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus &&
                  currentFocus.focusedChild != null)
                FocusManager.instance.primaryFocus.unfocus();
            },
            child: SafeArea(
                top: false, // only Sign In & Up
                child: SingleChildScrollView(
                  child: Stack(children: <Widget>[
                    ...this.waves(height, bottomPadding),
                    Positioned(
                        bottom: 140 + bottomPadding,
                        child: Container(
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width,
                            child: Container(
                                width: MediaQuery.of(context).size.width -
                                    2 * (AppTheme.horizontalPadding + 30),
                                child: Column(children: [
                                  Hero(
                                      tag: 'ID_INPUT',
                                      child: Material(
                                          color: AppTheme.colors.transparent,
                                          child: Input(
                                              controller: widget.idController,
                                              margin:
                                                  EdgeInsets.only(top: 10.0),
                                              hintText: 'ID'))),
                                  ...widget.forms
                                ])))),
                    Positioned(
                        bottom: 10,
                        left: 0,
                        child: this.bottomArea(bottomPadding))
                  ]),
                ))));
  }

  List<Widget> waves(height, bottomPadding) {
    return [
      Hero(
        flightShuttleBuilder: heroFlightShuttleBuilder,
        tag: 'secondaryWave',
        child: ClipPath(
          clipper: WaveClipper(secondaryWave),
          child: Container(
              color: AppTheme.colors.semiPrimary,
              height: height,
              padding: EdgeInsets.only(
                  right: 50.0,
                  bottom:
                      widget.isSignIn ? 60 : height / 2 + 35 - bottomPadding),
              alignment: Alignment.centerRight,
              child: Text(widget.welcomeMsg,
                  textAlign: TextAlign.right,
                  style: AppTheme.getFont(
                      fontSize: AppTheme.fontSizes.xlarge,
                      color: AppTheme.colors.support,
                      isBold: true))),
        ),
      ),
      Hero(
          flightShuttleBuilder: heroFlightShuttleBuilder,
          tag: 'padongTitle',
          child: this.title(AppTheme.colors.transparent,
              AppTheme.colors.primary, bottomPadding)),
      Hero(
        flightShuttleBuilder: heroFlightShuttleBuilder,
        tag: 'primaryWave',
        child: ClipPath(
            clipper: WaveClipper(primaryWave),
            child: this.title(
                AppTheme.colors.primary, AppTheme.colors.base, bottomPadding)),
      )
    ];
  }

  Widget title(color, fontColor, bottomPadding) {
    return Container(
      color: color,
      height: widget.isSignIn ? 400 : 250,
      padding: EdgeInsets.only(left: 50.0, bottom: 35 - bottomPadding),
      alignment: Alignment.centerLeft,
      child: Text('PADONG',
          style: AppTheme.getFont(
              fontSize: AppTheme.fontSizes.giant,
              color: fontColor,
              isBold: true)),
    );
  }

  Widget bottomArea(double bottomPadding) {
    return SizedBox(
        width: MediaQuery.of(context).size.width -
            (MediaQuery.of(context).padding.left +
                MediaQuery.of(context).padding.right),
        child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Padding(
                  padding: const EdgeInsets.only(left: 40, bottom: 30),
                  child: Button(widget.isSignIn ? 'Sign Up' : 'Sign In',
                      color: AppTheme.colors.support,
                      type: ButtonType.STADIUM,
                      buttonSize: ButtonSize.LARGE,
                      onTap: widget.isSignIn
                          ? () {
                              Navigator.pushNamed(context, '/sign_up');
                              primaryWave.moveYNorm(-155 + bottomPadding);
                              secondaryWave.moveYNorm(-335 + bottomPadding);
                            }
                          : () {
                              Navigator.pop(context);
                              primaryWave.moveYNorm(155 - bottomPadding);
                              secondaryWave.moveYNorm(335 - bottomPadding);
                            })),
              Padding(
                  padding: const EdgeInsets.only(right: 45, bottom: 40),
                  child: widget.isSignIn
                      ? SimpleButton('Forgot Password?',
                          color: AppTheme.colors.semiPrimary,
                          buttonSize: ButtonSize.REGULAR, onTap: () {
                          Navigator.pushNamed(context, '/forgot');
                        })
                      : null),
            ]));
  }

  Widget enterButton(bottomPadding) {
    return Visibility(
        visible: MediaQuery.of(context).viewInsets.bottom == 0.0,
        child: Container(
            padding: EdgeInsets.only(right: 10.0, bottom: 58.0 + bottomPadding),
            child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
              Container(
                padding: const EdgeInsets.only(right: 12),
                child: Text(widget.isSignIn ? 'Sign In' : 'Sign Up',
                    style: AppTheme.getFont(
                        fontSize: AppTheme.fontSizes.large,
                        color: AppTheme.colors.primary)),
              ),
              FloatingActionButton(
                  child: Icon(Icons.east, color: AppTheme.colors.base),
                  backgroundColor: AppTheme.colors.primary,
                  onPressed: () async {
                    if (this.isButtonDisabled == false) {
                      this.isButtonDisabled = true;
                      if (await widget.onTapEnter()) // isEnterSuccess
                        Navigator.pushNamed(context, '/main');
                      else
                        // TODO: feedback to user
                        log("${widget.isSignIn ? 'SignIn' : 'SignUp'} Failed");
                      this.isButtonDisabled = false;
                    }
                  })
            ])));
  }
}
