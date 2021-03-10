import 'package:padong/core/node/common/like.dart';

// parent: Board, ChatRoom
class Subscribe extends Like {
  Subscribe();

  Subscribe.fromMap(String id, Map snapshot) : super.fromMap(id, snapshot);

  @override
  generateFromMap(String id, Map snapshot) => Subscribe.fromMap(id, snapshot);
}
