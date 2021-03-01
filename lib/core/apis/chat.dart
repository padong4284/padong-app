import 'dart:math';
import 'package:padong/core/models/pip.dart';
import 'package:padong/core/apis/session.dart' as Session;

Random rand = Random();

List<String> getChatRoomIdsAPI() {
  /// From Session.user['id']
  return List.generate(10, (i) => "c0090" + i.toString());
}

Map<String, dynamic> getChatRoomAPI(String chatRoomId) {
  return {};
}

List<String> getFriendIdsAPI() {
  return List.generate(10, (i) => "u0090" + i.toString());
}
