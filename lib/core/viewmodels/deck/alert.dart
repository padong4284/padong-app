import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:padong/core/models/deck/alert.dart';
import 'package:padong/core/services/firestore_api.dart';

import 'package:padong/locator.dart';
import 'package:meta/meta.dart';

/*
* ModelAlert's parentNodeId is category of ModelBoard, ModelPost
* */
class Alert extends ModelAlert {
  static final FirestoreAPI _alertDB = locator<FirestoreAPI>("Firestore:alert");

  Alert(
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

  Alert.fromMap(Map snapshot, String id) : super.fromMap(snapshot, id);

  static Future<Alert> getAlertById(String id) async {
    DocumentSnapshot docAlert = await _alertDB.ref.doc(id).get();
    if (docAlert.exists) {
      return Alert.fromMap(docAlert.data(), docAlert.id);
    }
    throw Exception("AlertId doesn't exists");
  }
}
