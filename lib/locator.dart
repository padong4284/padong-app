
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

  locator.registerLazySingleton(() => FirestoreAPI('cover'), "Firestore:cover");
  locator.registerLazySingleton(() => FirestoreAPI('wiki'), "Firestore:wiki");
  locator.registerLazySingleton(() => FirestoreAPI('item'), "Firestore:item");
  locator.registerLazySingleton(() => FirestoreAPI('argue'), "Firestore:argue");

  locator.registerLazySingleton(() => FirestoreAPI('map'), "Firestore:map");
  locator.registerLazySingleton(() => FirestoreAPI('building'), "Firestore:building");
  locator.registerLazySingleton(() => FirestoreAPI('service'), "Firestore:service");
  locator.registerLazySingleton(() => FirestoreAPI('tip'), "Firestore:tip");

  locator.registerLazySingleton(() => FirestoreAPI('table'), "Firestore:table");
  locator.registerLazySingleton(() => FirestoreAPI('event'), "Firestore:event");
  locator.registerLazySingleton(() => FirestoreAPI('memo'), "Firestore:memo");
  locator.registerLazySingleton(() => FirestoreAPI('lecture'), "Firestore:lecture");
  locator.registerLazySingleton(() => FirestoreAPI('review'), "Firestore:review");
  locator.registerLazySingleton(() => FirestoreAPI('qna'), "Firestore:qna");
  locator.registerLazySingleton(() => FirestoreAPI('opinion'), "Firestore:opinion");

}