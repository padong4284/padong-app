import 'package:padong/core/services/firebase_auth.dart';
import 'package:padong/core/services/padong_fb.dart';
import 'package:padong/core/node/chat/chat_room.dart';
import 'package:padong/core/node/chat/participant.dart';
import 'package:padong/locator.dart';
import 'package:padong/core/node/common/user.dart' as userNode;

getChatRoomList() async {
  final PadongAuth auth = locator<PadongAuth>(); // TODO: fix me
  userNode.User user = await auth.currentSession;
  List<String> chatRoomIds;
  List<Participant> myParticipants = await PadongFB.getNodesByRule(Participant,
      rule: (query) => query.where('ownerId', isEqualTo: user.id));
  for (Participant p in myParticipants) chatRoomIds.add(p.parentId);

  return await PadongFB.getNodesByRule(ChatRoom,
      rule: (query) => query.where('id', whereIn: chatRoomIds));
}
