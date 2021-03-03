import 'package:padong/core/node/deck/post.dart';

// parent: Lecture (1:1 match)
class Evaluation extends Post {
  @override // always profile!
  bool anonymity = false;
  double rate;

  Evaluation.fromMap(String id, Map snapshot)
      : this.rate = snapshot['rate'],
        super.fromMap(id, {...snapshot, 'anonymity': false});

  @override
  Map<String, dynamic> toJson() {
    return {
      ...super.toJson(),
      'anonymity': false,
      'rate': this.rate,
    };
  }
}
