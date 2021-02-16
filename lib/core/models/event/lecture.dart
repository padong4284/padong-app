import 'event.dart';

/*
* ModelLecture's parentNodeId is ModelTable
* */
class ModelMap extends ModelEvent {
  String professor;
  String room;
  String grade;
  String exam;
  String attendance;
  String book;

  ModelMap({
    id,
    title, description,
    this.professor, this.room, this.grade, this.exam, this.attendance, this.book,
    times,
    parentNodeId, ownerId, pip,
    createdAt, deletedAt, modifiedAt}):
        super(id: id,
          title:title, description: description,
          timeCategory: TIME_CATEGORY.WEEKLY,
          times: times,
          parentNodeId: parentNodeId, ownerId: ownerId, pip: pip,
          createdAt: createdAt, deletedAt: deletedAt, modifiedAt: modifiedAt);

  ModelMap.fromMap(Map snapshot,String id) :
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