import 'package:meta/meta.dart';
import 'package:padong/core/shared/types.dart';

class Node {
  String id;
  PIP pip;
  String type;
  String parentId;
  String ownerId;
  DateTime createdAt;
  DateTime deletedAt;
  DateTime modifiedAt;

  Node.fromMap(String id, Map snapshot)
      : this.id = id,
        this.pip = snapshot['pip'],
        this.type = snapshot['type'],
        this.parentId = snapshot['parentId'],
        this.ownerId = snapshot['ownerId'],
        this.createdAt = DateTime.parse(snapshot['createdAt']),
        this.modifiedAt = DateTime.parse(snapshot['modifiedAt']),
        this.deletedAt = snapshot['deletedAt'] == null
            ? null // It may not deleted
            : DateTime.parse(snapshot['deletedAt']);

  Map<String, dynamic> toJson() {
    return {
      "id": this.id,
      "pip": this.pip,
      "type": this.type,
      "parentId": this.parentId,
      "ownerId": this.ownerId,
      "createdAt": this.createdAt.toIso8601String(),
      "modifiedAt": this.modifiedAt.toIso8601String(),
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
  void create() {
    if (!this.isValidate()) throw Exception('invalid data Node call create');
    //create the Fire Store data
  }

  Node getById(String id, Type nodeClass) {
    // TODO: get Node by id (any class)
    // nodeClass.fromMap(id, getSnapshot(id))
    return this;
  }

  Node getParent() {
    return this;
  }

  List<Node> getChildren({@required String type, int howMany}) {
    // TODO: filter with type
    return [];
  }

  void update(Map data) {
    // update Fire Store data
  }

  void delete() {
    // set deleteAt and call update()
    this.deletedAt = DateTime.now();
  }
}
