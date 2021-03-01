import 'dart:math';
import 'package:padong/core/models/pip.dart';
import 'package:padong/core/apis/session.dart' as Session;

Random rand = Random();

List<String> getChatRoomIdsAPI() {
  /// From Session.user['id']
  /// CAUTION! not by parentId or ownerId!
  /// by Participants or user saving chatRoomIds
  return List.generate(10, (i) => "c0090" + i.toString());
}

Map<String, dynamic> getChatRoomAPI(String chatRoomId) {
  return {
    'title': 'ChatRoom',
    'ownerId': 'u009003',
    'parentId': 'u009003', // it can be different when owner get out
    'description': 'thi is the chat room!',
    'createdAt': DateTime.now(),
    'pip': PIP.PRIVATE,
    'unreads' : 1,
    'participants': ['u0090013', 'u009003'],
    'messages': [
      // sorted by createdAt recent -> old
      {
        'ownerId': 'u0090013',
        'username': 'tae7130',
        'message': 'This message from other',
        'createdAt': DateTime(2021, 3, 1, 14, 58)
      },
      {
        'ownerId': 'u009003',
        'username': 'kodw0402',
        'message': 'middle length message, testing!',
        'createdAt': DateTime(2021, 3, 1, 14, 55)
      },
      {
        'ownerId': 'u009003',
        'username': 'kodw0402',
        'message': 'I send this message',
        'createdAt': DateTime(2021, 3, 1, 14, 54)
      },
      {
        'ownerId': 'u0090013',
        'username': 'tae7130',
        'message': 'This message from other',
        'createdAt': DateTime(2021, 3, 1, 14, 52)
      },
      {
        'ownerId': 'u0090013',
        'username': 'tae7130',
        'message':
            'This message is long message! very long long more more more!!',
        'createdAt': DateTime(2021, 3, 1, 14, 51)
      },
      {
        'ownerId': 'u0090013',
        'username': 'tae7130',
        'message': 'very short',
        'createdAt': DateTime(2021, 3, 1, 14, 51)
      }
    ],
  };
}

List<String> getFriendIdsAPI() {
  return List.generate(10, (i) => "u0090" + i.toString());
}

void creatChatRoomAPI(data) {
  data['ownerId'] = Session.user['id'];
  data['createdAt'] = DateTime.now();
  print(data);
}

void updateChatRoomAPI(String chatRoomId) {
  // TODO: set unreads = 0
}
