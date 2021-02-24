import 'package:meta/meta.dart';
import '../node.dart';


class ModelUser extends ModelNode {
  String uid;
  String userName;
  String userNickName;
  String userId;
  String userEmail;
  String profileImage;
  bool isVerified;
  List<String> friendIds;

  ModelUser({
    id, @required this.uid,
    @required this.userName, @required this.userNickName, @required this.userId, @required this.userEmail,
    @required this.profileImage, @required this.isVerified, @required this.friendIds,
    parentNodeId, ownerId, pip,
    createdAt, deletedAt, modifiedAt}):
        super(
          id: id,
          parentNodeId: parentNodeId, ownerId: ownerId, pip: pip,
          createdAt: createdAt, deletedAt: deletedAt, modifiedAt: modifiedAt);

  ModelUser.fromMap(Map snapshot,String id) :
        this.uid = snapshot['uid'] ?? "",
        this.userName = snapshot['userName'] ?? "",
        this.userNickName = snapshot['userNickName'] ?? "",
        this.userId = snapshot['userId'] ?? "",
        this.userEmail = snapshot['userEmail'] ?? "",
        this.isVerified = snapshot['isVerified'] ?? false,
        this.friendIds = snapshot['friendIds'] ?? [],
        super.fromMap(snapshot, id);

  toJson() {
    return {
      ...super.toJson(),
      'uid': this.uid,
      'userName': this.userName,
      'userNickName': this.userNickName,
      'userId': this.userId,
      'userEmail': this.userEmail,
      'isVerified': this.isVerified,
      "friendIds":this.friendIds,
    };
  }

}