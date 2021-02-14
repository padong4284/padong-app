import 'package:padong/core/models/deck/board.dart';

/*
* ModelWiki's parentNodeId is cover
* */

class ModelWiki extends ModelBoard {


  ModelWiki({
    id,
    title, description,
    parentNodeId, ownerId, pip,
    createdAt, deletedAt, modifiedAt}):
        super(id: id,
          title:title, description: description,
          parentNodeId: parentNodeId, ownerId: ownerId, pip: pip,
          createdAt: createdAt, deletedAt: deletedAt, modifiedAt: modifiedAt);

  ModelWiki.fromMap(Map snapshot,String id) :
        super.fromMap(snapshot, id);

  toJson() {
    return super.toJson();
  }

}
