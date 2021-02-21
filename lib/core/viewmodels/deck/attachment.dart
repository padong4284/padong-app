import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:padong/core/models/deck/attachment.dart';
import 'package:padong/core/services/firestore_api.dart';

import 'package:padong/locator.dart';


/*
* ModelAttachment's has no parent
* */
class Attachment extends ModelAttachment {
  static final FirestoreAPI _attachmentDB = locator<FirestoreAPI>("Firestore:attachment");

  Attachment({
    id,
    type, location,
    parentNodeId, ownerId, pip,
    createdAt, deletedAt, modifiedAt}):
        super(
          id: id,
          parentNodeId: parentNodeId, ownerId: ownerId, pip: pip,
          type: type, location: location,
          createdAt: createdAt, deletedAt: deletedAt, modifiedAt: modifiedAt);

  Attachment.fromMap(Map snapshot,String id) :
        super.fromMap(snapshot, id);

  static Future<Attachment> getAttachmentById(String id) async {
    DocumentSnapshot docAttachment = await _attachmentDB.ref.doc(id).get();
    if (docAttachment.exists){
      return Attachment.fromMap(docAttachment.data(), docAttachment.id);
    }
    throw Exception("AttachmentId doesn't exists");
  }

}

