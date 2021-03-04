import 'package:padong/core/node/node.dart';

class Message extends Node {
  String message;
  bool isImage;

  Message.fromMap(String id, Map snapshot)
      : this.message = snapshot['message'],
        this.isImage = snapshot['isImage'],
        super.fromMap(id, snapshot);

  @override
  Map<String, dynamic> toJson() {
    return {
      ...super.toJson(),
      'message': this.message,
      'isImage': this.isImage,
    };
  }

  @override
  Future<bool> create(String parentId, Map data) async {
    if (await super.create(parentId, data)) {
      // TODO: FIXME: update is safe?
      await fireDB
          .collection(this.type)
          .doc(parentId) // ChatRoom
          .update({'lastMessage': message});
      return true;
    }
    return false;
  }
}
