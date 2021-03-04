import 'package:padong/core/node/schedule/evaluation.dart';
import 'package:padong/core/shared/types.dart';

// parent: Building
class Service extends Evaluation {
  SERVICE category;

  Service.fromMap(String id, Map snapshot)
      : this.category = parseSERVICE(snapshot['category']),
        super.fromMap(id, {...snapshot, 'anonymity': false});

  @override
  Map<String, dynamic> toJson() {
    return {
      ...super.toJson(),
      'category': serviceToString(this.category),
    };
  }
}
