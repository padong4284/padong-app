import 'package:padong/core/node/title_node.dart';
import 'package:padong/core/shared/notification.dart';

// parent: Deck
class Board extends TitleNode with Notification {
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
}
