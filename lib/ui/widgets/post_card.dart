import 'package:flutter/material.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/widgets/summary_buttons.dart';

class PostCard extends StatelessWidget {
  final String _id; // node's _id
  final String title;
  final String description;

  PostCard(id, {this.title, this.description}) : this._id = id;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {},
        // TODO: Routing to Post
        child: SizedBox(
            width: 140,
            height: 220,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
              elevation: 3.0,
              margin: const EdgeInsets.all(5),
              child: Column(children: [
                Container(
                  decoration: BoxDecoration(
                      color: AppTheme.colors.lightSupport,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(5),
                          topRight: Radius.circular(5))),
                  width: 140,
                  height: 130,
                ),
                Container(
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.only(
                        top: 10.0, left: 10.0, right: 10.0),
                    child: Text('Title', // TODO: this.title
                        style: TextStyle(
                            height: 1.25,
                            color: AppTheme.colors.fontPalette[2],
                            letterSpacing: 0.025,
                            fontWeight: FontWeight.bold,
                            fontSize: AppTheme.fontSizes.regular))),
                Container(
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.only(left: 10.0, right: 10.0),
                    child: Text('Summary', // TODO: this.description2summary
                        style: TextStyle(
                            height: 1.25,
                            color: AppTheme.colors.fontPalette[3],
                            letterSpacing: 0.025,
                            fontSize: AppTheme.fontSizes.regular))),
                SummaryButtons(summary: [0, null, 0]),
              ]),
            )));
  }
}
