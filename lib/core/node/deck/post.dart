import 'package:padong/core/node/title_node.dart';
import 'package:padong/core/shared/statistics.dart';

// parent: Board
class Post extends TitleNode with Statistics {
  bool anonymity; // hide profile
  bool isNotice;

  Post.fromMap(String id, Map snapshot)
      : this.anonymity = snapshot['anonymity'],
        this.isNotice = snapshot['isNotice'],
        super.fromMap(id, snapshot);

  @override
  Map<String, dynamic> toJson() {
    return {
      ...super.toJson(),
      'anonymity': this.anonymity,
      'isNotice': this.isNotice,
    };
  }
}
