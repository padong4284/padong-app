import 'package:padong/core/node/common/bookmark.dart';
import 'package:padong/core/node/common/like.dart';
import 'package:padong/core/node/common/user.dart';
import 'package:padong/core/node/node.dart';

mixin Statistics on Node {
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
    // TODO: [Like, Reply & ReReply, Bookmark]
    return [0, 0, 0];
  }
}