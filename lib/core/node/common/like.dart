import 'package:padong/core/node/node.dart';

// parent: Post, Reply, ReReply
class Like extends Node {
  String parentType;

  Like();

  Like.fromMap(String id, Map snapshot)
      : this.parentType = snapshot['parentType'],
        super.fromMap(id, snapshot);

  @override
  generateFromMap(String id, Map snapshot) => Like.fromMap(id, snapshot);

  @override
  Map<String, dynamic> toJson() {
    return {'parentType': this.parentType, ...super.toJson()};
  }
}
