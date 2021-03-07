import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:padong/core/node/node.dart';
import 'package:padong/core/services/session.dart' as Session;

String getFBPath(Type nodeType) => nodeType.toString().toLowerCase();

class PadongFB {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  static Future<Node> getNode(dynamic nodeType, String id) async {
    return await _db
        .collection(getFBPath(nodeType))
        .doc(id)
        .get()
        .then((DocumentSnapshot doc) {
      if(!doc.exists){
          throw Exception("Node doesn't Exists");
      }

      Node node = nodeType.fromMap(id, doc.data());
      if (node.deletedAt != null)
        throw Exception('Request Deleted Node $id');
      else if (!node.isValidate()) throw Exception('Invalidate Node');
      return node;
    }).catchError((e) => null);
  }

  static Future<Node> createNode(dynamic nodeType, Map data) async {
    Node node = nodeType.fromMap('', {
      'ownerId': (await Session.currentUser)?.id,
      ...data, // position is important! (participant's ownerId)
      'createdAt': DateTime.now(),
    });
    if (node.isValidate())
      return await _db
          .collection(node.type)
          .add(node.toJson())
          .then((DocumentReference ref) {
        if (ref.id == null) return null;
        node.id = ref.id;
        return node;
      }).catchError((e) => null);
    return null;
  }

  static Future<Node> setNode(dynamic nodeType, Map data, String id) async {
    Node node = nodeType.fromMap('', {
      'id': id,
      'ownerId': (await Session.currentUser)?.id,
      ...data, // position is important! (participant's ownerId)
      'createdAt': DateTime.now(),
    });
    if (node.isValidate())
      return await _db
          .collection(node.type)
          .doc(id)
          .set(node.toJson())
          .then((_) => node)
          .catchError((e) => null);
    return null;
  }

  static Future<bool> deleteNode(Node node) async {
    if (node.isValidate())
      return await _db
          .collection(node.type)
          .doc(node.id)
          .update({'deletedAt': DateTime.now()})
          .then((_) => true)
          .catchError((e) => false);
    return false;
  }

  static Future<bool> updateNode(Node node) async {
    // assume modified (updated) node is passed
    node.modifiedAt = DateTime.now();
    if (node.isValidate())
      return await _db
          .collection(node.type)
          .doc(node.id)
          .update(node.toJson())
          .then((_) => true)
          .catchError((e) => false);
    return false;
  }

  static Future<List<Node>> getNodesByRule(dynamic nodeType,
      {Query Function(Query) rule, int limit, Node startAt}) async {
    List<Node> result = [];
    Query query = _db.collection(getFBPath(nodeType));

    if (rule != null) query = rule(query);
    if (limit != null && limit > 0) query = query.limit(limit);
    if (startAt != null) {
      DocumentSnapshot doc =
          await _db.collection(startAt.type).doc(startAt.id).get();
      if (doc != null && doc.exists) query = query.startAtDocument(doc);
    }

    return await query.get().then((QuerySnapshot queryResult) {
      for (DocumentSnapshot doc in queryResult.docs) {
        Node node = nodeType.fromMap(doc.id, doc.data());
        if (node.deletedAt == null) result.add(node);
      }
      return result;
    }).catchError((e) => null);
  }

  static Future<Stream<QuerySnapshot>> getQueryStreamByRule(dynamic nodeType,
      {Query Function(Query) rule, int limit = 30}) async {
    Query query = _db.collection(getFBPath(nodeType));
    if (rule != null) query = rule(query);
    if (limit != null && limit > 0) query = query.limit(limit);
    return query.snapshots();
  }
}
