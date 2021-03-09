import 'package:padong/core/node/deck/post.dart';

// parent: Lecture (1:1 match)
class Evaluation extends Post {
  double rate;

  Evaluation();

  Evaluation.fromMap(String id, Map snapshot)
      : this.rate = snapshot['rate'],
        super.fromMap(id, {...snapshot});

  @override
  generateFromMap(String id, Map snapshot) => Evaluation.fromMap(id, snapshot);

  @override
  Map<String, dynamic> toJson() {
    return {
      ...super.toJson(),
      'rate': this.rate,
    };
  }
}
