import 'package:padong/core/node/deck/board.dart';
import 'package:padong/core/shared/constants.dart';
import 'package:padong/core/shared/types.dart';
import 'package:padong/ui/utils/time_manager.dart';

// parent: Schedule
class Event extends Board {
  @override
  String rule = MEMO_RULE;
  PERIODICITY periodicity;
  List<TimeManager> times;
  List<String> alerts;

  Event.fromMap(String id, Map snapshot)
      : this.periodicity = parsePERIODICITY(snapshot['periodicity']),
        this.times = snapshot['times']
            .map((time) => TimeManager.fromString(time))
            .toList(),
        this.alerts = snapshot['alerts'],
        super.fromMap(id, {...snapshot, 'rule': MEMO_RULE});

  @override
  Map<String, dynamic> toJson() {
    return {
      ...super.toJson(),
      'rule': MEMO_RULE,
      'periodicity': periodicityToString(this.periodicity),
      'times': this.times.map((time) => time.toString()).toList().toString(),
      'alerts': this.alerts,
    };
  }
}
