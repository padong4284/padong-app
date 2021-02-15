import 'package:flutter/cupertino.dart';
import 'package:padong/core/models/deck/board.dart';
import 'package:padong/core/models/deck/post.dart';
import 'package:padong/core/services/firestore_api.dart';
import 'package:padong/locator.dart';


class Board extends  ChangeNotifier{
  FirestoreAPI _api = locator<FirestoreAPI>();
  ModelBoard board;
  Board.fromMap(Map snapshot, String id):
    this.board = ModelBoard.fromMap(snapshot, id);
  set setModel()

  getPost
}