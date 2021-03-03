import 'package:padong/core/node/node.dart';
import 'package:padong/core/node/schedule/event.dart';

// parent: User
class Schedule extends Node {
  Schedule.fromMap(String id, Map snapshot) : super.fromMap(id, snapshot);

  List<Event> getTodaySchedule() {
    // TODO: get today's events & lectures!
    return [];
  }
}
