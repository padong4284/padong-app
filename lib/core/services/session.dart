import 'package:padong/core/node/common/university.dart';
import 'package:padong/core/services/padong_auth.dart';
import 'package:padong/core/services/padong_fb.dart';
import 'package:padong/core/node/common/user.dart';

Future<User> get currentUser async => await PadongAuth.currentUser;

Future<String> get currentUnivId async => (await currentUser)?.parentId;

Future<University> get currentUniv async => await (currentUnivId != null
    ? PadongFB.getNode(University, await currentUnivId)
    : null); // TODO: Padong University
