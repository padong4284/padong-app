

class ModelBaseNode {
  String id;
  String parentNodeId;
  DateTime  createdAt;
  DateTime deletedAt;
  DateTime modifiedAt;

  ModelBaseNode({this.id, this.parentNodeId, this.createdAt, this.deletedAt, this.modifiedAt});

  ModelBaseNode.fromMap(Map snapshot,String id) :
        this.id = id ?? '',
        this.parentNodeId = snapshot['parentNode'] ?? '',
        this.createdAt= DateTime.parse(snapshot['createdAt']) ?? null,
        this.deletedAt = DateTime.parse(snapshot['deletedAt']) ?? null,
        this.modifiedAt = DateTime.parse(snapshot['modifiedAt']) ?? null;

  toJson() {
    return {
      "id": this.id,
      "parentNode": this.parentNodeId,
      "createdAt": this.createdAt.toIso8601String(),
      "deletedAt": this.deletedAt.toIso8601String(),
      "modifiedAt": this.modifiedAt.toIso8601String(),
    };
  }

}