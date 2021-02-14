import 'event.dart';

/*
* ModelLecture's parentNodeId is ModelTable
* */
class ModelMap extends ModelEvent {
  ModelMap({
    id,
    title, description,
    //timeCategory,
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
        super.fromMap(snapshot, id);

  toJson() {
    return super.toJson();
  }

}
