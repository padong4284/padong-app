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

  Event();

  Event.fromMap(String id, Map snapshot)
      : this.periodicity = parsePERIODICITY(snapshot['periodicity']),
        this.times = <TimeManager>[
          ...snapshot['times'].map((time) => TimeManager.fromString(time))
        ],
        this.alerts = <String>[...snapshot['alerts']],
        super.fromMap(id, {...snapshot, 'rule': MEMO_RULE});

  @override
  generateFromMap(String id, Map snapshot) => Event.fromMap(id, snapshot);

  @override
  Map<String, dynamic> toJson() {
    return {
      ...super.toJson(),
      'rule': MEMO_RULE,
      'periodicity': periodicityToString(this.periodicity),
      'times': this.times.map((tManager) => tManager.toString()).toList().toString(),
      'alerts': this.alerts,
    };
  }
}
