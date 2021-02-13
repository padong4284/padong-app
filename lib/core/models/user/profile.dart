import '../node.dart';


class ModelProfile extends ModelNode {
  String profileImage;
  String userNickName;
  String userId;
  String userEmail;

  ModelProfile({
    id,
    this.profileImage, userNickName, userId, userEmail,
    parentNodeId, ownerId, pip,
    createdAt, deletedAt, modifiedAt}):
        super(
          id: id,
          parentNodeId: parentNodeId, ownerId: ownerId, pip: pip,
          createdAt: createdAt, deletedAt: deletedAt, modifiedAt: modifiedAt);

  ModelProfile.fromMap(Map snapshot,String id) :
        this.profileImage = snapshot['profileImage'] ?? "",
        this.userNickName = snapshot['userNickName'] ?? "",
        this.userId = snapshot['userId'] ?? "",
        this.userEmail = snapshot['userEmail'] ?? "",
        super.fromMap(snapshot, id);

  toJson() {
    return {
      ...super.toJson(),
      'profileImage': this.profileImage,
      'userNickName': this.userNickName,
      'userId': this.userId,
      'userEmail': this.userEmail,
    };
  }

}
