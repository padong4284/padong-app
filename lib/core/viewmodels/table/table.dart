import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:padong/core/models/event/table.dart';
import 'package:padong/core/services/firestore_api.dart';

import 'package:padong/locator.dart';


/*
* ModelTable's parentNodeId is ModelUser
* */

class Table extends ModelTable {
  static final FirestoreAPI _tableDB = locator<FirestoreAPI>("Firestore:table");

  Table({
    id,
    parentNodeId, ownerId, pip,
    createdAt, deletedAt, modifiedAt}):
        super(
          id: id,
          parentNodeId: parentNodeId, ownerId: ownerId, pip: pip,
          createdAt: createdAt, deletedAt: deletedAt, modifiedAt: modifiedAt);

  Table.fromMap(Map snapshot,String id) :
        super.fromMap(snapshot, id);

  static Future<Table> getTableById(String id) async {
    DocumentSnapshot docTable = await _tableDB.ref.doc(id).get();
    if (docTable.exists){
      return Table.fromMap(docTable.data(), docTable.id);
    }
    throw Exception("TableId doesn't exists");
  }

}

