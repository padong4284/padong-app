import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:padong/core/models/cover/wiki.dart';
import 'package:padong/core/services/firestore_api.dart';
import 'package:padong/locator.dart';

/*
* ModelWiki's parentNodeId is ModelCover
* */

class Wiki extends ModelWiki {
  static final FirestoreAPI _wikiDB = locator<FirestoreAPI>("Firestore:wiki");

  Wiki({
    id,
    title, description,
    parentNodeId, ownerId, pip,
    createdAt, deletedAt, modifiedAt}):
        super(id: id,
          title:title, description: description,
          parentNodeId: parentNodeId, ownerId: ownerId, pip: pip,
          createdAt: createdAt, deletedAt: deletedAt, modifiedAt: modifiedAt);
  Wiki.fromMap(Map snapshot,String id) :
        super.fromMap(snapshot, id);

  static Future<Wiki> getWikiById(String id) async {
    DocumentSnapshot docWiki = await _wikiDB.ref.doc(id).get();
    if (docWiki.exists){
      return Wiki.fromMap(docWiki.data(), docWiki.id);
    }
    throw Exception("WikiId doesn't exists");
  }

}
