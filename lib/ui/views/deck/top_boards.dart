import 'package:flutter/material.dart';
import 'package:padong/core/apis/deck.dart';
import 'package:padong/ui/widgets/containers/tab_container.dart';
import 'package:padong/ui/widgets/containers/horizontal_scroller.dart';
import 'package:padong/ui/widgets/cards/post_card.dart';

class TopBoards extends StatelessWidget {
  final Map<String, dynamic> univ;
  final List<String> topBoards = ['Popular', 'Favorite', 'Inform'];

  TopBoards(this.univ);

  @override
  Widget build(BuildContext context) {
    return TabContainer(
            tabWidth: 80.0,
            tabs: this.topBoards,
            moreIds: this
                .topBoards
                .map((boardName) =>
                    this.univ['fixedBoards'][boardName].toString())
                .toList(),
            children: this.topBoards.map((boardName) {
              List<String> recent =
                  get10RecentPostIdsAPI(this.univ['fixedBoards'][boardName]);
              return HorizontalScroller(
                  padding: 3.0,
                  children: recent.map((postId) => PostCard(postId)).toList());
            }).toList());
  }
}
