import 'package:flutter/material.dart';
import 'package:padong/core/padong_router.dart';
import 'package:padong/ui/shared/types.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/widgets/buttons/bottom_buttons.dart';
import 'package:padong/ui/widgets/buttons/transp_button.dart';
import 'package:padong/ui/widgets/cards/base_card.dart';
import 'package:padong/ui/widgets/node_base.dart';

class QuestionCard extends NodeBase {
  QuestionCard(id) : super(id);

  @override
  Widget build(BuildContext context) {
    return BaseCard(
        padding: 10,
        width: // for draggable
            MediaQuery.of(context).size.width - AppTheme.horizontalPadding * 2,
        height: 165,
        children: [
          Container(
              padding: const EdgeInsets.all(5),
              child: Stack(children: [
                Hero(tag: 'node${this.id}owner', child: this.profile()),
                Hero(tag: 'node${this.id}common', child: this.commonArea()),
                this.messages()
              ])),
          Hero(tag: 'node${this.id}bottoms', child: this.bottomArea()),
        ]);
  }

  @override
  Widget followText() {
    return SizedBox.shrink();
  }

  Widget messages() {
    return Padding(
        padding: const EdgeInsets.only(top: 18, left: 45, bottom: 5),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          this.messageBox(this.node['title']),
          this.messageBox(this.node['description']),
        ]));
  }

  Widget messageBox(String msg) {
    return ConstrainedBox(
        constraints: BoxConstraints(maxHeight: 50),
        child: Container(
            decoration: BoxDecoration(
                color: AppTheme.colors.lightSupport,
                borderRadius: const BorderRadius.all(Radius.circular(5.0))),
            margin: const EdgeInsets.symmetric(vertical: 3),
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 13),
            child: Text(
              msg,
              style: AppTheme.getFont(color: AppTheme.colors.fontPalette[1]),
            )));
  }

  @override
  Widget bottomArea() {
    this.node['bottoms'][2] = null;
    return Material(
        color: AppTheme.colors.transparent,
        child: Stack(
          children: [
            BottomButtons(left: 5, bottoms: this.node['bottoms']),
            Positioned(
                bottom: 0,
                right: 5,
                child: TranspButton(
                    title: 'Answer ',
                    isSuffixICon: true,
                    buttonSize: ButtonSize.REGULAR,
                    icon: Icon(Icons.send_rounded,
                        color: AppTheme.colors.primary, size: 20),
                    callback: () =>
                        PadongRouter.routeURL('/post?id=${this.id}')))
          ],
        ));
  }
}
