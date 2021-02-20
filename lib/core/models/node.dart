

import 'package:meta/meta.dart';
import 'package:padong/core/models/pip.dart';

class ModelNode {
  String id;
  String parentNodeId;
  String ownerId;
  PIP pip;
  DateTime createdAt;
  DateTime deletedAt;
  DateTime modifiedAt;

  ModelNode({
  @required this.id,
  @required this.parentNodeId, @required this.ownerId, @required this.pip,
    @required this.createdAt, @required this.deletedAt, @required this.modifiedAt});

  ModelNode.fromMap(Map snapshot,String id) :
        this.id = id ?? '',
        this.parentNodeId = snapshot['parentNodeId'] ?? '',
        this.ownerId = snapshot['ownerId'] ?? '',
        this.pip = snapshot['pip'] ?? PIP.INTERNAL,
        this.createdAt= DateTime.parse(snapshot['createdAt']) ?? null,
        this.deletedAt = DateTime.parse(snapshot['deletedAt']) ?? null,
        this.modifiedAt = DateTime.parse(snapshot['modifiedAt']) ?? null;

  toJson() {
    return {
      "id": this.id,
      "parentNode": this.parentNodeId,
      "ownerId": this.ownerId,
      "pip": this.pip,
      "createdAt": this.createdAt.toIso8601String(),
      "deletedAt": this.deletedAt.toIso8601String(),
      "modifiedAt": this.modifiedAt.toIso8601String(),
    };
  }

}