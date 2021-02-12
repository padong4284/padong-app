

class ModelNode {
  String id;
  String title;
  String description;
  String parentNodeId;
  DateTime  createdAt;
  DateTime deletedAt;
  DateTime modifiedAt;

  ModelNode({this.id, this.title, this.description, this.parentNodeId, this.createdAt, this.deletedAt, this.modifiedAt});

  ModelNode.fromMap(Map snapshot,String id) :
        this.id = id ?? '',
        this.title = snapshot['title'] ?? '',
        this.description = snapshot['description'] ?? '',
        this.parentNodeId = snapshot['parentNode'] ?? '',
        this.createdAt= DateTime.parse(snapshot['createdAt']) ?? null,
        this.deletedAt = DateTime.parse(snapshot['deletedAt']) ?? null,
        this.modifiedAt = DateTime.parse(snapshot['modifiedAt']) ?? null;

  toJson() {
    return {
      "id": this.id,
      "title": this.title,
      "description": this.description,
      "parentNode": this.parentNodeId,
      "createdAt": this.createdAt.toIso8601String(),
      "deletedAt": this.deletedAt.toIso8601String(),
      "modifiedAt": this.modifiedAt.toIso8601String(),
    };
  }

}