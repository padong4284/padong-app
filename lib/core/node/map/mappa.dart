import 'package:padong/core/node/node.dart';

// parent: University
class Mappa extends Node {
  Mappa();

  Mappa.fromMap(String id, Map snapshot) : super.fromMap(id, snapshot);

  @override
  generateFromMap(String id, Map snapshot) => Mappa.fromMap(id, snapshot);
}
