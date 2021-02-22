import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:padong/core/models/map/service.dart';
import 'package:padong/core/services/firestore_api.dart';

import 'package:padong/locator.dart';


/*
* ModelService's parentNodeId is ModelBuilding
* */

class Service extends ModelService {
  static final FirestoreAPI _serviceDB = locator<FirestoreAPI>("Firestore:service");

  Service({
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


  Service.fromMap(Map snapshot,String id) :
        super.fromMap(snapshot, id);

  static Future<Service> getServiceById(String id) async {
    DocumentSnapshot docService = await _serviceDB.ref.doc(id).get();
    if (docService.exists){
      return Service.fromMap(docService.data(), docService.id);
    }
    throw Exception("ServiceId doesn't exists");
  }

}

