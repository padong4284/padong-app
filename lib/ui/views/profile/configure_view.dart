import 'package:flutter/material.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/views/templates/safe_padding_template.dart';
import 'package:padong/ui/widgets/bars/back_app_bar.dart';

class ConfigureView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafePaddingTemplate(
        appBar: BackAppBar(
          isClose: true,
          actions: [
            SizedBox(
                width: 32,
                child: IconButton(
                    onPressed: () {}, // TODO: more dialog
                    icon: Icon(Icons.more_horiz_rounded,
                        color: AppTheme.colors.support)))
          ],
        ),
        children: []);
  }
}
