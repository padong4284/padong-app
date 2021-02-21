import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:padong/core/models/event/lecture.dart';
import 'package:padong/core/services/firestore_api.dart';

import 'package:padong/locator.dart';


/*
* Lecture's parentNodeId is ModelTable
* */

class Lecture extends ModelLecture {
  static final FirestoreAPI _lectureDB = locator<FirestoreAPI>("Firestore:lecture");

  Lecture({
    id,
    title, description,
    professor, room, grade, exam, attendance, book,
    times,
    parentNodeId, ownerId, pip,
    createdAt, deletedAt, modifiedAt}):
        super(id: id,
          title:title, description: description,
          professor: professor, room: room, grade: grade, exam: exam, attendance: attendance,
          book: book,
          times: times,
          parentNodeId: parentNodeId, ownerId: ownerId, pip: pip,
          createdAt: createdAt, deletedAt: deletedAt, modifiedAt: modifiedAt);

  Lecture.fromMap(Map snapshot,String id) :
        super.fromMap(snapshot, id);

  static Future<Lecture> getLectureById(String id) async {
    DocumentSnapshot docLecture = await _lectureDB.ref.doc(id).get();
    if (docLecture.exists){
      return Lecture.fromMap(docLecture.data(), docLecture.id);
    }
    throw Exception("LectureId doesn't exists");
  }

}

