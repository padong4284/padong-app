import 'package:flutter/cupertino.dart';
import 'package:padong/core/models/deck/board.dart';
import 'package:padong/core/models/deck/deck.dart';
import 'package:padong/core/services/firestore_api.dart';
import 'file:///D:/Onedrive/OneDrive%20-%20CNU/Project/padong-flutter/lib/core/viewmodels/deck/board.dart';

import 'package:padong/locator.dart';

class Deck extends ChangeNotifier {
  ModelDeck deck;
  FirestoreAPI _api = locator<FirestoreAPI>("Firestore:deck");

  List<Board> products;


  Future<List<Board>> fetchBoards() async {
    var result = await _api.getDataCollection();
    products = result.documents
        .map((doc) => (Board.fromMap(doc.data, doc.documentID) ))
        .toList();
    return products;
  }

  Stream<QuerySnapshot> fetchProductsAsStream() {
    return _api.streamDataCollection();
  }

  Future<Product> getProductById(String id) async {
    var doc = await _api.getDocumentById(id);
    return  Product.fromMap(doc.data, doc.documentID) ;
  }


  Future removeProduct(String id) async{
    await _api.removeDocument(id) ;
    return ;
  }
  Future updateProduct(Product data,String id) async{
    await _api.updateDocument(data.toJson(), id) ;
    return ;
  }

  Future addProduct(Product data) async{
    var result  = await _api.addDocument(data.toJson()) ;

    return ;

  }


}