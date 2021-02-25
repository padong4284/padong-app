import 'package:meta/meta.dart';

import 'event.dart';

/*
* ModelLecture's parentNodeId is ModelTable
* */
class ModelLecture extends ModelEvent {
  String professor;
  String room;
  String grade;
  String exam;
  String attendance;
  String book;

  ModelLecture({
    id,
    title, description,
    @required this.professor, @required this.room, @required this.grade, @required this.exam, @required this.attendance, @required this.book,
    times,
    parentNodeId, ownerId, pip,
    createdAt, deletedAt, modifiedAt}):
        super(id: id, type: "Lecture",
          title:title, description: description,
          timeCategory: TIME_CATEGORY.WEEKLY,
          times: times,
          parentNodeId: parentNodeId, ownerId: ownerId, pip: pip,
          createdAt: createdAt, deletedAt: deletedAt, modifiedAt: modifiedAt);

  ModelLecture.fromMap(Map snapshot,String id) :
        this.professor = snapshot['professor'] ?? '',
        this.room = snapshot['room'] ?? '',
        this.grade = snapshot['grade'] ?? '',
        this.exam = snapshot['exam'] ?? '',
        this.attendance = snapshot['attendance'] ?? '',
        this.book = snapshot['book'] ?? '',

        super.fromMap(snapshot, id);

  toJson() {
    return {
      ...super.toJson(),
      'professor': this.professor,
      'room': this.room,
      'grade': this.grade,
      'exam': this.exam,
      'book': this.book,

    };
  }

}
