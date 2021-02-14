import 'package:flutter/material.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/shared/types.dart';
import 'package:padong/ui/widgets/buttons/transp_button.dart';

class EventCard extends StatelessWidget {
  final String _id; // node's _id
  final String timeRange;
  final String date;
  final List<String> alerts;
  final String description;

  EventCard(id,
      {@required this.timeRange,
      @required this.date,
      this.alerts,
      this.description})
      : this._id = id;

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
                padding: const EdgeInsets.all(17),
                child: Column(children: <Widget>[
                  Container(
                      alignment: Alignment.centerLeft,
                      child: Text(this.timeRange,
                          style: AppTheme.getFont(
                              color: AppTheme.colors.primary,
                              fontSize: AppTheme.fontSizes.mlarge,
                              isBold: true))),
                  Container(
                      alignment: Alignment.topLeft,
                      margin: const EdgeInsets.only(top: 4, bottom: 4),
                      child: Text(this.date,
                          style: AppTheme.getFont(
                              color: AppTheme.colors.fontPalette[1],
                              fontSize: AppTheme.fontSizes.large,
                              isBold: true))),
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
