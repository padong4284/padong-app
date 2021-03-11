import 'package:padong/core/node/deck/reply.dart';

// parent: Reply
class ReReply extends Reply {
  String grandParentId;

  ReReply();

  ReReply.fromMap(String id, Map snapshot)
      :
        this.grandParentId= snapshot['grandParentId'],
        super.fromMap(id, snapshot);

  @override
  generateFromMap(String id, Map snapshot) => ReReply.fromMap(id, snapshot);

  @override
  Future<List<int>> getStatistics() async {
    List<int> statistics = await super.getStatistics();
    statistics[1] = null;
    return statistics;
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      ...super.toJson(),
      'grandParentId': this.grandParentId,
    };
  }
}
