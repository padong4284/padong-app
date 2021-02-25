import 'package:padong/core/models/title_node.dart';

/*
* ModelBoard's parentNodeId is ModelDeck
* */
class ModelBoard extends ModelTitleNode {

  ModelBoard({id, type, title, description, parentNodeId, ownerId, pip, createdAt, deletedAt,
    modifiedAt}):
        super(id: id, type: type ?? "Board",
          title:title, description: description,
          parentNodeId: parentNodeId, ownerId: ownerId, pip: pip,
          createdAt: createdAt, deletedAt: deletedAt, modifiedAt: modifiedAt);

  ModelBoard.fromMap(Map snapshot,String id) :
        super.fromMap(snapshot, id);

  toJson() {
    return super.toJson();
  }

}
