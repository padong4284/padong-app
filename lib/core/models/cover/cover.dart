import 'package:padong/core/models/deck/deck.dart';

/*
* ModelCover's parentNodeId is ModelUniversity
* */

class ModelCover extends ModelDeck {

  ModelCover({
    id,
    parentNodeId, ownerId, pip,
    createdAt, deletedAt, modifiedAt}):
        super(
          id: id,
          parentNodeId: parentNodeId, ownerId: ownerId, pip: pip,
          createdAt: createdAt, deletedAt: deletedAt, modifiedAt: modifiedAt);

  ModelCover.fromMap(Map snapshot,String id) :
        super.fromMap(snapshot, id);

  toJson() {
    return super.toJson();
  }
}