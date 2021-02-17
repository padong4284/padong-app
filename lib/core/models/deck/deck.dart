
import 'package:padong/core/models/node.dart';


/*
* ModelDeck's parentNodeId is ModelUniversity
* */
class ModelDeck extends ModelNode {

  ModelDeck({id, parentNodeId, ownerId, pip, createdAt, deletedAt,
    modifiedAt}):
        super(id: id,
          parentNodeId: parentNodeId, ownerId: ownerId, pip: pip,
          createdAt: createdAt, deletedAt: deletedAt, modifiedAt: modifiedAt);

  ModelDeck.fromMap(Map snapshot,String id) :
        super.fromMap(snapshot, id);

  toJson() {
    return super.toJson();
  }

}