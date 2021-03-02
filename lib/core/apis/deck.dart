import 'dart:math';
import 'package:padong/core/shared/types.dart';
import 'package:padong/core/apis/session.dart' as Session;

Random rand = Random();

Map<String, dynamic> getUnivAPI(String univId) {
  return {
    'id': 'univ009',
    'title': 'Georgia Tech',
    'deckId': 'deck009',
    'coverId': 'cover009',
    'description': 'Progress and Service',
    'emblem': 'https://en.wikipedia.org/wiki/File:Georgia_Tech_seal.svg',
  };
}

Map<String, dynamic> getDeckAPI(String deckId) {
  return {
    'id': 'deck009',
    'parentId': 'univ009',
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
    ],
  };
}

List<String> get10RecentPostIdsAPI(String boardId) {
  /* TODO
  1. Get Board Node
  2. get 10 recent postIds from Board's children
  3. return List<postIds>
  */
  return List.generate(10, (i) => boardId + i.toString());
}

const String RULE = """You must follow the rules below.
- Use the Markdown syntax.

- Some syntaxes may not be supported.

- Before finish the editing, check preview.

- Rules of this Board""";

Map<String, dynamic> getBoardAPI(String id) {
  // TODO: get board Node from Firebase
  if (id.startsWith('bu')) {
    int k = int.parse(id[id.length-1]);
    return {
      'id': id,
      'title': ['Written', 'Replied', 'Liked', 'Bookmarked'][k%4],
      'notification': true,
      'pip': PIP.PRIVATE,
      'rule': RULE,
      'description': '''
This board is GLOBAL board.
Everyone can read and write in this board.
'''
    };
  }
  else if (id.endsWith('0')) {
    return {
      'id': id,
      'title': 'Global',
      'notification': false,
      'pip': PIP.PUBLIC,
      'rule': RULE,
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
      'pip': PIP.INTERNAL,
      'rule': RULE,
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
      'pip': PIP.PRIVATE,
      'rule': RULE,
      'description': '''
This board is INTERNAL board.
ONLY Georgia Tech students can read and write.
'''
    };
  }
  return {
    'id': id,
    'title': 'Board Title',
    'pip': PIP.PRIVATE,
    'rule': RULE,
    'notification': rand.nextBool(),
    'description': 'sample board description'
  };
}

List<String> getPostIdsAPI(String boardId) {
  return List.generate(10, (i) => 'p0090043' + i.toString());
}

void setNotificationBoardAPI(String boardId, bool notification) {}

Map<String, dynamic> getUserAPI(String id) {
  return {
    'id': id,
    'username': 'kodw0402',
    'name': 'Daewoong Ko',
    'univId': 'univ009',
    'isVerified': true,
    'universityName': "Georgia Tech",
    'entranceYear': 2017,
    'email': 'kod0402@gatech.edu',
    'profileImgURL':
        'https://avatars.githubusercontent.com/u/36005723?s=460&u=49590ea0e7bb1936d515ed627867e8ca217b145b&v=4',
    'friends': List.generate(15, (i) => 'u009002' + i.toString()),
    'receives': List.generate(5, (i) => 'u009002' + i.toString()),
    'sends': List.generate(7, (i) => 'u009002' + i.toString()),
    'writtenIds': List.generate(12, (i) => 'p009002' + i.toString()),
    'myBoards': ['bu0090030', 'bu0090031', 'bu0090032', 'bu0090033'],
    'relationWith': (id) => rand.nextInt(4), // 0: friend, 1: received, 2: send, 3: none
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
    'createdAt': DateTime(2021, 2, 27, 13, 13),
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
    'createdAt': DateTime(2021, 2, 27, 14, 13),
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
  return List.generate(num, (i) => 'r' + replyId + i.toString());
}

void create(Map data) {
  data['ownerId'] = Session.user['id'];
  data['createdAt'] = DateTime.now();
  print(data);
}

void createBoardAPI(Map data) => create(data);

void createPostAPI(Map data) => create(data);

void createReplyAPI(Map data) => create(data);
