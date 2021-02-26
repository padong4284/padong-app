import 'package:flutter/material.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/widgets/node_base.dart';

class NodeBaseTile extends NodeBase {
  final double leftPadding;

  NodeBaseTile(id, {noProfile = false, this.leftPadding = 0.0})
      : super(id, noProfile: noProfile);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(left: this.leftPadding),
        child: Column(children: [
          Container(
              margin: const EdgeInsets.only(top: 12),
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: super.build(context)),
          this.underLine()
        ]));
  }

  Widget underLine() {
    return Container(
        height: 2,
        color: AppTheme.colors.lightSupport,
        margin: const EdgeInsets.only(top: 5));
  }

  void moreCallback() {
    // TODO: Click more button " ... "
  }
}
