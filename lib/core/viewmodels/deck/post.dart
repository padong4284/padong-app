import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:padong/core/models/deck/post.dart';
import 'package:padong/core/services/firestore_api.dart';

import 'package:padong/locator.dart';


/*
* ModelPost's parentNodeId is ModelBoard
* * */
class Post extends ModelPost {
  static final FirestoreAPI _postDB = locator<FirestoreAPI>("Firestore:post");

  Post({
    id,
    title, description,
    anonymity,
    attachments,
    parentNodeId, ownerId, pip,
    createdAt, deletedAt, modifiedAt}):
        super(
          id: id,
          title: title, description: description,
          anonymity: anonymity, attachments: attachments,
          parentNodeId: parentNodeId, ownerId: ownerId, pip: pip,
          createdAt: createdAt, deletedAt: deletedAt, modifiedAt: modifiedAt);

  Post.fromMap(Map snapshot,String id) :
        super.fromMap(snapshot, id);

  static Future<Post> getPostById(String id) async {
    DocumentSnapshot docPost = await _postDB.ref.doc(id).get();
    if (docPost.exists){
      return Post.fromMap(docPost.data(), docPost.id);
    }
    throw Exception("PostId doesn't exists");
  }

}

