import 'package:meta/meta.dart';
import 'package:padong/core/models/chatroom/participant.dart';

import '../title_node.dart';


/*
* ModelChatRoom has no parent
* */
class ModelChatroom extends ModelTitleNode {
  List<Participant> participants;
  
  ModelChatroom({
    id,
    title, description, 
    parentNodeId, ownerId,
    @required this.participants,
    pip, createdAt, deletedAt,
    modifiedAt}):
        super(id: id,
          title:title, description: description,
          parentNodeId: parentNodeId, ownerId: ownerId, pip: pip,
          createdAt: createdAt, deletedAt: deletedAt, modifiedAt: modifiedAt);

  ModelChatroom.fromMap(Map snapshot,String id) :
      this.participants = snapshot['participants'].map((e) => (Participant.fromMap(e, id))), 
        super.fromMap(snapshot, id);

  toJson() {
    return {
      ...super.toJson(),
      'participants': this.participants.map((e) => e.toJson())
    };
  }

}
