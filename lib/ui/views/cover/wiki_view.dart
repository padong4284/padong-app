import 'package:flutter/material.dart';
import 'package:padong/core/apis/cover.dart';
import 'package:padong/core/padong_router.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/widgets/bars/back_app_bar.dart';
import 'package:padong/ui/widgets/buttons/floating_bottom_button.dart';
import 'package:padong/ui/widgets/buttons/padong_floating_button.dart';
import 'package:padong/ui/views/templates/safe_padding_template.dart';
import 'package:padong/ui/widgets/paddong_markdown.dart';

class WikiView extends StatelessWidget {
  final String id;
  final Map<String, dynamic> wiki;

  WikiView(id)
      : this.id = id,
        this.wiki = getWikiAPI(id);

  @override
  Widget build(BuildContext context) {
    return SafePaddingTemplate(
      floatingActionButtonGenerator: (isScrollingDown) => PadongFloatingButton(
          isScrollingDown: isScrollingDown, bottomPadding: 40),
      floatingBottomBarGenerator: (isScrollingDown) => FloatingBottomButton(
          title: 'edit',
          onTap: () {
            PadongRouter.routeURL('write/id=${this.id}');
          },
          isScrollingDown: isScrollingDown),
      appBar: BackAppBar(title: this.wiki['title'], actions: [
        IconButton(
            icon: Icon(Icons.more_horiz, color: AppTheme.colors.support),
            onPressed: () {})
      ]),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10.0),
          child: PadongMarkdown(this.wiki['description']),
        ),
      ],
    );
  }
}
