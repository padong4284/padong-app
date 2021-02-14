import 'package:flutter/material.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/shared/types.dart';
import 'package:padong/ui/widgets/transp_button.dart';

class SummaryCard extends StatelessWidget {
  final String _id; // node's _id
  final String title;
  final String description;

  SummaryCard(id, {@required this.title, this.description}) : this._id = id;

  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        elevation: 3.0,
        child: InkWell(
            onTap: () {}, // TODO: Routing to Post
            child: Container(
                width: 325,
                height: 160,
                padding: const EdgeInsets.all(17),
                child: Column(children: <Widget>[
                  Container(
                      alignment: Alignment.centerLeft,
                      child: Text(this.title,
                          style: TextStyle(
                              height: 1.25,
                              color: AppTheme.colors.fontPalette[1],
                              letterSpacing: 0.025,
                              fontWeight: FontWeight.bold,
                              fontSize: AppTheme.fontSizes.regular))),
                  Container(
                      alignment: Alignment.topLeft,
                      height: 75,
                      margin: const EdgeInsets.only(top: 4, bottom: 4),
                      child: Text('Summary', // TODO: this.description
                          style: TextStyle(
                              height: 1.25,
                              color: AppTheme.colors.fontPalette[2],
                              letterSpacing: 0.025,
                              fontSize: AppTheme.fontSizes.regular))),
                  Container(
                      alignment: Alignment.bottomRight,
                      margin: const EdgeInsets.only(top: 10),
                      child: TranspButton(
                        title: 'More',
                        // TODO: link to contain post (wiki)
                        buttonSize: ButtonSize.SMALL,
                        color: AppTheme.colors.primary,
                        icon: Icon(Icons.arrow_forward_ios_rounded,
                            color: AppTheme.colors.primary, size: 15.0),
                        isSuffixICon: true,
                      ))
                ]))));
  }
}
