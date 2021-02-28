import 'package:flutter/material.dart';
import 'package:padong/core/apis/cover.dart';
import 'package:padong/core/padong_router.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/widgets/bars/back_app_bar.dart';
import 'package:padong/ui/widgets/buttons/floating_bottom_button.dart';
import 'package:padong/ui/widgets/buttons/padong_floating_button.dart';
import 'package:padong/ui/views/templates/safe_padding_template.dart';
import 'package:padong/ui/widgets/containers/tab_container.dart';
import 'package:padong/ui/widgets/paddong_markdown.dart';
import 'package:padong/ui/widgets/title_header.dart';

class ItemView extends StatelessWidget {
  final String id;
  final Map<String, dynamic> wiki;

  ItemView(id)
      : this.id = id,
        this.wiki = getWikiAPI(id);

  @override
  Widget build(BuildContext context) {
    return SafePaddingTemplate(
        floatingActionButtonGenerator: (isScrollingDown) =>
            PadongFloatingButton(
                isScrollingDown: isScrollingDown, bottomPadding: 40),
        floatingBottomBarGenerator: (isScrollingDown) => FloatingBottomButton(
            title: 'edit',
            onTap: () {
              PadongRouter.routeURL(
                  'edit/id=${this.wiki['parentId']}&wikiId=${this.id}');
            },
            isScrollingDown: isScrollingDown),
        children: [
          Column(children: [
            TitleHeader(this.wiki['title'], link: "/wiki/id=${this.id}"),
            PadongMarkdown(this.wiki['description'])
          ]),
        ]);
  }
}
