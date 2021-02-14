import 'package:padong/core/models/deck/deck.dart';

/*
* ModelTable's parentNodeId is ModelUser
* */

class ModelTable extends ModelDeck {
  ModelTable({
    id,
    parentNodeId, ownerId, pip,
    createdAt, deletedAt, modifiedAt}):
        super(
          id: id,
          parentNodeId: parentNodeId, ownerId: ownerId, pip: pip,
          createdAt: createdAt, deletedAt: deletedAt, modifiedAt: modifiedAt);

  ModelTable.fromMap(Map snapshot,String id) :
        super.fromMap(snapshot, id);

  toJson() {
    return super.toJson();
  }
}