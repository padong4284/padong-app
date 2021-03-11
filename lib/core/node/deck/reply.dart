import 'package:padong/core/node/node.dart';
import 'package:padong/core/shared/statistics.dart';

// parent: Post
class Reply extends Node with Statistics {
  bool anonymity; // hide profile
  String description;
  String grandParentId;

  Reply();

  Reply.fromMap(String id, Map snapshot)
      : this.anonymity = snapshot['anonymity'],
        this.description = snapshot['description'],
        super.fromMap(id, snapshot) {
    this.likes = snapshot['likes'];
    this.bookmarks = snapshot['bookmarks'];
  }

  @override
  generateFromMap(String id, Map snapshot) => Reply.fromMap(id, snapshot);

  @override
  Map<String, dynamic> toJson() {
    return {
      ...super.toJson(),
      'anonymity': this.anonymity,
      'description': this.description,
      'grandParentId': this.grandParentId,
      'likes': this.likes,
      'bookmarks': this.bookmarks,
    };
  }

  @override
  Future<List<int>> getStatistics() async {
    List<int> statistics = await super.getStatistics();
    statistics[2] = null;
    return statistics;
  }
}
