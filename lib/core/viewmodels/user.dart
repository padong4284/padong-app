import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:padong/core/models/university/university.dart';
import "package:padong/core/models/user/user.dart";
import "package:padong/core/models/deck/post.dart";
import "package:padong/core/services/firestore_api.dart";
import 'package:padong/locator.dart';

class User extends ModelUser {
  final FirestoreAPI _userDB = locator<FirestoreAPI>('Firestore:user');

  User(
      {id,
      parentNodeId,
      ownerId,
      userName,
      userNickName,
      userId,
      userEmail,
      profileImage,
      isVerified,
      friendIds,
      pip,
      createdAt,
      deletedAt,
      modifiedAt})
      : super(
            id: id,
            parentNodeId: parentNodeId,
            ownerId: ownerId,
            pip: pip,
            userEmail: userEmail,
            userName: userName,
            userNickName: userNickName,
            userId: userId,
            isVerified: isVerified,
            friendIds: friendIds,
            profileImage: profileImage,
            createdAt: createdAt,
            deletedAt: deletedAt,
            modifiedAt: modifiedAt);

  User.fromMap(Map<String, dynamic> snapshot, String id)
      : super.fromMap(snapshot, id);

  ///getUserById return User instance
  Future<User> getUserById(String id) async {
    DocumentSnapshot userInfo;
    try {
      var query = await _userDB.ref.where("id", isEqualTo: id).limit(1).get();
      userInfo = query.docs.first;
      return User.fromMap(userInfo.data(), userInfo.id);

    } on StateError catch (e) {
      throw (e);
    }
  }

  /// getFreinds return List<User>
  Future<List<User>> getFriends() async{
    List<User> friendList;

    //Maybe it will be refactored later.
    for (String friendId in this.friendIds) {
      try{
        var query = await  _userDB.ref.where("friendIds", isEqualTo: friendId).get();
        friendList.add(User.fromMap(query.docs.first.data(), query.docs.first.id);
      }on StateError catch(e){
        throw (e);
      }
    }
    return friendList;
  }

  /// getParent return ModelUniversity
  //todo : erase remark when Uiversity_view_model is done.
  /*Future<ModelUniversity> getParent(){
    University university;
    return university.getUniversityById(this.parentNodeId);
  }*/

  ///getPosts return List<Post>
  //todo : erase remark when Post_view_model is done.
List<Post> getPosts() {
    return Post.getPostsById(this.id);
  }
}
