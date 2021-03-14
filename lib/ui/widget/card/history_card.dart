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
import 'package:padong/core/node/cover/item.dart';
import 'package:padong/core/padong_router.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/widget/card/base_card.dart';
import 'package:padong/ui/widget/node_base.dart';
import 'package:padong/util/time_manager.dart';

class HistoryCard extends NodeBase {
  HistoryCard(Item item) : super(item);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: this.routePage,
        child: BaseCard(children: [super.build(context)]));
  }

  @override
  Widget time() {
    DateTime created = this.node.createdAt;
    String time =
        TimeManager.formatTime(created.hour, created.minute, created.second);
    return Text(time,
        style: AppTheme.getFont(
            color: AppTheme.colors.semiSupport,
            fontSize: AppTheme.fontSizes.small));
  }

  @override
  Widget bottomArea({List<int> hides}) {
    return Container(
        padding: const EdgeInsets.only(top: 2),
        transform: Matrix4.translationValues(0.0, 5.0, 0.0),
        child: Stack(
          children: [
            Row(
              children: [
                Icon(Icons.add_rounded,
                    size: 15, color: AppTheme.colors.primary),
                Container(
                    width: 30,
                    child: Text((this.node as Item).inserted.toString(),
                        style: AppTheme.getFont(
                            color: AppTheme.colors.primary,
                            fontSize: AppTheme.fontSizes.small))),
                Icon(Icons.remove_rounded,
                    size: 15, color: AppTheme.colors.pointRed),
                SizedBox(
                    width: 30,
                    child: Text((this.node as Item).deleted.toString(),
                        style: AppTheme.getFont(
                            color: AppTheme.colors.pointRed,
                            fontSize: AppTheme.fontSizes.small)))
              ],
            ),
            Positioned(
                bottom: 2,
                right: 0,
                child: Text(
                  'e' + this.node.id,
                  style: AppTheme.getFont(
                      color: AppTheme.colors.fontPalette[2],
                      fontSize: AppTheme.fontSizes.small),
                ))
          ],
        ));
  }

  @override
  void routePage() =>
      PadongRouter.routeURL('/compare?id=${this.node.id}&type=item', this.node);
}
