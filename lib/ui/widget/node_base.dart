///*********************************************************************
///* Copyright (C) 2021-2021 Taejun Jang <padong4284@gmail.com>
///* All Rights Reserved.
///* This file is part of PADONG.
///*
///* PADONG can not be copied and/or distributed without the express
///* permission of Taejun Jang, Daewoong Ko, Hyunsik Kim, Seongbin Hong
///*
///* Github [https://github.com/padong4284]
///*********************************************************************
import 'package:flutter/material.dart';
import 'package:padong/core/node/title_node.dart';
import 'package:padong/core/padong_router.dart';
import 'package:padong/core/node/mixin/statistics.dart';
import 'package:padong/ui/shared/types.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/widget/button/bottom_buttons.dart';
import 'package:padong/ui/widget/button/profile_button.dart';
import 'package:padong/ui/widget/button/simple_button.dart';
import 'package:padong/ui/widget/dialog/more_dialog.dart';
import 'package:padong/ui/widget/padong_future_builder.dart';

class NodeBase extends StatelessWidget {
  final TitleNode node;
  final Statistics statistics;
  final bool isRoute;
  final bool noProfile;

  NodeBase(this.node,
      {noProfile = false, this.isRoute = true, withStatistics = true})
      : this.statistics = withStatistics ? node : null,
        this.noProfile = noProfile;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: this.isRoute ? this.routePage : null,
        child: Column(
          children: [
            Container(
                child: Stack(children: [
              Hero(tag: 'node${this.node.id}owner', child: this.profile()),
              Hero(tag: 'node${this.node.id}common', child: this.commonArea())
            ])),
            Hero(
                tag: 'node${this.node.id}bottoms',
                child: this.bottomArea(context)),
          ],
        ));
  }

  Widget profile() {
    return noProfile
        ? SizedBox.shrink()
        : Material(
            color: AppTheme.colors.transparent,
            child: PadongFutureBuilder(
                future: this.node.owner,
                builder: (owner) => ProfileButton(owner,
                    size: 40, isAnonym: this.statistics.anonymity)));
  }

  Widget commonArea() {
    return Container(
        padding: EdgeInsets.only(left: this.noProfile ? 4 : 47, right: 10),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Expanded(child: this.topText()), this.time()],
          ),
          this.followText()
        ]));
  }

  Widget topText() {
    return PadongFutureBuilder(
        height: 20,
        future: this.node.owner,
        builder: (owner) => Text(
            this.statistics.anonymity ? 'Anonymous' : owner.userId,
            style: AppTheme.getFont(color: AppTheme.colors.semiSupport)));
  }

  Widget time() {
    DateTime now = DateTime.now();
    DateTime created = this.node.createdAt;
    Duration diff = now.difference(created);
    String time = diff.inDays > 0
        ? '${created.month}/${created.day}/${created.year}'
        : (diff.inHours > 0
            ? diff.inHours.toString() +
                ' hour${diff.inHours > 1 ? 's' : ''} ago'
            : diff.inMinutes.toString() +
                ' minute${diff.inMinutes > 1 ? 's' : ''} ago');
    return Text(time,
        style: AppTheme.getFont(
            color: AppTheme.colors.semiSupport,
            fontSize: AppTheme.fontSizes.small));
  }

  Widget followText() {
    return Text(this.node.title,
        textAlign: TextAlign.left,
        style: AppTheme.getFont(color: AppTheme.colors.support, isBold: true));
  }

  Widget bottomArea(BuildContext context, {List<int> hides}) {
    return Material(
        color: AppTheme.colors.transparent,
        child: Stack(
          children: [
            BottomButtons(this.statistics, left: 0, hides: hides),
            Positioned(
                bottom: 5,
                right: 0,
                child: SimpleButton('',
                    buttonSize: ButtonSize.SMALL,
                    icon: Icon(Icons.more_horiz,
                        color: AppTheme.colors.support, size: 20),
                    onTap: () => MoreDialog.show(context)))
          ],
        ));
  }

  void routePage() =>
      PadongRouter.routeURL('/${this.node.type}?id=${this.node.id}', this.node);
}
