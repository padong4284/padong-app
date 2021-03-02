import 'package:padong/core/node/node.dart';

// parent: University
class Deck extends Node {
  Deck.fromMap(String id, Map snapshot) : super.fromMap(id, snapshot);

  toJson() {
    return super.toJson();
  }

  Map<String, Node> getFixedBoards() {
    // TODO: get fixed boards!
    //  exclude this boards from getChildren
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
