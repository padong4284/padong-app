import 'package:padong/core/shared/types.dart';
import 'package:padong/core/shared/constants.dart';
import 'package:padong/core/node/schedule/event.dart';
import 'package:padong/core/node/schedule/evaluation.dart';

// parent: Schedule
class Lecture extends Event {
  @override
  String rule = ASK_RULE;
  @override
  PERIODICITY periodicity = PERIODICITY.WEEKLY;
  String professor;
  String room;
  String grade;
  String exam;
  String attendance;
  String book;

  Lecture.fromMap(String id, Map snapshot)
      : this.professor = snapshot['professor'],
        this.room = snapshot['room'],
        this.grade = snapshot['grade'],
        this.exam = snapshot['exam'],
        this.attendance = snapshot['attendance'],
        this.book = snapshot['book'],
        super.fromMap(id,
            {...snapshot, 'rule': ASK_RULE, 'periodicity': PERIODICITY.WEEKLY});

  @override
  Map<String, dynamic> toJson() {
    return {
      ...super.toJson(),
      'rule': ASK_RULE,
      'periodicity': periodicityToString(PERIODICITY.WEEKLY),
      'professor': this.professor,
      'room': this.room,
      'grade': this.grade,
      'exam': this.exam,
      'attendance': this.attendance,
      'book': this.book,
    };
  }

  Evaluation getReview() {
    return this.getChildren(type: 'Review', howMany: 1)[0];
  }
}
