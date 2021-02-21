import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:padong/core/models/deck/board.dart';
import 'package:padong/core/services/firestore_api.dart';

import 'package:padong/locator.dart';


/*
* ModelBoard's parentNodeId is ModelDeck
* * */
class Board extends ModelBoard {
  static final FirestoreAPI _boardDB = locator<FirestoreAPI>("Firestore:board");

  Board({id, title, description, parentNodeId, ownerId, pip, createdAt, deletedAt,
    modifiedAt}):
        super(id: id,
          title:title, description: description,
          parentNodeId: parentNodeId, ownerId: ownerId, pip: pip,
          createdAt: createdAt, deletedAt: deletedAt, modifiedAt: modifiedAt);

  Board.fromMap(Map snapshot,String id) :
        super.fromMap(snapshot, id);

  static Future<Board> getBoardById(String id) async {
    DocumentSnapshot docReply = await _boardDB.ref.doc(id).get();
    if (docReply.exists){
      return Board.fromMap(docReply.data(), docReply.id);
    }
    throw Exception("PostId doesn't exists");
  }

}

