import 'package:flutter/material.dart';
import 'package:padong/ui/theme/app_theme.dart';

class UnivDoor extends StatelessWidget {
  final String univName;
  final String slogan;

  UnivDoor({@required this.univName, @required this.slogan, });

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.only(top: 10, bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
            child:Text(
              this.univName,
              style: AppTheme.getFont(
                  isBold: true,
                  color: AppTheme.colors.fontPalette[0],
                  fontSize: AppTheme.fontSizes.xlarge),
            )),
            Text(
              this.slogan,
              style: AppTheme.getFont(
                  color: AppTheme.colors.fontPalette[2],
                  fontSize: AppTheme.fontSizes.mlarge),
            )
          ],
        ));
  }
}
