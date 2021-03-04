import 'package:padong/core/node/deck/reply.dart';

// parent: Evaluation
class Review extends Reply {
  @override // always anonymous!
  bool anonymity = true;
  double rate;

  Review.fromMap(String id, Map snapshot)
      : this.rate = snapshot['rate'],
        super.fromMap(id, {...snapshot, 'anonymity': true});

  @override
  Map<String, dynamic> toJson() {
    return {
      ...super.toJson(),
      'anonymity': true,
      'rate': this.rate,
    };
  }

  @override
  Future<bool> create(String parentId, Map data) async {
    // TODO: transaction to update Evaluation's rate
    return await super.create(parentId, data);
  }

  @override
  bool update(Map data) {
    // TODO: transaction to update Evaluation's rate
    return super.update(data);
  }
}
