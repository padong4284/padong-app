import 'package:padong/core/node/node.dart';
import 'package:padong/core/shared/statistics.dart';

// parent: Post
class Reply extends Node with Statistics {
  bool anonymity; // hide profile
  String description;

  Reply();

  Reply.fromMap(String id, Map snapshot)
      : this.anonymity = snapshot['anonymity'],
        this.description = snapshot['description'],
        super.fromMap(id, snapshot);

  @override
  generateFromMap(String id, Map snapshot) => Reply.fromMap(id, snapshot);

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
    statistics[2] = null;
    return statistics;
  }
}
