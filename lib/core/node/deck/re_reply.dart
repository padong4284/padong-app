import 'package:padong/core/node/deck/reply.dart';

// parent: Reply
class ReReply extends Reply {
  ReReply();

  ReReply.fromMap(String id, Map snapshot) : super.fromMap(id, snapshot);

  @override
  generateFromMap(String id, Map snapshot) => ReReply.fromMap(id, snapshot);

  @override
  Future<List<int>> getStatistics() async {
    List<int> statistics = await super.getStatistics();
    statistics[1] = null;
    return statistics;
  }
}
