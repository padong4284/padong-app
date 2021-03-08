import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:padong/core/shared/types.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/widgets/buttons/toggle_icon_button.dart';

class MarkerSelector extends StatefulWidget {
  final Function(int idx) setMarkers;
  final int fixedBitMask;

  MarkerSelector({this.setMarkers, this.fixedBitMask});

  _MarkerSelectorState createState() => _MarkerSelectorState();
}

class _MarkerSelectorState extends State<MarkerSelector> {
  @override
  Widget build(BuildContext context) {
    double height = 40.0;
    return Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(height / 2)),
        elevation: 3.0,
        child: Container(
          height: height,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(
                  SERVICE_ICONS.length,
                  (idx) => Container(
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      child: ToggleIconButton(
                        size: 25,
                        defaultIcon: SERVICE_ICONS[idx],
                        isToggled: widget.fixedBitMask != null
                            ? widget.fixedBitMask & [1, 2, 4, 8, 16][idx] > 0
                            : false,
                        disabled: widget.fixedBitMask != null,
                        defaultColor: AppTheme.colors.semiSupport,
                        toggleColor: AppTheme.colors.primary,
                        onPressed: () => widget.setMarkers(idx),
                      )))),
        ));
  }
}
