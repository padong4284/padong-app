import 'package:padong/core/node/node.dart';

class Message extends Node {
  String message;
  bool isImage;

  Message();

  Message.fromMap(String id, Map snapshot)
      : this.message = snapshot['message'],
        this.isImage = snapshot['isImage'],
        super.fromMap(id, snapshot);

  @override
  generateFromMap(String id, Map snapshot) => Message.fromMap(id, snapshot);

  @override
  Map<String, dynamic> toJson() {
    return {
      ...super.toJson(),
      'message': this.message,
      'isImage': this.isImage,
    };
  }
}
