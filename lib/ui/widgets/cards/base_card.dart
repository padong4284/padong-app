import 'package:flutter/material.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/shared/types.dart';
import 'package:padong/ui/widgets/buttons/transp_button.dart';

class BaseCard extends StatelessWidget {
  final double height;
  final double width;
  final String moreText;
  final List<Widget> children;
  final Function() tabCallback;
  final Function() moreCallback;

  BaseCard(
      {@required this.children,
      this.tabCallback,
      this.moreCallback,
      this.height,
      this.width,
      this.moreText});

  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        elevation: 3.0,
        child: InkWell(
            onTap: this.tabCallback ?? () {}, // TODO: Routing to Post
            child: Container(
                width: this.width,
                height: this.height,
                padding: const EdgeInsets.all(17),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      ...this.children,
                      this.moreCallback != null
                          ? Container(
                              alignment: Alignment.bottomRight,
                              child: TranspButton(
                                title: this.moreText ?? 'More',
                                callback: this.moreCallback,
                                buttonSize: ButtonSize.SMALL,
                                color: AppTheme.colors.primary,
                                icon: Icon(Icons.arrow_forward_ios_rounded,
                                    color: AppTheme.colors.primary, size: 15.0),
                                isSuffixICon: true,
                              ))
                          : null
                    ].where((element) => element != null).toList()))));
  }
}