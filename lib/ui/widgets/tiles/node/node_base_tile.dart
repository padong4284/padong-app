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
    'rate': 4.5,
    'description':
        "It's description of the Node, very long string. In summary it would be truncated.",
    'bottoms': [0, 0, 0],
  };
}

class NodeBaseTile extends StatelessWidget {
  final String _id;
  final Map<String, dynamic> info;
  final bool noProfile;
  final double leftPadding;

  NodeBaseTile({@required id, noProfile = false, this.leftPadding = 0.0})
      : this._id = id,
        this.noProfile = noProfile,
        this.info = getNodeInfo(id);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: this.callback,
        child: Container(
            padding: EdgeInsets.only(left: this.leftPadding),
            child: Column(children: [
              Container(
                  margin: const EdgeInsets.only(top: 12),
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Column(
                    children: [
                      Container(
                          child: Stack(children: [
                        noProfile ? SizedBox() : this.profile(),
                        this.commonArea()
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

  Widget commonArea() {
    return Container(
      padding: EdgeInsets.only(left: this.noProfile ? 4 : 47, right: 10),
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
    return InkWell(
        onTap: () {}, // TODO: route to user profile
        child: Icon(Icons.account_circle,
            color: AppTheme.colors.support, size: 40));
  }

  Widget bottom() {
    return Stack(
      children: [
        BottomButtons(left: -12, bottoms: info['bottoms']),
        Positioned(
            bottom: 3,
            right: 0,
            child: TranspButton(
                buttonSize: ButtonSize.SMALL,
                icon: Icon(Icons.more_horiz,
                    color: AppTheme.colors.support, size: 20),
                callback: this.moreCallback))
      ],
    );
  }

  void callback() {
    // TODO: Route to Post
    // TODO: separate bottom to expand with routing
  }

  void moreCallback() {
    // TODO: Click more button " ... "
  }
}
