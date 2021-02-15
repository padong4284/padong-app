import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../shared/types.dart';
import '../containers/tip_container.dart';

class SwitchButton extends StatelessWidget {
  final List<String> options;
  final SwitchButtonType buttonType; // BORDER, SHADOW, TOOLTIP
  final bool cancelAble;
  final dynamic callback; // void Function(String option)

  SwitchButton(
      {@required this.options,
      buttonType,
      this.callback,
      this.cancelAble = false}):
    this.buttonType = buttonType ?? SwitchButtonType.BORDER;

  @override
  Widget build(BuildContext context) {
    if (this.buttonType == SwitchButtonType.TOOLTIP) {
      return TipContainer(
          width: 140,
          child: SwitchButtonBase(
              options: this.options,
              buttonType: this.buttonType,
              callback: this.callback,
              cancelAble: this.cancelAble));
    }
    return SwitchButtonBase(
        options: this.options,
        buttonType: this.buttonType,
        callback: this.callback,
        cancelAble: this.cancelAble);
  }
}

class SwitchButtonBase extends StatefulWidget {
  final List<String> options;
  final SwitchButtonType buttonType; // BORDER, SHADOW, TOOLTIP
  final bool cancelAble;
  final dynamic callback; // void Function(String option)

  SwitchButtonBase(
      {@required this.options,
      this.buttonType,
      this.callback,
      this.cancelAble = false});

  @override
  _SwitchButtonBaseState createState() => _SwitchButtonBaseState();
}

class _SwitchButtonBaseState extends State<SwitchButtonBase> {
  int curIdx = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: AppTheme.colors.base,
            border: Border.all(
              color: widget.buttonType == SwitchButtonType.BORDER
                  ? AppTheme.colors.primary
                  : AppTheme.colors.transparent,
              width: 1,
            ),
            borderRadius: BorderRadius.all(Radius.circular(20)),
            boxShadow: widget.buttonType == SwitchButtonType.SHADOW
                ? [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 5.0,
                      spreadRadius: 0.0,
                      offset: Offset(0.0, 0.0),
                    )
                  ]
                : []),
        height: 40.0,
        width: widget.options.length == 2 ? 140 : 210,
        padding: const EdgeInsets.all(0),
        child: Stack(children: [
          AnimatedPositioned(
            child: Container(
                decoration: BoxDecoration(
                    color: AppTheme.colors.primary,
                    borderRadius: BorderRadius.circular(15)),
                width: this.curIdx >= 0 ? 70 : 0,
                height: 30),
            duration: Duration(milliseconds: 200),
            top: 4,
            left: 5 + this.curIdx * (widget.options.length == 2 ? 59.0 : 64.0),
          ),
          Padding(
              padding: const EdgeInsets.only(left: 5, right: 5),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: Iterable<int>.generate(widget.options.length)
                      .toList()
                      .map((idx) => InkWell(
                          onTap: () {
                            setState(() {
                              if (widget.cancelAble && this.curIdx == idx) {
                                this.curIdx = -1;
                              } else
                                this.curIdx = idx;
                            });
                          },
                          child: Container(
                              width: widget.options.length == 2 ? 55.0 : 65.0,
                              height: 38,
                              alignment: Alignment.center,
                              child: Text(
                                widget.options[idx],
                                style: TextStyle(
                                  color: this.curIdx == idx
                                      ? AppTheme.colors.base
                                      : AppTheme.colors.primary,
                                  fontSize: AppTheme.fontSizes.small,
                                ),
                              ))))
                      .toList()))
        ]));
  }
}
