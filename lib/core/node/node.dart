import 'package:meta/meta.dart';
import 'package:padong/core/shared/types.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseFirestore fireDB = FirebaseFirestore.instance;

class Node {
  String id;
  PIP pip;
  String parentId;
  String ownerId; // Node User's id
  DateTime createdAt;
  DateTime deletedAt;
  DateTime modifiedAt;

  String get type => this.toString().split("'")[1].toLowerCase();

  Node.fromMap(String id, Map snapshot)
      : this.id = id,
        this.pip = parsePIP(snapshot['pip']),
        this.parentId = snapshot['parentId'],
        this.ownerId = snapshot['ownerId'],
        this.createdAt = DateTime.parse(snapshot['createdAt']),
        this.modifiedAt = // not modified yet
            DateTime.parse(snapshot['modifiedAt'] ?? snapshot['createdAt']),
        this.deletedAt = snapshot['deletedAt'] == null
            ? null // It may not deleted
            : DateTime.parse(snapshot['deletedAt']);

  Map<String, dynamic> toJson() {
    return {
      "id": this.id,
      "pip": pipToString(this.pip),
      "type": this.type,
      "parentId": this.parentId,
      "ownerId": this.ownerId,
      "createdAt": this.createdAt.toIso8601String(),
      "modifiedAt": (this.modifiedAt ?? this.createdAt).toIso8601String(),
      "deletedAt": this.deletedAt == null
          ? null // It may not deleted
          : this.deletedAt.toIso8601String(),
    };
  }

  bool isValidate() {
    Map<String, dynamic> data = this.toJson();
    for (String key in data.keys) {
      if (key == 'deletedAt') continue;
      if (data[key] == null) return false;
    } // check all fields are not null except deletedAt
    return true;
  }

  // APIs
  bool create() {
    if (!this.isValidate()) throw Exception('invalid data Node call create');
    //create the Fire Store data
    return true; // success or not
  }

  Future<Node> getById(String id, {Type nodeType}) async {
    // TODO: test this method
    /// Usage:
    /// - Deck myDeck = Deck().getById('092897');
    /// - Post myPost = Node().getById('004885', Post);
    dynamic nodeClass = nodeType ?? this.runtimeType;
    String path = nodeType != null
        ? nodeType.toString().split("'")[1].toLowerCase()
        : this.type;
    DocumentSnapshot doc = await fireDB.collection(path).doc(id).get();
    if (doc.exists) return nodeClass.fromMap(id, doc.data());
    throw Exception("${this.type.toUpperCase()} $id DOES NOT EXISTS");
  }

  Future<Node> getParent() async {
    return await this.getById(this.parentId);
  }

  List getChildren({@required String type, int howMany}) {
    // TODO: filter with type
    // List of What ?? snapshot or Node
    return [];
  }

  bool update(Map data) {
    // update Fire Store data
    return true; // success or not
  }

  bool delete() {
    // set deleteAt and call update()
    this.deletedAt = DateTime.now();
    return true; // success or not
  }
}
