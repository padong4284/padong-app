
import 'package:padong/core/models/title_node.dart';

/*
* ModelDeck's parentNodeId is ModelUniversity
* */
class ModelDeck extends ModelTitleNode {

  ModelDeck({id, title, description, parentNodeId, ownerId, pip, createdAt, deletedAt,
    modifiedAt}):
        super(id: id,
          title:title, description: description,
          parentNodeId: parentNodeId, ownerId: ownerId, pip: pip,
          createdAt: createdAt, deletedAt: deletedAt, modifiedAt: modifiedAt);

  ModelDeck.fromMap(Map snapshot,String id) :
        super.fromMap(snapshot, id);

  toJson() {
    return super.toJson();
  }

}