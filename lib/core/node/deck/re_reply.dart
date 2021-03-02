import 'package:padong/core/node/node.dart';
import 'package:padong/core/shared/statistics.dart';

// parent: Post
class ReReply extends Node with Statistics {
  bool anonymity; // hide profile
  String description;

  ReReply.fromMap(String id, Map snapshot)
      : this.anonymity = snapshot['anonymity'],
        this.description = snapshot['description'],
        super.fromMap(id, snapshot);

  @override
  Map<String, dynamic> toJson() {
    return {
      ...super.toJson(),
      'anonymity': this.anonymity,
      'description': this.description,
    };
  }

  @override
  List<int> getStatistics() {
    List<int> statistics = super.getStatistics();
    statistics[1] = null;
    statistics[2] = null;
    return statistics;
  }
}
