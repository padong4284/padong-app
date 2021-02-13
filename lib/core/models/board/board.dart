import '../title_node.dart';

class Board extends ModelTitleNode {

  Board({id, title, description, parentNodeId, ownerId, pip, createdAt, deletedAt,
    modifiedAt}):
        super(id: id,
          title:title, description: description,
          parentNodeId: parentNodeId, ownerId: ownerId, pip: pip,
          createdAt: createdAt, deletedAt: deletedAt, modifiedAt: modifiedAt);

  Board.fromMap(Map snapshot,String id) :
        super.fromMap(snapshot, id);

  toJson() {
    return super.toJson();
  }

}
