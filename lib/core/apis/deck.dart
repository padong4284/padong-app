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

void setNotificationBoardAPI(String boardId, bool notification) {}
