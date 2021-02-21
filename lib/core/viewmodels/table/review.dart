import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:padong/core/models/event/review.dart';
import 'package:padong/core/services/firestore_api.dart';

import 'package:padong/locator.dart';


/*
* ModelReview's parentNodeId is ModelLecture
* */

class Review extends ModelReview {
  static final FirestoreAPI _reviewDB = locator<FirestoreAPI>("Firestore:review");

  Review({
    id,
    title, description,
    anonymity, attachments,
    parentNodeId, ownerId, pip,
    createdAt, deletedAt, modifiedAt}):
        super(id: id,
          title:title, description: description,
          anonymity: anonymity, attachments: attachments,
          parentNodeId: parentNodeId, ownerId: ownerId, pip: pip,
          createdAt: createdAt, deletedAt: deletedAt, modifiedAt: modifiedAt);


  Review.fromMap(Map snapshot,String id) :
        super.fromMap(snapshot, id);

  static Future<Review> getReviewById(String id) async {
    DocumentSnapshot docReview = await _reviewDB.ref.doc(id).get();
    if (docReview.exists){
      return Review.fromMap(docReview.data(), docReview.id);
    }
    throw Exception("ReviewId doesn't exists");
  }

}

