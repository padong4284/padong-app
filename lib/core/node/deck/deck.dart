import 'package:padong/core/node/node.dart';

// parent: University
class Deck extends Node {
  Deck.fromMap(String id, Map snapshot) : super.fromMap(id, snapshot);

  Map<String, Node> getFixedChildren() {
    // TODO: get fixed boards!
    // exclude this boards from getChildren
    return {
      'Global': null,
      'Public': null,
      'Internal': null,
      'Popular': null,
      'Favorite': null,
      'Inform': null,
    };
  }
}
