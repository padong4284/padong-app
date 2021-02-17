
import 'package:meta/meta.dart';
import 'package:padong/core/models/deck/board.dart';
import 'package:padong/core/models/event/time_range.dart';

/*
* ModelEvent's parentNodeId is ModelTable
* */

enum TIME_CATEGORY{
  DATE,
  ANNUAL,
  MONTHLY,
  WEEKLY
}
class ModelEvent extends ModelBoard {
  TIME_CATEGORY timeCategory;
  List<TimeRange> times;

  ModelEvent({
    id,
    title, description,
    @required this.timeCategory,
    @required this.times,
    parentNodeId, ownerId, pip,
    createdAt, deletedAt, modifiedAt}):
      super(id: id,
        title:title, description: description,
        parentNodeId: parentNodeId, ownerId: ownerId, pip: pip,
        createdAt: createdAt, deletedAt: deletedAt, modifiedAt: modifiedAt);

  ModelEvent.fromMap(Map snapshot,String id) :
      this.timeCategory = TIME_CATEGORY.values[snapshot['timeCategory'] ?? TIME_CATEGORY.DATE] ,
      this.times = snapshot['times'].map((x) => TimeRange.fromMap(x, id)) ?? [],
      super.fromMap(snapshot, id);

  toJson() {
    return {
      ...super.toJson(),
      'timeCategory': this.timeCategory.index,
      'times': this.times.map((e) => e.toJson()),
    };
  }

}
