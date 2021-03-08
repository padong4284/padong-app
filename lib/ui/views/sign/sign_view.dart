import 'dart:developer';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/widgets/buttons/button.dart';
import 'package:padong/ui/widgets/buttons/transp_button.dart';
import 'package:padong/ui/utils/wave/wave_clipper.dart';
import 'package:padong/ui/utils/wave/wave.dart';
import 'package:padong/ui/shared/types.dart';
import 'package:padong/core/apis/session.dart' as Session;

Wave primaryWave = new Wave(50, -5, 280, 4);
Wave secondaryWave = new Wave(-75, 25, 500, 4);

class SignView extends StatefulWidget {
  final bool isSignIn;
  final String welcomeMsg;
  final Widget forms;
  final Future<bool> Function() onSignIn;
  final Future<bool> Function() onSignUp;

  //final bool func() onSignUp;
  SignView(this.isSignIn, this.welcomeMsg, this.forms,
      {this.onSignIn, this.onSignUp});

  @override
  _SignViewState createState() => _SignViewState();
}

class _SignViewState extends State<SignView>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation animation;
  bool startAnimate = true;
  static bool isButtonDisabled = false;

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
                    widget.forms,
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
                  child: Button(
                      title: widget.isSignIn ? 'Sign Up' : 'Sign In',
                      color: AppTheme.colors.support,
                      type: ButtonType.STADIUM,
                      buttonSize: ButtonSize.LARGE,
                      callback: widget.isSignIn
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
                      ? TranspButton(
                          title: 'Forgot Password?',
                          color: AppTheme.colors.semiPrimary,
                          buttonSize: ButtonSize.REGULAR,
                          callback: () {
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
                          color: AppTheme.colors.primary))),
              FloatingActionButton(
                child: Icon(Icons.east, color: AppTheme.colors.base),
                backgroundColor: AppTheme.colors.primary,
                onPressed: () async {
                  log(_SignViewState.isButtonDisabled.toString());
                  if (_SignViewState.isButtonDisabled == false) {
                    _SignViewState.isButtonDisabled = true;
                    //log(widget.onSignIn == null);
                    if (widget.isSignIn && widget.onSignIn != null) {
                      log("Login Start.");

                      if (await widget.onSignIn()) {
                        log("Login success.");
                        Navigator.pushNamed(context, '/main',
                            arguments: {'univId': Session.user['univId']});
                      } else {
                        log("Login Failed.");
                      }
                    } else if (!widget.isSignIn && widget.onSignUp != null) {
                      if (await widget.onSignUp()) {
                        log("Register success.");
                        Navigator.pushNamed(context, '/',
                            arguments: {'univId': Session.user['univId']});
                      } else {
                        log("Register Failed ");
                      }
                    }
                    _SignViewState.isButtonDisabled = false;
                  }
                },
              )
            ])));
  }
}
