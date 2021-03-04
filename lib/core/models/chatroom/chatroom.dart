import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:padong/core/models/chatroom/chat_message.dart';
import 'package:padong/core/models/title_node.dart';
import 'package:padong/core/models/user/user.dart';
import 'package:padong/core/services/firebase_auth.dart';
import 'package:padong/core/services/firestore_api.dart';
import 'package:padong/locator.dart';


/*
* ModelChatRoom has no parent
* */
class ModelChatroom extends ModelTitleNode {
  ModelChatMessage recentChatMessage;

  ModelChatroom.fromMap(String id, Map snapshot) :
        recentChatMessage = ModelChatMessage.fromMap(snapshot['recentChatMessage'], snapshot['recentChatMessage']['id']),
        super.fromMap(id, snapshot);

  toJson() {
    return {
      ...super.toJson(),
      'recentChatMessage': this.recentChatMessage
    };
  }

}

class ChatroomAPI {
  final PadongAuth auth = locator<PadongAuth>();
  final FirestoreAPI _chatroomDB = locator<FirestoreAPI>('Firestore:chatroom');
  final FirestoreAPI _participantDB = locator<FirestoreAPI>('Firestore:participant');
  final FirestoreAPI _chatmessageDB = locator<FirestoreAPI>('Firestore:chatmessage');

  Future<ModelChatroom> getChatroomById(String chatroomId) async {
    var queryResult = await _chatroomDB.ref.where('id', isEqualTo: chatroomId ).get();

    if (queryResult.size == 0){
      return ModelChatroom.fromMap("",{});
    }
    return ModelChatroom.fromMap(queryResult.docs.first.id, queryResult.docs.first.data());
  }

  getChatRoomList() async {
    ModelUser user = await auth.currentSession;
    List<ModelChatroom> result;
    List<String> chatroomIds;

    QuerySnapshot queryResult = await _participantDB.ref.where('ownerId',isEqualTo: user.id).get();
    for(var i in queryResult.docs){
      chatroomIds.add(i.data()['parentNodeId']);
    }

    queryResult = await _chatroomDB.ref.where('id', whereIn: chatroomIds ).get();
    for(var i in queryResult.docs){
      result.add(ModelChatroom.fromMap(i.id, i.data()));
    }

    return result;
  }

  createChatroom(String chatroomName, String chatroomDescription, List<ModelUser> participants,[ String lectureId]) async {
    //FirebaseFirestore _firestore = FirebaseFirestore.instance;
    ModelUser user = await auth.currentSession;

    var chatroomRef = await _chatroomDB.addDocument({
        'type': "Chatroom",
        'title': chatroomName,
        'description': chatroomDescription,
        'parentNodeId': lectureId ?? "",
        'ownerId': user.id,
        'pip': "INTERNAL",
        'createdAt': DateTime.now().toIso8601String(),
        'modifiedAt': DateTime.now().toIso8601String()});

    _participantDB.addDocument({
      'type': "Participant",
      'parentNodeId': chatroomRef.id,
      'ownerId': user.id,
      'role': "Creator",
      'pip': "INTERNAL",
      'createdAt': DateTime.now().toIso8601String(),
      'modifiedAt': DateTime.now().toIso8601String()});

    for(var user in participants){
      _participantDB.addDocument({
        'type': "Participant",
        'parentNodeId': chatroomRef.id,
        'ownerId': user.id,
        'role': "STUDENT",
        'pip': "INTERNAL",
        'createdAt': DateTime.now().toIso8601String(),
        'modifiedAt': DateTime.now().toIso8601String()});
    }
  }

  Future<bool> addParticipant(String chatroomId, ModelUser user, [String role]) async {
    ModelChatroom chatroom = await getChatroomById(chatroomId);
    if (chatroom.id == ""){
      return false;
    }
    DocumentReference participant = await _participantDB.addDocument({
      'type': "Participant",
      'parentNodeId': chatroom.id,
      'ownerId': user.id,
      'role': role ?? "STUDENT",
      'pip': "INTERNAL",
      'createdAt': DateTime.now().toIso8601String(),
      'modifiedAt': DateTime.now().toIso8601String()});

    if (participant.id != ""){
      return true;
    } else {
      return false;
    }
  }

  Future<bool> Say(String chatroomId, ModelChatMessage message) async {
    ModelChatroom chatroom = await getChatroomById(chatroomId);
    if (chatroom.id == ""){
      return false;
    }
    message.parentNodeId = chatroomId;
    message.createdAt = DateTime.now();

    DocumentReference chatmessage = await _chatmessageDB.addDocument(message.toJson());

    if (chatmessage.id == ""){
      return false;
    } else {
      await _chatroomDB.updateDocument({'recentChatMessage': message}, chatroomId);
      return true;
    }
  }

  Future<List<ModelChatMessage>> getChatmessages(String chatroomId, [ModelChatMessage startAt, int limit=500]) async {
    ModelChatroom chatroom = await getChatroomById(chatroomId);
    if (chatroom.id == ""){
      throw Exception("There's no chatroom about chatroomid");
    }

    Query query = _chatmessageDB.ref.where("parentNodeId",isEqualTo: chatroomId).orderBy("createdAt",descending: true);
    if (startAt != null){
      var doc = await _chatmessageDB.getDocumentById(startAt.id);
      if (doc.exists){
        query = query.startAtDocument(doc);
      }
    }
    if (limit != null){
      query = query.limit(limit);
    }
    QuerySnapshot queryMessages = await query.get();
    List<ModelChatMessage> result;
    for(var i in queryMessages.docs){
      result.add(ModelChatMessage.fromMap(i.data(), i.id));
    }
    return result;
  }

  Future<Stream<QuerySnapshot>> getChatStream(String chatroomId) async {
    ModelChatroom chatroom = await getChatroomById(chatroomId);
    if (chatroom.id == ""){
      throw Exception("There's no chatroom about chatroomid");
    }
    return _chatroomDB.ref.where("parentNodeId", isEqualTo: chatroomId).orderBy("createdAt",descending: true).snapshots();
  }

}