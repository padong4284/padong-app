import 'dart:math';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:padong/core/node/map/building.dart';
import 'package:padong/core/node/map/mappa.dart';
import 'package:padong/core/shared/types.dart';

Random rand = Random();

double gtLat = 33.775792835163144;
double gtLng = -84.3962589592725;
LatLng univLocation = LatLng(33.775792835163144, -84.3962589592725);

Building getCenterAPI(String univId) {
  Building georgiaTech = new Building.fromMap('id', {
    'id': 'building009',
    'title': 'Georgia Tech',
    'description': 'progress and service with super power',
    'location': univLocation.toJson(),
    'createdAt': DateTime.now().toIso8601String()
  });
  return georgiaTech;
}

Mappa getMappaAPI(String id) {
  return Mappa.fromMap(id, {
    'pip': pipToString(PIP.PUBLIC),
    'createdAt': DateTime.now().toIso8601String()
  });
}

List<Building> getBuildingsAPI(String mappaId) {
  return List.generate(
      5,
          (i) =>
          Building.fromMap('', {
            'id': i.toString(),
            'title': serviceToString(SERVICE([1, 2, 4, 8, 16][i])),
            'description': """This Building page is board Level page.
You can check the services and leave the
tips. You can create you own also!""",
            'pip': pipToString(PIP.PUBLIC),
            'createdAt': DateTime.now().toIso8601String(),
            'location': LatLng(
              gtLat +
                  0.0001 * rand.nextInt(10 + i) * (rand.nextBool() ? 1 : -1),
              gtLng +
                  0.0001 * rand.nextInt(10 + i) * (rand.nextBool() ? 1 : -1),
            ).toJson(),
            'serviceCheckBits': [1, 2, 4, 8, 16][i],
          }));
}

Map<String, dynamic> getBuildingAPI(String buildingId) {
  int i = rand.nextInt(5);
  return {
    'id': i.toString(),
    'title': serviceToString(SERVICE([1, 2, 4, 8, 16][i])),
    'description': """This Building page is board Level page.
You can check the services and leave the
tips. You can create you own also!""",
    'pip': pipToString(PIP.PUBLIC),
    'createdAt': DateTime.now().toIso8601String(),
    'location': LatLng(
      gtLat + 0.0001 * rand.nextInt(10 + i) * (rand.nextBool() ? 1 : -1),
      gtLng + 0.0001 * rand.nextInt(10 + i) * (rand.nextBool() ? 1 : -1),
    ).toJson(),
    'serviceCheckBits': [1, 2, 4, 8, 16][i],
    'bottoms': [3, null, 1],
  };
}

List<Map<String, dynamic>> getServicesAPI(String buildingId) {
  return [];
}
