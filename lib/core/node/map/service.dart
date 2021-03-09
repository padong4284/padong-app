import 'package:padong/core/node/schedule/evaluation.dart';
import 'package:padong/core/shared/types.dart';

// parent: Building
class Service extends Evaluation {
  SERVICE serviceCode;

  Service.fromMap(String id, Map snapshot)
      : this.serviceCode = parseSERVICE(snapshot['serviceCode']),
        super.fromMap(id, {...snapshot, 'anonymity': false});

  @override
  Map<String, dynamic> toJson() {
    return {
      ...super.toJson(),
      'serviceCode': serviceToString(this.serviceCode),
    };
  }

// TODO: when CRUD Service, update building's serviceCheckBit
// One building can serve same type of services, not only one.
}
