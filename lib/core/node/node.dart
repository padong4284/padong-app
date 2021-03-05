import 'package:padong/core/shared/types.dart';
import 'package:padong/core/services/padong_fb.dart';

class Node {
  String id;
  PIP pip;
  String parentId;
  String ownerId; // Node User's id
  DateTime createdAt;
  DateTime modifiedAt;
  DateTime deletedAt;

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

  Future<Node> getParent(Type parentType) async {
    return await PadongFB.getNode(parentType, this.parentId);
  }

  Future<List<Node>> getChildren(Type childType,
      {int limit, Node startAt}) async {
    return await PadongFB.getNodesByRule(childType,
        rule: (query) => query
            .where(this.id, isEqualTo: 'parentId')
            .orderBy("createdAt", descending: true),
        limit: limit,
        startAt: startAt);
  }

  Future<bool> update() async {
    // assume this node is already modified (updated)
    // just update Fire Store data
    return await PadongFB.updateNode(this);
  }

  Future<bool> delete() async {
    // set deletedAt now, PadongFB.getNode never return this anymore;
    return await PadongFB.deleteNode(this); // success or not
  }
}
