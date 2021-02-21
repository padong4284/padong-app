import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:padong/core/models/chatroom/chatroom.dart';
import 'package:padong/core/services/firestore_api.dart';

import 'package:padong/locator.dart';


/*
* ModelChatRoom has no parent
* */
class Chatroom extends ModelChatroom {
  static final FirestoreAPI _chatroomDB = locator<FirestoreAPI>("Firestore:chatroom");

  Chatroom({
    id,
    title, description,
    parentNodeId, ownerId,
    participants,
    pip, createdAt, deletedAt,
    modifiedAt}):
        super(id: id,
          title:title, description: description,
          parentNodeId: parentNodeId, ownerId: ownerId, pip: pip,
          participants: participants,
          createdAt: createdAt, deletedAt: deletedAt, modifiedAt: modifiedAt);

  Chatroom.fromMap(Map snapshot,String id) :
        super.fromMap(snapshot, id);

  static Future<Chatroom> getChatroomById(String id) async {
    DocumentSnapshot docChatroom = await _chatroomDB.ref.doc(id).get();
    if (docChatroom.exists){
      return Chatroom.fromMap(docChatroom.data(), docChatroom.id);
    }
    throw Exception("ChatroomId doesn't exists");
  }
}
