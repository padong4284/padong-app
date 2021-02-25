import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:padong/core/models/user/user.dart';
import 'package:padong/core/services/firestore_api.dart';

import 'package:padong/locator.dart';


/*
* ModelUser has no parent
* */

class User extends ModelUser {
  static final FirestoreAPI _userDB = locator<FirestoreAPI>("Firestore:user");

  User({
    id, uid,
    userName, userNickName, userId, userEmails,
    profileImage, isVerified, friendIds,
    parentNodeId, ownerId, pip,
    createdAt, deletedAt, modifiedAt}):
        super(
          id: id,
          uid: uid,
          parentNodeId: parentNodeId, ownerId: ownerId, pip: pip,
          userEmails: userEmails, userName: userName, userNickName: userNickName,
          userId: userId, profileImage: profileImage, isVerified: isVerified, friendIds: friendIds,
          createdAt: createdAt, deletedAt: deletedAt, modifiedAt: modifiedAt);


  User.fromMap(Map snapshot,String id) :
        super.fromMap(snapshot, id);

  static Future<User> getUserById(String id) async {
    DocumentSnapshot docUser = await _userDB.ref.doc(id).get();
    if (docUser.exists){
      return User.fromMap(docUser.data(), docUser.id);
    }
    throw Exception("UserId doesn't exists");
  }

  /// getFreinds return List<User>
  Future<List<User>> getFriends() async{
    List<User> friendList;

    //Maybe it will be refactored later.
    for (String friendId in this.friendIds) {
      QuerySnapshot query = await _userDB.ref.where(
          "id", isEqualTo: friendId).get();
      if (query.size == 0) {
        continue;
      }
      friendList.add(
          User.fromMap(query.docs.first.data(), query.docs.first.id));
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
/*List<Post> getPosts() {
    return Post.getPostsById(this.id);
  }*/
}