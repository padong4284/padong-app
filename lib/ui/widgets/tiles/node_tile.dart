import 'package:flutter/material.dart';
import 'package:padong/ui/shared/types.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/widgets/buttons/bottom_buttons.dart';
import 'package:padong/ui/widgets/buttons/transp_button.dart';

Map<String, dynamic> getNodeInfo(String id) {
  return {
    // TODO: move to Logical module
    'time': '2 minutes',
    'owner': 'tae7130',
    'title': 'Title',
    'description': "It's description of the Node",
    'bottoms': [0, 0, 0],
  };
}

class NodeTile extends StatelessWidget {
  final String _id;
  final Map<String, dynamic> info;

  NodeTile({@required id})
      : this._id = id,
        this.info = getNodeInfo(id);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {}, // TODO: callback
        child: Container(
            padding: const EdgeInsets.only(left: 0),
            child: Column(children: [
              Container(
                  margin: const EdgeInsets.only(top: 12),
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Column(
                    children: [
                      Container(
                          child: Stack(children: [
                        this.profile(),
                        this.commonArea(isProfile: true)
                      ])),
                      this.bottom(),
                    ],
                  )),
              Container(
                  height: 2,
                  color: AppTheme.colors.lightSupport,
                  margin: const EdgeInsets.only(top: 5))
            ])));
  }

  Widget commonArea({bool isProfile = false}) {
    return Container(
      padding: EdgeInsets.only(left: isProfile ? 47 : 0, right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [this.topText(), this.time()],
          ),
          this.followText()
        ],
      ),
    );
  }

  Widget topText() {
    return Text(this.info['owner'],
        style: AppTheme.getFont(
            color: AppTheme.colors.semiSupport,
            fontSize: AppTheme.fontSizes.regular));
  }

  Widget time() {
    return Text(this.info['time'],
        style: AppTheme.getFont(
            color: AppTheme.colors.semiSupport,
            fontSize: AppTheme.fontSizes.small));
  }

  Widget followText() {
    return Text(this.info['title'],
        style: AppTheme.getFont(
            color: AppTheme.colors.support,
            fontSize: AppTheme.fontSizes.regular,
            isBold: true));
  }

  Widget profile() {
    assert(this.info['owner'] != null);
    return InkWell(
        onTap: () {}, // TODO: route to user profile
        child: Icon(Icons.account_circle,
            color: AppTheme.colors.support, size: 40));
  }

  Widget bottom() {
    return Stack(
      children: [
        BottomButtons(bottoms: info['bottoms']),
        Positioned(
            bottom: 3,
            right: 0,
            child: TranspButton(
                buttonSize: ButtonSize.SMALL,
                icon: Icon(Icons.more_horiz,
                    color: AppTheme.colors.support, size: 20),
                callback: () {})) // TODO: more callback
      ],
    );
  }
}
