import 'package:padong/core/models/board/board.dart';

/*
* ModelBuilding's parentNodeId is ModelMap
* */


class ModelBuilding extends ModelBoard {
  double lat;
  double lng;

  ModelBuilding({
    id,
    title, description,
    parentNodeId, ownerId, pip,
    createdAt, deletedAt, modifiedAt}):
        super(id: id,
          title:title, description: description,
          parentNodeId: parentNodeId, ownerId: ownerId, pip: pip,
          createdAt: createdAt, deletedAt: deletedAt, modifiedAt: modifiedAt);

  ModelBuilding.fromMap(Map snapshot,String id) :
        super.fromMap(snapshot, id);

  toJson() {
    return super.toJson();
  }

}
