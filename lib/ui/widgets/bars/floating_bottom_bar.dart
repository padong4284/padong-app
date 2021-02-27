import 'package:flutter/material.dart';
import 'package:padong/ui/shared/types.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/widgets/buttons/switch_button.dart';
import 'package:padong/ui/widgets/buttons/star_rate_button.dart';
import 'package:padong/ui/widgets/containers/tip_container.dart';

class TipInfo {
  static bool isAnonym = true;
  static double starRate = 0.0;

  static void initialize() {
    isAnonym = true;
    starRate = 0.0;
  }
}

class FloatingBottomBar extends StatelessWidget {
  final Widget child;
  final bool withAnonym;
  final bool withStars;

  FloatingBottomBar(
      {@required this.child, withAnonym = false, withStars = false})
      : assert(!withAnonym || !withStars),
        this.withAnonym = withAnonym,
        this.withStars = withStars;

  @override
  Widget build(BuildContext context) {
    bool withTip = this.withAnonym || this.withStars;
    return Stack(children: [
      Container(
          margin: EdgeInsets.only(top: withTip ? 45 : 0),
          child: Container(
              decoration: BoxDecoration(color: Color(0xFFFAFAFA), boxShadow: [
                BoxShadow(
                    color: Color(0x0a000000),
                    blurRadius: 1,
                    offset: Offset(0.0, -1.2))
              ]),
              padding: const EdgeInsets.symmetric(
                  horizontal: AppTheme.horizontalPadding, vertical: 12.5),
              child: this.child)),
      withTip ? this.getTip() : SizedBox.shrink()
    ]);
  }

  Widget getTip() {
    // TODO: handling input from tip -> get SetState from caller
    return Container(
        padding:
            const EdgeInsets.only(left: AppTheme.horizontalPadding, bottom: 56),
        child: this.withStars
            ? TipContainer(
                width: 180,
                child: Container(
                    margin: const EdgeInsets.only(left: 10, top: 3.5),
                    child: StarRateButton(
                        rate: TipInfo.starRate,
                        onChange: (rate) {
                          TipInfo.starRate = rate;
                        })))
            : SwitchButton(
                options: ['anonym', 'profile'],
                buttonType: SwitchButtonType.TOOLTIP,
                onChange: (selected) {
                  TipInfo.isAnonym = (selected == 'anonym');
                }));
  }
}
