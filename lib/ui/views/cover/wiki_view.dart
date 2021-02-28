import 'package:flutter/material.dart';
import 'package:padong/core/apis/cover.dart';
import 'package:padong/core/padong_router.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/views/cover/item_view.dart';
import 'package:padong/ui/widgets/bars/back_app_bar.dart';
import 'package:padong/ui/widgets/buttons/floating_bottom_button.dart';
import 'package:padong/ui/widgets/buttons/padong_floating_button.dart';
import 'package:padong/ui/views/templates/safe_padding_template.dart';
import 'package:padong/ui/widgets/containers/tab_container.dart';
import 'package:padong/ui/widgets/paddong_markdown.dart';
import 'package:padong/ui/widgets/title_header.dart';

class WikiView extends StatelessWidget {
  final String id;
  final Map<String, dynamic> wiki;

  WikiView(id)
      : this.id = id,
        this.wiki = getWikiAPI(id);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 4,
        child: Scaffold(
            appBar: BackAppBar(
                title: this.wiki['title'],
                actions: [
                  IconButton(
                      icon: Icon(Icons.more_horiz,
                          color: AppTheme.colors.support),
                      onPressed: () {}) // TODO: more dialog
                ],
                bottom: this.topTabs()),
            body: TabBarView(
              children: [
                ItemView(this.id),
                ItemView(this.id),
                ItemView(this.id),
                ItemView(this.id),
              ],
            )));
  }

  Widget topTabs() {
    return Container(
            margin: const EdgeInsets.only(left: AppTheme.horizontalPadding, bottom: 5),
            alignment: Alignment.centerLeft,
            child: TabBar(
                labelColor: AppTheme.colors.fontPalette[0],
                labelStyle: AppTheme.getFont(
                    fontSize: AppTheme.fontSizes.mlarge, isBold: true),
                unselectedLabelColor: AppTheme.colors.fontPalette[0],
                unselectedLabelStyle:
                    AppTheme.getFont(fontSize: AppTheme.fontSizes.mlarge),
                indicator: UnderlineTabIndicator(
                    borderSide:
                        BorderSide(width: 2, color: AppTheme.colors.support)),
                isScrollable: true, // left align
                labelPadding: EdgeInsets.only(left: 0, right: 0), // no space between
                tabs: ['View', 'Argue', 'Link', 'History']
                    .map((tab) => Padding(
                        padding: const EdgeInsets.only(
                            left: 2, right: 10, bottom: 5),
                        child: Text(tab)))
                    .toList()));
  }
}
