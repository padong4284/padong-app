import 'package:padong/core/node/title_node.dart';
import 'package:padong/core/node/common/user.dart';
import 'package:padong/core/node/common/subscribe.dart';

// parent: Deck
class Board extends TitleNode {
  String rule; // rule of this board, showing at Write page

  Board.fromMap(String id, Map snapshot)
      : this.rule = snapshot['rule'],
        super.fromMap(id, snapshot);

  @override
  Map<String, dynamic> toJson() {
    return {
      ...super.toJson(),
      'rule': this.rule,
    };
  }

  List<TitleNode> getNotices() {
    // TODO: get notice posts!
    // only owner can write, set isNotice
    return [];
  }

  bool isSubscribed(User me) {
    // TODO: get user's Alert setting
    return false;
  }

  void updateSubscribe(User me, bool isSubscribed) {
    // TODO: update user's Subscribe setting
    Subscribe.fromMap('', {});
  }
}
