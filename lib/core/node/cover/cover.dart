import 'package:padong/core/node/cover/wiki.dart';
import 'package:padong/core/node/node.dart';

// parent: University
class Cover extends Node {
  Cover.fromMap(String id, Map snapshot) : super.fromMap(id, snapshot);

  Map<String, Wiki> getFixedWikis() {
    // TODO: get fixed wiki!
    return {
      'Vision': null,
      'Mission': null,
      'History': null,
    };
  }
}
