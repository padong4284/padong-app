import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../shared/types.dart';

class SwitchButton extends StatefulWidget {
  final List<String> options;
  final SwitchButtonType buttonType; // BORDER, SHADOW, TOOLTIP
  final bool cancelAble;
  final dynamic callback; // void Function(String option)

  SwitchButton(
      {@required this.options,
      this.buttonType,
      this.callback,
      this.cancelAble = false});

  @override
  _SwitchButtonState createState() => _SwitchButtonState();
}

class _SwitchButtonState extends State<SwitchButton> {
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
        width: widget.options.length == 2 ? 132 : 211,
        padding: const EdgeInsets.all(5),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: Iterable<int>.generate(widget.options.length)
                .toList()
                .map((idx) => Container(
                    width: (widget.options.length == 2 ? 55.0 : 65.0) +
                        (this.curIdx == idx ? 10.0 : -3.0),
                    height: 30,
                    child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: this.curIdx == idx
                                ? AppTheme.colors.primary
                                : AppTheme.colors.base,
                            borderRadius: BorderRadius.circular(15)),
                        child: Text(
                          widget.options[idx],
                          style: TextStyle(
                            color: this.curIdx == idx
                                ? AppTheme.colors.base
                                : AppTheme.colors.primary,
                            fontSize: AppTheme.fontSizes.small,
                          ),
                        ))))
                .toList()));
  }
}
