import 'package:flutter/material.dart';

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

const SERVICE_CODES = [1, 2, 4, 8, 16];
const SERVICES = ['Library', 'Restaurant', 'Parking', 'Medical', 'Custom'];

class SERVICE {
  static int LIBRARY = 1;
  static int RESTAURANT = 2;
  static int PARKING = 4;
  static int MEDICAL = 8;
  static int CUSTOM = 16;
  final int code;

  SERVICE(this.code);
}

const List<IconData> SERVICE_ICONS = [
  Icons.local_library_rounded,
  Icons.restaurant_rounded,
  Icons.local_parking_rounded,
  Icons.medical_services_rounded,
  Icons.place_rounded,
];

IconData serviceToIcon(SERVICE service) => {
      SERVICE.LIBRARY: SERVICE_ICONS[0],
      SERVICE.RESTAURANT: SERVICE_ICONS[1],
      SERVICE.PARKING: SERVICE_ICONS[2],
      SERVICE.MEDICAL: SERVICE_ICONS[3],
      SERVICE.CUSTOM: SERVICE_ICONS[4],
    }[service.code];

SERVICE parseSERVICE(String service) => SERVICE({
      'Library': SERVICE.LIBRARY,
      'Restaurant': SERVICE.RESTAURANT,
      'Parking': SERVICE.PARKING,
      'Medical': SERVICE.MEDICAL,
      'Custom': SERVICE.CUSTOM,
    }[service]);

String serviceToString(SERVICE service) => {
      SERVICE.LIBRARY: 'Library',
      SERVICE.RESTAURANT: 'Restaurant',
      SERVICE.PARKING: 'Parking',
      SERVICE.MEDICAL: 'Medical',
      SERVICE.CUSTOM: 'Custom',
    }[service.code];

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
