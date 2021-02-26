import 'package:flutter/material.dart';
import 'package:padong/core/apis/deck.dart';
import 'package:padong/core/apis/padong_router.dart';
import 'package:padong/ui/shared/types.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/widgets/buttons/bottom_buttons.dart';
import 'package:padong/ui/widgets/buttons/transp_button.dart';
import 'package:padong/ui/widgets/buttons/user_profile_button.dart';

class NodeBase extends StatelessWidget {
  final String id;
  final Map<String, dynamic> node;
  final bool noProfile;

  NodeBase(id, {noProfile = false})
      : this.id = id,
        this.noProfile = noProfile,
        this.node = getNodeAPI(id);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: this.routeToPage,
        child: Column(
          children: [
            Container(
                child: Stack(children: [
              this.profile(), // checking noProfile in this Function
              this.commonArea()
            ])),
            this.bottomArea(),
          ],
        ));
  }

  Widget profile() {
    return noProfile
        ? SizedBox.shrink()
        : UserProfileButton(this.node['ownerId'], size: 40);
  }

  Widget commonArea() {
    return Container(
      padding: EdgeInsets.only(left: this.noProfile ? 4 : 47, right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Expanded(child: this.topText()), this.time()],
          ),
          this.followText()
        ],
      ),
    );
  }

  Widget topText() {
    return Text(getUserAPI(this.node['ownerId'])['username'],
        style: AppTheme.getFont(color: AppTheme.colors.semiSupport));
  }

  Widget time() {
    return Text(this.node['time'],
        style: AppTheme.getFont(
            color: AppTheme.colors.semiSupport,
            fontSize: AppTheme.fontSizes.small));
  }

  Widget followText() {
    return Text(this.node['title'],
        style: AppTheme.getFont(color: AppTheme.colors.support, isBold: true));
  }

  Widget bottomArea() {
    return Stack(
      children: [
        BottomButtons(left: 0, bottoms: this.node['bottoms']),
        Positioned(
            bottom: 5,
            right: 0,
            child: TranspButton(
                buttonSize: ButtonSize.SMALL,
                icon: Icon(Icons.more_horiz,
                    color: AppTheme.colors.support, size: 20),
                callback: this.moreCallback))
      ],
    );
  }

  void routeToPage() {
    // TODO: separate bottom for expand animation
    PadongRouter.routeURL('/post/id=${this.id}');
    // TODO: not a post, this.type!
  }

  void moreCallback() {
    // TODO: Click more button " ... "
  }
}
