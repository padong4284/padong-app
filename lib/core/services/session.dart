import 'package:padong/core/node/common/university.dart';
import 'package:padong/core/services/padong_auth.dart';
import 'package:padong/core/services/padong_fb.dart';
import 'package:padong/core/node/chat/chat_room.dart';
import 'package:padong/core/node/chat/participant.dart';
import 'package:padong/core/node/common/user.dart';

Future<User> get currentUser async => await PadongAuth.currentUser;

getChatRoomList() async {
  User user = await currentUser;
  if(user == null) return null;
  List<String> chatRoomIds;
  List<Participant> myParticipants = await PadongFB.getNodesByRule(Participant,
      rule: (query) => query.where('ownerId', isEqualTo: user.id));
  for (Participant p in myParticipants) chatRoomIds.add(p.parentId);

  return await PadongFB.getNodesByRule(ChatRoom,
      rule: (query) => query.where('id', whereIn: chatRoomIds));
}

Future<String> get currentUnivId async => (await currentUser)?.parentId;

Future<University> get currentUniv async => await (currentUnivId != null
    ? PadongFB.getNode(University, await currentUnivId)
    : null); // TODO: Padong University
