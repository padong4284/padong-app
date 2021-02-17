import 'package:flutter/material.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/shared/types.dart';
import 'package:padong/ui/widgets/buttons/switch_button.dart';
import 'package:padong/ui/widgets/buttons/star_rate_button.dart';
import 'package:padong/ui/widgets/containers/tip_container.dart';
import 'package:padong/ui/widgets/inputs/input.dart';

class BottomSender extends StatefulWidget {
  BottomSender();

  @override
  _BottomSenderState createState() => _BottomSenderState();
}

class _BottomSenderState extends State<BottomSender> {
  int curIdx = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: AppTheme.horizontalPadding),
        child: Input(
            hintText: 'Reply',
            isMultiline: true,
            icon: Icon(Icons.send, color: AppTheme.colors.primary, size: 24)
        ),
      );
  }
}
