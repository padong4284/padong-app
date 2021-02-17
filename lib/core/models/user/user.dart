import 'package:meta/meta.dart';

import '../node.dart';

class ModelUser extends ModelNode {
  String userName;
  String userNickName;
  String userId;
  String userEmail;
  String profileImage;
  bool isVerified;

  ModelUser({
    id,
    @required this.userName, @required this.userNickName, @required this.userId, @required this.userEmail,
    @required this.profileImage, @required this.isVerified,
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
        this.isVerified = snapshot['isVerified'] ?? false,
        super.fromMap(snapshot, id);

  toJson() {
    return {
      ...super.toJson(),
      'userName': this.userName,
      'userNickName': this.userNickName,
      'userId': this.userId,
      'userEmail': this.userEmail,
      'isVerified': this.isVerified,
    };
  }

}
