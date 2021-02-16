import 'package:flutter/cupertino.dart';
import 'package:padong/core/models/deck/deck.dart';

/*
* ModelProfile's parentNodeId is ModelUser
* */

class ModelProfile extends ModelDeck {
  String profileImage;
  ModelProfile({
    id,
    parentNodeId, ownerId, pip,
    @required this.profileImage,
    createdAt, deletedAt, modifiedAt}):
        super(
          id: id,
          parentNodeId: parentNodeId, ownerId: ownerId, pip: pip,
          createdAt: createdAt, deletedAt: deletedAt, modifiedAt: modifiedAt);

  ModelProfile.fromMap(Map snapshot,String id) :
      this.profileImage = snapshot['profileImage'] ?? "",
      super.fromMap(snapshot, id);

  toJson() {
    return {
      ...super.toJson(),
      'profileImage': this.profileImage,
    };
  }
}