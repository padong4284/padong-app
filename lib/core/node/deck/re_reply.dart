import 'package:padong/core/node/deck/reply.dart';

// parent: Reply
class ReReply extends Reply {
  ReReply.fromMap(String id, Map snapshot) : super.fromMap(id, snapshot);

  @override
  List<int> getStatistics() {
    List<int> statistics = super.getStatistics();
    statistics[1] = null;
    return statistics;
  }
}
