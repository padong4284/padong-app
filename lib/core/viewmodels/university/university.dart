import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:padong/core/models/university/university.dart';
import 'package:padong/core/services/firestore_api.dart';
import 'package:padong/locator.dart';

/*
* ModelUniversity has no parent
* * */
class University extends ModelUniversity {
  static final FirestoreAPI _universityDB = locator<FirestoreAPI>("Firestore:university");

  University({id, title, description, parentNodeId, ownerId, pip, createdAt, deletedAt,
    modifiedAt}):
        super(id: id,
          title:title, description: description,
          parentNodeId: parentNodeId, ownerId: ownerId, pip: pip,
          createdAt: createdAt, deletedAt: deletedAt, modifiedAt: modifiedAt);

  University.fromMap(Map snapshot,String id) :
        super.fromMap(snapshot, id);

  static Future<University> getUniversityById(String id) async {
    DocumentSnapshot docBoard = await _universityDB.ref.doc(id).get();
    if (docBoard.exists){
      return University.fromMap(docBoard.data(), docBoard.id);
    }
    throw Exception("UniversityId doesn't exists");
  }

}

