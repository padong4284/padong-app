import 'package:padong/core/models/deck/deck.dart';

/*
* ModelMap's parentNodeId is ModelUniversity
* */

class ModelMap extends ModelDeck {
  ModelMap({
    id,
    parentNodeId, ownerId, pip,
    createdAt, deletedAt, modifiedAt}):
        super(
          id: id,
          parentNodeId: parentNodeId, ownerId: ownerId, pip: pip,
          createdAt: createdAt, deletedAt: deletedAt, modifiedAt: modifiedAt);

  ModelMap.fromMap(Map snapshot,String id) :
        super.fromMap(snapshot, id);

  toJson() {
    return super.toJson();
  }
}