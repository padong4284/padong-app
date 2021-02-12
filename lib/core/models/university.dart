import 'node.dart';

class ModelUniversity extends ModelNode {

  ModelUniversity({id, title, description, parentNodeId, createdAt, deletedAt,
                  modifiedAt}):
  super(id: id,title:title, description: description,
          parentNodeId: parentNodeId, createdAt: createdAt,
          deletedAt: deletedAt, modifiedAt: modifiedAt);

  ModelUniversity.fromMap(Map snapshot,String id) :
        super.fromMap(snapshot, id);

  toJson() {
    return super.toJson();
  }

}
