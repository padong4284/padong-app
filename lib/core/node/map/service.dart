import 'package:padong/core/node/schedule/evaluation.dart';

// parent: Lecture (1:1 match)
class Service extends Evaluation {
  /// TODO: Service Category ENUM!

  Service.fromMap(String id, Map snapshot)
      : super.fromMap(id, {...snapshot, 'anonymity': false});
}
