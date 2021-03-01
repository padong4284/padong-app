import 'package:flutter/material.dart';
import 'package:padong/core/apis/cover.dart';
import 'package:padong/ui/shared/types.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/views/templates/safe_padding_template.dart';
import 'package:padong/ui/widgets/bars/back_app_bar.dart';
import 'package:padong/ui/widgets/buttons/button.dart';
import 'package:padong/ui/widgets/buttons/switch_button.dart';
import 'package:padong/ui/widgets/paddong_markdown.dart';
import 'package:padong/ui/widgets/tiles/node/post_tile.dart';
import 'package:padong/ui/widgets/title_header.dart';

class CompareView extends StatefulWidget {
  final String id;
  final String wikiId;

  CompareView(this.id, {this.wikiId});

  _CompareViewState createState() => _CompareViewState();
}

class _CompareViewState extends State<CompareView> {
  bool isPrev = false;

  @override
  Widget build(BuildContext context) {
    return CompareViewBase(
        widget.id,
        widget.wikiId,
        this.isPrev,
        (selected) => setState(() {
              this.isPrev = selected == 'prev';
            }));
  }
}

class CompareViewBase extends PostTile {
  final String id;
  final String wikiId;
  final Map<String, dynamic> item;
  final Map<String, dynamic> wiki;
  final bool isPrev;
  final Function checkPrev;

  CompareViewBase(id, wikiId, this.isPrev, this.checkPrev)
      : this.id = id,
        this.wikiId = wikiId,
        this.item = getItemAPI(id),
        this.wiki = getWikiAPI(wikiId),
        super(id);

  @override
  Widget build(BuildContext context) {
    return SafePaddingTemplate(appBar: this.rawAndPreivew(), children: [
      Stack(children: [
        Hero(tag: 'node${this.id}owner', child: this.profile()),
        Hero(tag: 'node${this.id}common', child: this.commonArea())
      ]),
      TitleHeader(this.item['title'], link: "/post/id=${this.id}"),
      this.isPrev
          ? PadongMarkdown(this.item['description'])
          : Text(
              // TODO: highlight remove and add
              this.item['description'],
              style: AppTheme.getFont(),
            ),
      SizedBox(height: 20),
    ]);
  }

  @override
  Widget commonArea() {
    return Container(
        height: 40,
        padding: EdgeInsets.only(left: 47, right: 10),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Expanded(child: this.topText()), this.time()],
          )
        ]));
  }

  Widget rawAndPreivew() {
    return BackAppBar(
      switchButton: SwitchButton(
        options: ['raw', 'prev'],
        onChange: this.checkPrev,
      ),
      actions: [
        Button(
            title: 'Revert',
            buttonSize: ButtonSize.SMALL,
            borderColor: AppTheme.colors.primary,
            callback: this.onTabRevert,
            shadow: false)
      ],
    );
  }

  void onTabRevert() => requestRevertAPI(this.wikiId, this.id);
}
