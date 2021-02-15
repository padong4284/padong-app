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
  final bool noProfile;
  final bool noBottom;
  final bool isReply;
  final bool isReReply;

  NodeTile({@required id, noProfile = false, noBottom = false, isReply = false, isReReply = false})
      : this._id = id,
        assert(!(isReply || isReReply) || !(noProfile || noBottom)),
        this.isReply = isReply,
        this.isReReply = isReReply,
        this.noProfile = noProfile,
        this.noBottom = noBottom,
        this.info = getNodeInfo(id);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {}, // TODO: callback, Route to Post / ReReply to Reply
        child: Container(
            padding: EdgeInsets.only(left: this.isReply ? 8: this.isReReply ? 40 :0),
            child: Column(children: [
              Container(
                  margin: const EdgeInsets.only(top: 12),
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Column(
                    children: [
                      Container(
                          child: Stack(children: [
                        noProfile ? SizedBox() : this.profile(),
                        this.commonArea(isProfile: !noProfile)
                      ])),
                      this.noBottom ? SizedBox(height: 10) : this.bottom(),
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
      padding: EdgeInsets.only(left: isProfile ? 47 : 4, right: 10),
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
    if (this.isReReply) info['bottoms'][1] = null;
    if (this.isReply || this.isReReply) info['bottoms'][2] = null;
    return Stack(
      children: [
        BottomButtons(left:-12, bottoms: info['bottoms']),
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
