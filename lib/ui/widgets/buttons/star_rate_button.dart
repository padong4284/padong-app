import 'package:flutter/material.dart';
import 'package:padong/ui/theme/app_theme.dart';

class StarRateButton extends StatefulWidget {
  final double rate;
  final bool disable;
  final double size;
  final Function(double) onChange;

  StarRateButton(
      {@required rate, this.disable = false, this.size = 32.0, this.onChange})
      : assert(rate <= 5.0),
        this.rate = rate;

  @override
  _StarRateButtonState createState() => _StarRateButtonState();
}

class _StarRateButtonState extends State<StarRateButton> {
  int curr = 0;

  @override
  void initState() {
    super.initState();
    this.curr = (widget.rate * 2) ~/ 1;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Row(
            children: List.generate(
                10,
                (idx) => ClipRect(
                    child: Align(
                        alignment: idx % 2 == 0
                            ? Alignment.topLeft
                            : Alignment.topRight,
                        widthFactor: 0.5,
                        child: widget.disable
                            ? this.getIthStarIcon(idx)
                            : InkWell(
                                onTap: () {
                                  setState(() {
                                    if (this.curr == idx + 1)
                                      this.curr = 0;
                                    else
                                      this.curr = idx + 1;
                                    if (widget.onChange != null)
                                      widget.onChange(this.curr / 10);
                                  });
                                },
                            child: this.getIthStarIcon(idx)))))));
  }

  Icon getIthStarIcon(idx) {
    return Icon(Icons.star_rounded,
        size: widget.size,
        color: idx < this.curr
            ? AppTheme.colors.pointYellow
            : AppTheme.colors.lightSupport);
  }
}
