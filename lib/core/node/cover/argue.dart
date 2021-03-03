import 'package:padong/core/node/deck/reply.dart';

// parent: Wiki
class Argue extends Reply {
  @override // always profile!
  final bool anonymity = false;
  bool isClosed;

  Argue.fromMap(String id, Map snapshot)
      : this.isClosed = snapshot['isClosed'],
        super.fromMap(id, snapshot);

  @override
  Map<String, dynamic> toJson() {
    return {
      ...super.toJson(),
      'isClosed': this.isClosed,
    };
  }
}
