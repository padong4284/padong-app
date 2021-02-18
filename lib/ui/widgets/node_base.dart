import 'package:flutter/material.dart';
import 'package:padong/ui/shared/types.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/widgets/buttons/bottom_buttons.dart';
import 'package:padong/ui/widgets/buttons/transp_button.dart';

Map<String, dynamic> getNode(String id) {
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

class NodeBase extends StatelessWidget {
  final String _id;
  final Map<String, dynamic> node;
  final bool noProfile;

  NodeBase(id, {noProfile = false})
      : this._id = id,
        this.noProfile = noProfile,
        this.node = getNode(id);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            child: Stack(children: [
          noProfile ? SizedBox() : this.profile(),
          this.commonArea()
        ])),
        this.bottomArea(),
      ],
    );
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
    return Text(this.node['owner'],
        style: AppTheme.getFont(
            color: AppTheme.colors.semiSupport));
  }

  Widget time() {
    return Text(this.node['time'],
        style: AppTheme.getFont(
            color: AppTheme.colors.semiSupport,
            fontSize: AppTheme.fontSizes.small));
  }

  Widget followText() {
    return Text(this.node['title'],
        style: AppTheme.getFont(
            color: AppTheme.colors.support,
            isBold: true));
  }

  Widget profile() {
    return InkWell(
        onTap: () {}, // TODO: route to user profile
        child: Icon(Icons.account_circle,
            color: AppTheme.colors.support, size: 40));
  }

  Widget bottomArea() {
    return Stack(
      children: [
        BottomButtons(left: -12, bottoms: this.node['bottoms']),
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

  void moreCallback() {
    // TODO: Click more button " ... "
  }
}
