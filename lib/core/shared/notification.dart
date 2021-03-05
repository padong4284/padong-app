import 'package:padong/core/node/common/subscribe.dart';
import 'package:padong/core/node/common/user.dart';
import 'package:padong/core/node/node.dart';

mixin Notification on Node {
  bool isSubscribed(User me) {
    // TODO: get user's Alert setting
    return false;
  }

  void updateSubscribe(User me, bool isSubscribed) {
    // TODO: update user's Subscribe setting
    Subscribe.fromMap('', {});
  }
}