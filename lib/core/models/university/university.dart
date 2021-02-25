import '../title_node.dart';

class ModelUniversity extends ModelTitleNode {

  ModelUniversity({
    id,
    title, description,
    parentNodeId, ownerId, pip,
    createdAt, deletedAt, modifiedAt}):
  super(
          id: id, type: "University",
          title:title, description: description,
          parentNodeId: parentNodeId, ownerId: ownerId, pip: pip,
          createdAt: createdAt, deletedAt: deletedAt, modifiedAt: modifiedAt);

  ModelUniversity.fromMap(Map snapshot,String id) :
        super.fromMap(snapshot, id);

  toJson() {
    return super.toJson();
  }

}
