import 'package:flutter/material.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/widgets/safe_padding_template.dart';
import 'package:padong/ui/widgets/inputs/bottom_sender.dart';

class ForgotView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafePaddingTemplate(
      children: [],
      floatingBottomBar: BottomSender(
          hintText: 'Argue',
          icon: Icon(Icons.add, color: AppTheme.colors.primary, size: 24)),
    );
  }
}
