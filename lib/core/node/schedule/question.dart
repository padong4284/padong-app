import 'package:padong/core/node/deck/post.dart';

// parent: Lecture
class Question extends Post {
  Question();

  Question.fromMap(String id, Map snapshot) : super.fromMap(id, snapshot);

  @override
  generateFromMap(String id, Map snapshot) => Question.fromMap(id, snapshot);

// TODO: Adopt an answer
}
