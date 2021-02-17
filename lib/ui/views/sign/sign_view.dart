import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/widgets/buttons/button.dart';
import 'package:padong/ui/widgets/buttons/transp_button.dart';
import 'package:padong/ui/utils/wave/wave_clipper.dart';
import 'package:padong/ui/utils/wave/wave.dart';
import 'package:padong/ui/shared/types.dart';

Wave primaryWave = new Wave(50, -5, 280, 4);
Wave secondaryWave = new Wave(-75, 25, 500, 4);

class SignView extends StatefulWidget {
  final bool isSignIn;
  final String welcomeMsg;
  final Widget forms;

  SignView(this.isSignIn, this.welcomeMsg, this.forms);

  @override
  _SignViewState createState() => _SignViewState();
}

class _SignViewState extends State<SignView>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation animation;
  bool startAnimate = true;

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
        floatingActionButton: Visibility(
            visible: MediaQuery.of(context).viewInsets.bottom == 0.0,
            child: Container(
                padding:
                    EdgeInsets.only(right: 10.0, bottom: 58.0 + bottomPadding),
                child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  Container(
                      padding: const EdgeInsets.only(right: 12),
                      child: Text(widget.isSignIn ? 'Sign In' : 'Sign Up',
                          style: TextStyle(
                              fontSize: AppTheme.fontSizes.large,
                              color: AppTheme.colors.primary))),
                  FloatingActionButton(
                    child: Icon(Icons.east, color: AppTheme.colors.base),
                    backgroundColor: AppTheme.colors.primary,
                    onPressed: () {
                      if (widget.isSignIn) {
                        // FIXME: this is implemented temporarily
                        Navigator.pushNamed(context, '/main');
                      } else {
                        Navigator.pushNamed(context, '/p_main');
                      }
                    },
                  )
                ]))),
        body: SafeArea(
            top: false, // only Sign In & Up
            child: SingleChildScrollView(
              child: Stack(children: <Widget>[
                ...this.waves(height, bottomPadding),
                widget.forms,
                Positioned(
                    bottom: 10, left: 0, child: this.bottomArea(bottomPadding))
              ]),
            )));
  }

  List<Widget> waves(height, bottomPadding) {
    return [
      Hero(
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
                  style: TextStyle(
                      fontSize: AppTheme.fontSizes.xlarge,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.colors.support))),
        ),
      ),
      Hero(
          tag: 'padongTitle',
          child: this.title(AppTheme.colors.transparent,
              AppTheme.colors.primary, bottomPadding)),
      Hero(
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
          style: TextStyle(
              fontSize: AppTheme.fontSizes.giant,
              fontWeight: FontWeight.bold,
              color: fontColor)),
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
                  child: TranspButton(
                      title: 'Forgot Password?',
                      color: AppTheme.colors.semiPrimary,
                      buttonSize: ButtonSize.REGULAR)),
            ]));
  }
}
