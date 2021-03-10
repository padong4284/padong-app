import 'package:padong/core/node/cover/wiki.dart';
import 'package:padong/core/node/node.dart';

// parent: University
class Cover extends Node {
  Cover();

  Cover.fromMap(String id, Map snapshot) : super.fromMap(id, snapshot);

  @override
  generateFromMap(String id, Map snapshot) => Cover.fromMap(id, snapshot);

  Map<String, Wiki> getFixedWikis() {
    // TODO: get fixed wiki!, which is parentId == university
    // TODO: move it to University
    return {
      'Vision': null,
      'Mission': null,
      'History': null,
    };
  }
}
