import 'package:padong/core/node/deck/post.dart';

// parent: Wiki
class Item extends Post {
  @override // always profile!
  bool anonymity = false;

  Item.fromMap(String id, Map snapshot)
      : super.fromMap(id, {...snapshot, 'anonymity': false});

  @override
  Map<String, dynamic> toJson() {
    return {
      ...super.toJson(),
      'anonymity': false,
    };
  }

  void revertWikiToThisItem() {
    // TODO: revert Wiki to this Item
    // check current Item & User authority
  }

  String compareWithOther(Item other) {
    // TODO #207 diff_match_patch
    return '';
  }
}
