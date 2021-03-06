import 'package:padong/core/node/deck/post.dart';
import 'package:padong/ui/utils/compare/diff_line.dart';

// parent: Wiki
class Item extends Post {
  @override // always profile!
  bool anonymity = false;
  int deleted; // count deleted line
  int inserted; // count inserted line
  String prevDescription;

  Item.fromMap(String id, Map snapshot)
      : this.deleted = snapshot['deleted'],
        this.inserted = snapshot['inserted'],
        this.prevDescription = snapshot['prevDescription'],
        super.fromMap(id, {...snapshot, 'anonymity': false});

  @override
  Map<String, dynamic> toJson() {
    this.calculateDiff();
    return {
      ...super.toJson(),
      'anonymity': false,
      'prevId': this.prevDescription,
      'deleted': this.deleted,
      'inserted': this.inserted,
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

  void calculateDiff() {
    this.deleted = 0;
    this.inserted = 0;
    List<Diff> diffs = diffLine(this.prevDescription, this.description);
    for (Diff diff in diffs) {
      if (diff.op == DELETE)
        this.deleted += 1;
      else if (diff.op == INSERT) this.inserted += 1;
    }
  }
}
