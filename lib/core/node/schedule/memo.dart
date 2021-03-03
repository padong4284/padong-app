import 'package:padong/core/shared/types.dart';
import 'package:padong/core/node/deck/post.dart';

// parent: Event
class Memo extends Post {
  @override
  PIP pip = PIP.INTERNAL;

  Memo.fromMap(String id, Map snapshot)
      : super.fromMap(id, {...snapshot, 'pip': PIP.INTERNAL});

  @override
  Map<String, dynamic> toJson() {
    return {
      ...super.toJson(),
      'pip': PIP.INTERNAL,
    };
  }
}
