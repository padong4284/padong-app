import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:padong/core/models/deck/bookmark.dart';
import 'package:padong/core/services/firestore_api.dart';

import 'package:padong/locator.dart';
import 'package:meta/meta.dart';

/*
* ModelBookmark's parentNodeId is category of ModelPost
* */
class Bookmark extends ModelBookmark {
  static final FirestoreAPI _bookmarkDB = locator<FirestoreAPI>("Firestore:bookmark");

  Bookmark(
      {id,
      @required parentType,
      parentNodeId,
      ownerId,
      pip,
      createdAt,
      deletedAt,
      modifiedAt})
      : super(
            id: id,
            parentType: parentType,
            parentNodeId: parentNodeId,
            ownerId: ownerId,
            pip: pip,
            createdAt: createdAt,
            deletedAt: deletedAt,
            modifiedAt: modifiedAt);

  Bookmark.fromMap(Map snapshot, String id) : super.fromMap(snapshot, id);

  static Future<Bookmark> getBookmarkById(String id) async {
    DocumentSnapshot docBookmark = await _bookmarkDB.ref.doc(id).get();
    if (docBookmark.exists) {
      return Bookmark.fromMap(docBookmark.data(), docBookmark.id);
    }
    throw Exception("BookmarkId doesn't exists");
  }
}
