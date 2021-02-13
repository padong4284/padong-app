import 'base_node.dart';

class ModelUser extends ModelBaseNode {
  String userName;
  String userNickName;
  String userId;
  String userEmail;

  ModelUser({id, userName, userNickName, userId, userEmail, parentNodeId, createdAt, deletedAt,
    modifiedAt}):
        super(id: id,
          parentNodeId: parentNodeId, createdAt: createdAt,
          deletedAt: deletedAt, modifiedAt: modifiedAt);

  ModelUser.fromMap(Map snapshot,String id) :
        super.fromMap(snapshot, id);

  toJson() {
    return {
      ...super.toJson(),
      'userName': this.userName,
      'userNickName': this.userNickName,
      'userId': this.userId,
      'userEmail': this.userEmail,
    };
  }

}
