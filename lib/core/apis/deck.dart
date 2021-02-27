import 'dart:math';

Random rand = Random();

Map<String, dynamic> getUnivAPI(String univId) {
  return {
    'title': 'Georgia Tech',
    'description': 'Progress and Service',
    'emblem': 'https://en.wikipedia.org/wiki/File:Georgia_Tech_seal.svg',
    'fixedBoards': {
      'Global': 'b009000',
      'Public': 'b009001',
      'Internal': 'b009002',
      'Popular': 'b009003',
      'Favorite': 'b009004',
      'Inform': 'b009005',
    },
    'boards': [
      // List of boardId
      'b009023', 'b009346', 'b0092374', 'b009124', 'b009024',
    ]
  };
}

List<String> get10RecentPostIdsAPI(String boardId) {
  /* TODO
  1. Get Board Node
  2. get 10 recent postIds from Board's children
  3. return List<postIds>
  */
  return Iterable<int>.generate(10).map((i) => boardId + i.toString()).toList();
}

Map<String, dynamic> getBoardAPI(String id) {
  // TODO: get board Node from Firebase
  if (id.endsWith('0')) {
    return {
      'id': id,
      'title': 'Global',
      'notification': false,
      'description': '''
This board is GLOBAL board.
Everyone can read and write in this board.
'''
    };
  } else if (id.endsWith('1')) {
    return {
      'id': id,
      'title': 'Public',
      'notification': false,
      'description': '''
This board is PUBLIC board.
Everyone can read this board.
But, only Georgia Tech students can write.
'''
    };
  } else if (id.endsWith('2')) {
    return {
      'id': id,
      'title': 'Internal',
      'notification': false,
      'description': '''
This board is INTERNAL board.
ONLY Georgia Tech students can read and write.
'''
    };
  }
  return {
    'id': id,
    'title': 'Board Title',
    'notification': rand.nextBool(),
    'description': 'sample board description'
  };
}

List<String> getPostIdsAPI(String boardId) {
  return Iterable<int>.generate(10)
      .map((i) => 'p0090043' + i.toString())
      .toList();
}

void setNotificationBoardAPI(String boardId, bool notification) {}

Map<String, dynamic> getUserAPI(String id) {
  return {
    'id': 'u009003',
    'username': 'kodw0402',
    'univId': 'univ009',
    'isVerified': true,
    'universityName': "Georgia Tech",
    'entranceYear': 2017,
    'profileImgURL':
        'https://avatars.githubusercontent.com/u/36005723?s=460&u=49590ea0e7bb1936d515ed627867e8ca217b145b&v=4',
  };
}

Map<String, dynamic> getNodeAPI(String id) {
  return {
    // TODO: move to Logical module
    'id': id,
    'title': 'Title',
    'type': 'node',
    'ownerId': 'u009003',
    'bottoms': [0, 0, 0], // likes, replies, bookmarks counting list
    'isLiked': false,
    'isBookmarked': false,
    'createdAt': DateTime(2021, 1, 13, 13, 13),
    'rate': 4.5,
    'description':
        "It's description of the Node, very long string. In summary it would be truncated.",
  };
}

Map<String, dynamic> getPostAPI(String id) {
  return {
    'id': id,
    'title': 'Title',
    'type': 'post',
    'ownerId': 'u009003',
    'bottoms': [0, 0, 0], // likes, replies, bookmarks counting list
    'isLiked': false,
    'isBookmarked': false,
    'createdAt': DateTime(2021, 1, 13, 13, 13),
    'description': '''
This is the content of this post. You can fill it
with the "MarkDown".

If you don't know the "MarkDown", please
visit this link!

`emphasis` is shown as emphasis
**bolder** is shown as bolder
~~tide~~ is shown as tide
<u>underline</u> is shown as underline

width of this area is 650px fixed.
height of this area is fit-content.
margin top 26px and bottom 74px.
''',
  };
}

Map<String, dynamic> getMessageAPI(String id) {
  return {
    'ownerId': '0321',
    'createdAt': DateTime.now(),
    'message':
        'this is a chat balloon, U can chat with your friends.\nGood luck!'
  };
}

List<String> getNoticeIdsAPI(String boardId) {
  // TODO: get post which is Notice (Post.ownerId == Board.ownerId && isNotice)
  return ['123', '456', '789'];
}

void updateLikeAPI(String postId) {}

void updateBookmarkAPI(String postId) {}

List<String> getReplyIdsAPI(String parentId) {
  return ['rp009008', 'rp0090023', 'rp00902148', 'rp009123'];
}

List<String> getReReplyIdsAPI(String replyId) {
  int num = int.parse(replyId[replyId.length - 1]) % 3;
  return Iterable<int>.generate(num)
      .map((i) => 'r' + replyId + i.toString())
      .toList();
}
