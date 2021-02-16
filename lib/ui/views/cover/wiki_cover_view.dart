import 'package:flutter/material.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/widgets/safe_padding_template.dart';
import 'package:padong/ui/widgets/univ_door.dart';
import 'package:padong/ui/widgets/title_bar.dart';

class WikiCoverView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafePaddingTemplate(
      title: 'Wiki',
      children: [
        UnivDoor(univName: 'Georgia Tech', slogan: 'Progress and Service'),
        this.emblemArea(),
        SizedBox(height: 50),
        TitleBar('Title', link: 'url1234567890'),
        SizedBox(height: 50),
        TitleBar('Title', moreCallback: (){}),
        SizedBox(height: 50),
        TitleBar('Title'),
        SizedBox(height: 50),
        TitleBar('Title', isInputHead: true),
      ],
    );
  }

  Widget emblemArea() {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 12),
        child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
          DecoratedBox(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(32),
                  boxShadow: [
                    BoxShadow(color: Colors.black12, blurRadius: 10)
                  ]),
              child: CircleAvatar(
                radius: 32,
                // TODO: use fire storage get emblem
                // backgroundImage: NetworkImage(_profileImageURL)
                // https://here4you.tistory.com/235
                backgroundColor: AppTheme.colors.lightSupport,
              )),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Icon(Icons.place_rounded,
                  color: AppTheme.colors.primary, size: 30)),
          Text('North Ave NW,\nAtlanta, GA 30332')
        ]));
  }
}
