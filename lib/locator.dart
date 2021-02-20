
import 'package:get_it/get_it.dart';
import 'package:padong/core/services/firebase_auth.dart';

import 'core/services/firestore_api.dart';

GetIt locator = GetIt();

void setupLocator() {
  locator.registerLazySingleton(() => PadongAuth());
  locator.registerLazySingleton(() => FirestoreAPI('deck'), "Firestore:deck");
}