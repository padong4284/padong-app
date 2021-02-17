import "package:padong/core/models/node.dart";
import "package:padong/core/services/firestore_api.dart";


class User extends ModelNode {
  static FirestoreAPI db = FirestoreAPI("User");
  Map<String,dynamic> userInfo;

  User({id, parentNodeId, ownerId, pip,
    createdAt, deletedAt, modifiedAt}) :
        super(id: id,
          parentNodeId: parentNodeId,
          ownerId: ownerId,
          pip: pip,
          createdAt: createdAt,
          deletedAt: deletedAt,
          modifiedAt: modifiedAt);

  User.fromMap(Map<String,dynamic> snapshot, String id):
        super.fromMap(snapshot, id);

  //user 찾기
  void setUserFromSnapshot(String id) async{
    this.userInfo = await db.getDocumentById(id).then(
            (value) => value.data) ?? "";
    User.fromMap(userInfo, userInfo["id"] ?? "");
  }

  List<User> getFriendsFromUser() async{

    return [1,2,3,r];
  }

}