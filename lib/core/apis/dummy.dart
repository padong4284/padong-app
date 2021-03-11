import 'package:padong/core/shared/types.dart';

String _now = DateTime.now().toIso8601String();

Map<String, dynamic> _node = {
  "id": 'ID_OF_NODE_0000',
  "pip": pipToString(PIP.PUBLIC),
  "parentId": 'ID_OF_PARENT_0000',
  "ownerId": 'ID_OF_USER_0001',
  "createdAt": _now,
  "modifiedAt": _now,
  "deletedAt": null,
};

Map<String, dynamic> _titleNode = {
  ..._node,
  'title': 'Title',
  'description': 'This is a *description*, I love PADONG!'
};

Map<String, dynamic> _deck = {
  ..._node,
};

Map<String, dynamic> _board = {
  ..._titleNode,
  'rule': 'When user write the post at this board, must follow this rule!',
};

Map<String, dynamic> _post = {
  ..._titleNode,
  'anonymity': false,
  'isNotice': false,
};