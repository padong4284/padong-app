import 'package:padong/core/apis/session.dart' as Session;

void updateRelationAPI(String userId, int relation) {
  // relation 0: friend, 1: received, 2: send, 3: none
}

void signOutAPI() {
  // Session refresh
}

void updateProfileAPI(Map<String, dynamic> data) {
  Session.user = {
    ...Session.user,
    ...data
  };
  print(Session.user);
}

void updatePasswordAPI(String password) {}