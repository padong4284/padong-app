
import 'package:get_it/get_it.dart';

import 'core/services/firestore_api.dart';

GetIt locator = GetIt();

void setupLocator() {
  locator.registerLazySingleton(() => FirestoreAPI('deck'), "Firestore:deck");
  locator.registerLazySingleton(() => FirestoreAPI('user'), "Firestore:user");
  locator.registerLazySingleton(() => FirestoreAPI('post'), "Firestore:post");
}