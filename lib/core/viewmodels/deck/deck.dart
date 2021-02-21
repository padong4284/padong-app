import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:padong/core/models/deck/deck.dart';
import 'package:padong/core/services/firestore_api.dart';

import 'package:padong/locator.dart';


/*
* ModelDeck's parentNodeId is ModelUniversity
* */
class Deck extends ModelDeck {
  static final FirestoreAPI _deckDB = locator<FirestoreAPI>("Firestore:deck");

  Deck({id, parentNodeId, ownerId, pip, createdAt, deletedAt,
    modifiedAt}):
        super(id: id,
          parentNodeId: parentNodeId, ownerId: ownerId, pip: pip,
          createdAt: createdAt, deletedAt: deletedAt, modifiedAt: modifiedAt);

  Deck.fromMap(Map snapshot,String id) :
        super.fromMap(snapshot, id);

  static Future<Deck> getDeckById(String id) async {
    DocumentSnapshot docDeck = await _deckDB.ref.doc(id).get();
    if (docDeck.exists){
      return Deck.fromMap(docDeck.data(), docDeck.id);
    }
    throw Exception("PostId doesn't exists");
  }

}

