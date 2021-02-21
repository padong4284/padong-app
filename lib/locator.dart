
import 'package:get_it/get_it.dart';
import 'package:padong/core/services/firebase_auth.dart';

import 'core/services/firestore_api.dart';

GetIt locator = GetIt();

void setupLocator() {
  locator.registerLazySingleton(() => PadongAuth());
  locator.registerLazySingleton(() => FirestoreAPI('user'), "Firestore:user");
  locator.registerLazySingleton(() => FirestoreAPI('deck'), "Firestore:deck");
  locator.registerLazySingleton(() => FirestoreAPI('board'), "Firestore:board");
  locator.registerLazySingleton(() => FirestoreAPI('post'), "Firestore:post");
  locator.registerLazySingleton(() => FirestoreAPI('reply'), "Firestore:reply");
  locator.registerLazySingleton(() => FirestoreAPI('rereply'), "Firestore:rereply");
  locator.registerLazySingleton(() => FirestoreAPI('like'), "Firestore:like");
  locator.registerLazySingleton(() => FirestoreAPI('attachment'), "Firestore:attachment");

}