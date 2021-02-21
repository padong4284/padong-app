import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:padong/core/models/event/event.dart';
import 'package:padong/core/services/firestore_api.dart';

import 'package:padong/locator.dart';


/*
* ModelEvent's parentNodeId is ModelTable
* */

class Event extends ModelEvent {
  static final FirestoreAPI _eventDB = locator<FirestoreAPI>("Firestore:event");

  Event({
    id,
    title, description,
    timeCategory,
    times,
    parentNodeId, ownerId, pip,
    createdAt, deletedAt, modifiedAt}):
        super(id: id,
          title:title, description: description,
          times: times, timeCategory: timeCategory,
          parentNodeId: parentNodeId, ownerId: ownerId, pip: pip,
          createdAt: createdAt, deletedAt: deletedAt, modifiedAt: modifiedAt);

  Event.fromMap(Map snapshot,String id) :
        super.fromMap(snapshot, id);

  static Future<Event> getEventById(String id) async {
    DocumentSnapshot docEvent = await _eventDB.ref.doc(id).get();
    if (docEvent.exists){
      return Event.fromMap(docEvent.data(), docEvent.id);
    }
    throw Exception("EventId doesn't exists");
  }

}

