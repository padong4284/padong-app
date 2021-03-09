import 'package:padong/core/node/common/like.dart';

// parent: Post
class Bookmark extends Like {
  Bookmark();

  Bookmark.fromMap(String id, Map snapshot) : super.fromMap(id, snapshot);

  @override
  generateFromMap(String id, Map snapshot) => Bookmark.fromMap(id, snapshot);
}
