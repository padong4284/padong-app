import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:padong/core/models/deck/like.dart';
import 'package:padong/core/services/firestore_api.dart';
import 'package:padong/locator.dart';


/*
* ModelLike's parentNodeId is ModelPosts
* */

abstract class ILike {
  Future<bool> createLike();
  Future<bool> deleteLike();
}

class Like extends ModelLike{
  static final FirestoreAPI _likeDB = locator<FirestoreAPI>("Firestore:like");

  Like({id, type, parentType, parentNodeId, ownerId, pip, createdAt, deletedAt,
    modifiedAt}):
        super(id: id, type: type, parentType :parentType,
          parentNodeId: parentNodeId, ownerId: ownerId, pip: pip,
          createdAt: createdAt, deletedAt: deletedAt, modifiedAt: modifiedAt);

  Like.fromMap(Map snapshot,String id) :
        super.fromMap(snapshot, id);

  static Future<Like> getLikeById(String id) async {
    DocumentSnapshot docLike = await _likeDB.ref.doc(id).get();
    if (docLike.exists){
      return Like.fromMap(docLike.data(), docLike.id);
    }
    throw Exception("LikeId doesn't exists");
  }

  Future<bool> addLikeToFirebase() async{
    try{
      dynamic instance= await getLikeById(this.id);
      if (instance != null) {
        return true; // already like is existed.
      }
      return true;

    }on Exception catch(e){
      _likeDB.ref.add(this.toJson());
       return true;
    }
  }

  Future<bool> deleteLikeAtFirebase() async {
    try {
      dynamic instance = await getLikeById(this.id);
      if (instance != null) {
        _likeDB.ref.doc(this.id).delete();
        return true;
      }
      return false;
    } on Exception catch (e) {
      return false; // already like is existed.
    }
  }
}

