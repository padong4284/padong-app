import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:padong/core/node/common/user.dart';
import 'package:padong/core/node/deck/reply.dart';
import 'package:padong/core/node/node.dart';
import 'package:padong/core/service/padong_fb.dart';
import 'package:padong/core/shared/types.dart';

mixin Statistics on Node {
  List<String> likes;
  List<String> bookmarks;

  @override
  Map<String, dynamic> toJson() {
    return {
      ...super.toJson(),
      'likes': this.likes,
      'bookmarks': this.bookmarks,
    };
  }

  bool isLiked(User me) {
    if (this.likes.contains(me.id)) {
      return true;
    }
    return false;
  }

  bool isBookmarked(User me) {
    if (this.bookmarks.contains(me.id)) {
      return true;
    }
    return false;
  }

  Future<void> updateLiked(User me, bool isLiked) async {
    var thisData = this.toJson();
    Map<String, dynamic> likeData = new Map<String, dynamic>();
    WriteBatch batch = FirebaseFirestore.instance.batch();
    var result = (await PadongFB.getDocsByRule("like",
        rule: (q) => q
            .where("parentType", isEqualTo: this.type)
            .where("ownerId", isEqualTo: me.id)));

    if (isLiked) {
      //Add Like
      likeData = {
        'parentType': this.type,
        'pip': PIP.INTERNAL,
        'parentId': this.id,
        'ownerId': me.id,
        'createdAt': DateTime.now().toIso8601String(),
        'modifiedAt': DateTime.now().toIso8601String(),
      };
      thisData['likes'] = FieldValue.arrayUnion([me.id]);

      batch.set(PadongFB.getDocRef("like"), likeData);
      batch.set(PadongFB.getDocRef(this.type, this.id), thisData);
    } else {
      //Remove Like
      if (result.isNotEmpty) {
        batch.delete(PadongFB.getDocRef("like", result.first.id));
      }
      thisData['likes'] = FieldValue.arrayRemove([me.id]);
    }
    await batch.commit();
  }

  Future<void> updateBookmarked(User me, bool isBookmarked) async {
    var thisData = this.toJson();
    Map<String, dynamic> bookmarkData = new Map<String, dynamic>();
    WriteBatch batch = FirebaseFirestore.instance.batch();
    var result = (await PadongFB.getDocsByRule("bookmark",
        rule: (q) => q
            .where("parentType", isEqualTo: this.type)
            .where("ownerId", isEqualTo: me.id)));

    if (isBookmarked) {
      //Add Like
      bookmarkData = {
        'parentType': this.type,
        'pip': PIP.INTERNAL,
        'parentId': this.id,
        'ownerId': me.id,
        'createdAt': DateTime.now().toIso8601String(),
        'modifiedAt': DateTime.now().toIso8601String(),
      };
      thisData['bookmarks'] = FieldValue.arrayUnion([me.id]);

      batch.set(PadongFB.getDocRef("bookmark"), bookmarkData);
      batch.set(PadongFB.getDocRef(this.type, this.id), thisData);
    } else {
      //Remove Like
      if (result.isNotEmpty) {
        batch.delete(PadongFB.getDocRef("bookmark", result.first.id));
      }
      thisData['bookmarks'] = FieldValue.arrayRemove([me.id]);
    }
    await batch.commit();
  }

  Future<List<int>> getStatistics() async {
    // TODO: [Like, Reply & ReReply, Bookmark]
    var replyResult = await this.getChildren(new Reply());
    var reReplyResult = (await PadongFB.getDocsByRule("rereply",
        rule: (q) => q
            .where("grandParentId", isEqualTo: this.id)));

    return [this.likes.length, replyResult.length + reReplyResult.length, this.bookmarks.length];
  }
}
