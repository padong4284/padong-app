import '../node.dart';

class ModelUser extends ModelNode {
  String userName;
  String userNickName;
  String userId;
  String userEmail;

  ModelUser({
    id,
    this.userName, this.userNickName, this.userId, this.userEmail,
    parentNodeId, ownerId, pip,
    createdAt, deletedAt, modifiedAt}):
        super(
          id: id,
          parentNodeId: parentNodeId, ownerId: ownerId, pip: pip,
          createdAt: createdAt, deletedAt: deletedAt, modifiedAt: modifiedAt);

  ModelUser.fromMap(Map snapshot,String id) :
        this.userName = snapshot['userName'] ?? "",
        this.userNickName = snapshot['userNickName'] ?? "",
        this.userId = snapshot['userId'] ?? "",
        this.userEmail = snapshot['userEmail'] ?? "",
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
