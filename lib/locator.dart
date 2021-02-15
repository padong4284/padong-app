
import 'package:get_it/get_it.dart';

import 'core/services/firestore_api.dart';
import 'core/viewmodels/deck/deck.dart';

GetIt locator = GetIt();

void setupLocator() {
  locator.registerLazySingleton(() => FirestoreAPI('deck'), "Firestore:deck");
  locator.registerLazySingleton(() => Deck()) ;
  locator.registerLazySingleton(() => FirestoreAPI('board'), "Firestore:board");
  locator.registerLazySingleton(() => FirestoreAPI('post'), "Firestore:post");
  locator.registerLazySingleton(() => FirestoreAPI('reply'), "Firestore:reply");
  locator.registerLazySingleton(() => FirestoreAPI('rereply'), "Firestore:rereply");


}