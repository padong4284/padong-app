import 'package:cloud_firestore/cloud_firestore.dart';
import "package:padong/core/models/user/user.dart";
import "package:padong/core/models/deck/post.dart";
import "package:padong/core/services/firestore_api.dart";
import 'package:padong/locator.dart';

class User extends ModelUser {
  static FirestoreAPI userDB = locator<FirestoreAPI>('Firestore:user');
  static FirestoreAPI postDB = locator<FirestoreAPI>("Firestore:post");

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

  ///getUserByEmail return User instance
  static User getUserByEmail(String email) {
    DocumentSnapshot userInfo;
    try {
      var query = userDB.ref.where("email", isEqualTo: email).limit(1).get();
      query.then((value) => userInfo = value.docs.first);
      return User.fromMap(userInfo.data(), userInfo.id);
    } on StateError catch (e) {
      throw (e);
    }
  }

  /// getFreinds return List<DocumentSnapshot>
  /// * DocumentSnapshot contains user info.
  List<User> getFriends(User user) {
    List<User> friendList;

    //Maybe it will be refactored later.
    for (String friendId in user.friendIds) {
      var query = userDB.ref.where("friendIds", isEqualTo: friendId).get();
      query.then((value) => friendList
          .add(User.fromMap(value.docs.first.data(), value.docs.first.id)));
    }
  }

  ///getPosts return List<DocumentSnapshot>
/*List<Post> getPosts(User user) {
    List<Post> postList;
    try {
      var query = postDB.ref.where("ownerId", isEqualTo: user.id).get();
      query.then((value) => value.docs.fillRange(postList.first, postList.last));
      return postList;
    } on StateError catch (e) {
      throw (e);
    }
  }*/
}
