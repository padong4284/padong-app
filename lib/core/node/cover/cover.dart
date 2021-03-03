import 'package:padong/core/node/deck/deck.dart';
import 'package:padong/core/node/cover/wiki.dart';

// parent: University
class Cover extends Deck {
  Cover.fromMap(String id, Map snapshot) : super.fromMap(id, snapshot);

  @override
  Map<String, Wiki> getFixedChildren() {
    // TODO: get fixed wiki!
    return {
      'Vision': null,
      'Mission': null,
      'History': null,
    };
  }
}
