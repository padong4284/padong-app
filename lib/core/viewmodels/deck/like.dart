import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:padong/core/models/deck/like.dart';
import 'package:padong/core/services/firestore_api.dart';

import 'package:padong/locator.dart';


/*
* ModelLike's parentNodeId is ModelPosts
* */
class Like extends ModelLike {
  static final FirestoreAPI _likeDB = locator<FirestoreAPI>("Firestore:like");

  Like({id, parentNodeId, ownerId, pip, createdAt, deletedAt,
    modifiedAt}):
        super(id: id,
          parentNodeId: parentNodeId, ownerId: ownerId, pip: pip,
          createdAt: createdAt, deletedAt: deletedAt, modifiedAt: modifiedAt);

  Like.fromMap(Map snapshot,String id) :
        super.fromMap(snapshot, id);

  static Future<Like> getLikeById(String id) async {
    DocumentSnapshot docLike = await _likeDB.ref.doc(id).get();
    if (docLike.exists){
      return Like.fromMap(docLike.data(), docLike.id);
    }
    throw Exception("PostId doesn't exists");
  }

}

