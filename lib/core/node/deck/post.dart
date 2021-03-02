import 'package:padong/core/node/title_node.dart';
import 'package:padong/core/node/common/user.dart';
import 'package:padong/core/node/common/bookmark.dart';
import 'package:padong/core/node/common/like.dart';

// parent: Board
class Post extends TitleNode {
  bool anonymity; // hide profile

  Post.fromMap(String id, Map snapshot)
      : this.anonymity = snapshot['anonymity'],
        super.fromMap(id, snapshot);

  @override
  Map<String, dynamic> toJson() {
    return {
      ...super.toJson(),
      'anonymity': this.anonymity,
    };
  }

  bool isLiked(User me) {
    // TODO: get liked or not
    return false;
  }

  bool isBookmarked(User me) {
    // TODO: get bookmarked or not
    return false;
  }

  void updateLiked(User me, bool isLiked) {
    // TODO: update liked
    Like.fromMap('', {});
  }

  void updateBookmarked(User me, bool isBookmarked) {
    // TODO: update bookmarked
    Bookmark.fromMap('', {});
  }

  List<int> getStatistics() {
    // TODO: [Like, Reply & ReReplt, Bookmark]
    return [0, 0, 0];
  }
}
