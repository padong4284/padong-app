const List<String> PIPs = ['Public', 'Internal', 'Private'];

enum PIP {
  PUBLIC,
  INTERNAL,
  PRIVATE,
}

PIP parsePIP(String pip) => {
      'Public': PIP.PUBLIC,
      'Internal': PIP.INTERNAL,
      'Private': PIP.PRIVATE,
    }[pip];

String pipToString(PIP pip) => {
      PIP.PUBLIC: 'Public',
      PIP.INTERNAL: 'Internal',
      PIP.PRIVATE: 'Private',
    }[pip];

enum RELATION {
  FRIEND,
  RECEIVED,
  SEND,
}

RELATION parseRELATION(String relation) => {
      'Friend': RELATION.FRIEND,
      'Received': RELATION.RECEIVED,
      'Send': RELATION.SEND,
    }[relation];

String relationToString(RELATION relation) => {
      RELATION.FRIEND: 'Public',
      RELATION.RECEIVED: 'Internal',
      RELATION.SEND: 'Private'
    }[relation];

enum PERIODICITY {
  ANNUALLY,
  MONTHLY,
  WEEKLY,
}

PERIODICITY parsePERIODICITY(String periodicity) => {
      'Friend': PERIODICITY.ANNUALLY,
      'Received': PERIODICITY.MONTHLY,
      'Send': PERIODICITY.WEEKLY,
    }[periodicity];

String periodicityToString(PERIODICITY periodicity) => {
      PERIODICITY.ANNUALLY: 'Public',
      PERIODICITY.MONTHLY: 'Internal',
      PERIODICITY.WEEKLY: 'Private',
    }[periodicity];

enum SERVICE {
  LIBRARY,
  RESTAURANT,
  PARKING,
  MEDICAL,
  CUSTOM,
}

SERVICE parseSERVICE(String service) => {
      'Library': SERVICE.LIBRARY,
      'Restaurant': SERVICE.RESTAURANT,
      'Parking': SERVICE.PARKING,
      'Medical': SERVICE.MEDICAL,
      'Custom': SERVICE.CUSTOM,
    }[service];

String serviceToString(SERVICE service) => {
      SERVICE.LIBRARY: 'Library',
      SERVICE.RESTAURANT: 'Restaurant',
      SERVICE.PARKING: 'Parking',
      SERVICE.MEDICAL: 'Medical',
      SERVICE.CUSTOM: 'Custom',
    }[service];

enum ROLE {
  PROFESSOR,
  TA,
  STUDENT,
}

ROLE parseROLE(String role) => {
      'Professor': ROLE.PROFESSOR,
      'TA': ROLE.TA,
      'Student': ROLE.STUDENT,
    }[role];

String roleToString(ROLE role) => {
      ROLE.PROFESSOR: 'Professor',
      ROLE.TA: 'TA',
      ROLE.STUDENT: 'Student',
    }[role];

enum RegistrationReturns {
  success,
  failed,
  weak_password,
  emailAlreadyInUse,
  IdAlreadyInUse,
  UniversityNotFound,
}

enum SignInReturns { success, failed, wrongEmailOrPassword }
