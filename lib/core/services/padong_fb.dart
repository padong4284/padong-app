import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:padong/core/node/node.dart';

String getFBPath(Type nodeType) => nodeType.toString().toLowerCase();

class PadongFB {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  static Future<Node> getNode(dynamic nodeType, String id) async {
    return await _db
        .collection(getFBPath(nodeType))
        .doc(id)
        .get()
        .then((DocumentSnapshot doc) {
      Node node = nodeType.fromMap(id, doc.data());
      if (node.deletedAt != null) throw Exception('Request Deleted Node $id');
      return node;
    }).catchError((e) => null);
  }

  static Future<bool> createNode(dynamic nodeType, Map data) async {
    Node node = nodeType.fromMap('', {
      ...data,
      //'ownerId': Session.user.id, TODO: Session user
      'createdAt': DateTime.now(),
    });
    if (node.isValidate())
      return await _db
          .collection(node.type)
          .add(node.toJson())
          .then((DocumentReference ref) => ref.id != null)
          .catchError((e) => false);
    return false;
  }

  static Future<bool> deleteNode(Node node) async {
    return await _db
        .collection(node.type)
        .doc(node.id)
        .update({'deletedAt': DateTime.now()})
        .then((_) => true)
        .catchError((e) => false);
  }

  static Future<bool> updateNode(Node node) async {
    // assume modified (updated) node is passed
    node.modifiedAt = DateTime.now();
    return await _db
        .collection(node.type)
        .doc(node.id)
        .update(node.toJson())
        .then((_) => true)
        .catchError((e) => false);
  }

  static Future<List<Node>> getNodesByRule(
      dynamic nodeType, Function(CollectionReference collection) rule,
      {int howMany}) async {
    List<Node> result = [];
    return await rule(_db.collection(getFBPath(nodeType)))
        .get()
        .then((QuerySnapshot queryResult) {
      for (DocumentSnapshot doc in queryResult.docs) {
        if (howMany != null && result.length == howMany) break;
        Node node = nodeType.fromMap(doc.id, doc.data());
        if (node.deletedAt == null) result.add(node);
      }
      return result;
    }).catchError((e) => null);
  }
}
