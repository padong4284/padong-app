import 'package:flutter/material.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/widgets/tiles/node/node_base_tile.dart';
import 'package:padong/ui/widgets/buttons/star_rate_button.dart';

class ReviewTile extends NodeBaseTile {
  ReviewTile({@required id}) : super(id: id, leftPadding: 8);

  @override
  Widget followText() {
    return Column(children: [
      StarRateButton(rate: this.info['rate'], size: 25, disable: true),
      Text(this.info['description'],
          style: AppTheme.getFont(
              color: AppTheme.colors.support,
              fontSize: AppTheme.fontSizes.regular))
    ]);
  }

  @override
  Widget bottom() {
    this.info['bottoms'][2] = null;
    return super.bottom();
  }
}
