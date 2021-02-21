import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:padong/core/models/cover/item.dart';
import 'package:padong/core/services/firestore_api.dart';
import 'package:padong/locator.dart';

/*
* ModelCover's parentNodeId is ModelUniversity
* */

class Item extends ModelItem {
  static final FirestoreAPI _itemDB = locator<FirestoreAPI>("Firestore:item");

  Item({
    id,
    title, description,
    anonymity, attachments,
    parentNodeId, ownerId, pip,
    createdAt, deletedAt, modifiedAt}):
        super(id: id,
          title:title, description: description,
          anonymity: anonymity,
          attachments: attachments,
          parentNodeId: parentNodeId, ownerId: ownerId, pip: pip,
          createdAt: createdAt, deletedAt: deletedAt, modifiedAt: modifiedAt);
  Item.fromMap(Map snapshot,String id) :
        super.fromMap(snapshot, id);

  static Future<Item> getItemById(String id) async {
    DocumentSnapshot docItem = await _itemDB.ref.doc(id).get();
    if (docItem.exists){
      return Item.fromMap(docItem.data(), docItem.id);
    }
    throw Exception("ItemId doesn't exists");
  }

}
