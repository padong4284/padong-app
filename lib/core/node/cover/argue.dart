import 'package:padong/core/node/deck/reply.dart';

// parent: Item
class Argue extends Reply {
  @override // always profile!
  bool anonymity = false;
  bool isClosed;
  String wikiId;

  Argue.fromMap(String id, Map snapshot)
      : this.isClosed = snapshot['isClosed'],
        this.wikiId = snapshot['wikiId'],
        super.fromMap(id, {...snapshot, 'anonymity': false});

  @override
  Map<String, dynamic> toJson() {
    return {
      ...super.toJson(),
      'anonymity': false,
      'isClosed': this.isClosed,
      'wikiId': this.wikiId,
    };
  }
}
