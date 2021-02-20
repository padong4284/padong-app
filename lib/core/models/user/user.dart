import 'package:meta/meta.dart';
import '../node.dart';


class ModelUser extends ModelNode {
  String userName;
  String userNickName;
  String userId;
  List<String> userEmails;
  String profileImage;
  bool isVerified;
  List<String> friendIds;

  ModelUser({
    id,
    @required this.userName, @required this.userNickName, @required this.userId, @required this.userEmails,
    @required this.profileImage, @required this.isVerified, @required this.friendIds,
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
        this.userEmails = snapshot['userEmails'] ?? [],
        this.isVerified = snapshot['isVerified'] ?? false,
        this.friendIds = snapshot['friendIds'] ?? [],
        super.fromMap(snapshot, id);

  toJson() {
    return {
      ...super.toJson(),
      'userName': this.userName,
      'userNickName': this.userNickName,
      'userId': this.userId,
      'userEmail': this.userEmails,
      'isVerified': this.isVerified,
      "friendIds":this.friendIds,
    };
  }

}