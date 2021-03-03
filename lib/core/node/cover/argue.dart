import 'package:padong/core/node/deck/reply.dart';

// parent: Wiki
class Argue extends Reply {
  @override // always profile!
  bool anonymity = false;
  bool isClosed;

  Argue.fromMap(String id, Map snapshot)
      : this.isClosed = snapshot['isClosed'],
        super.fromMap(id, {...snapshot, 'anonymity': false});

  @override
  Map<String, dynamic> toJson() {
    return {
      ...super.toJson(),
      'anonymity': false,
      'isClosed': this.isClosed,
    };
  }
}
