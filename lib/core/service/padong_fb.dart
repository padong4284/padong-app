///*********************************************************************
///* Copyright (C) 2021-2021 Taejun Jang <padong4284@gmail.com>
///* All Rights Reserved.
///* This file is part of PADONG.
///*
///* PADONG can not be copied and/or distributed without the express
///* permission of Taejun Jang, Daewoong Ko, Hyunsik Kim, Seongbin Hong
///*
///* Github [https://github.com/padong4284]
///*********************************************************************
import 'package:cloud_firestore/cloud_firestore.dart';

class PadongFB {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  static WriteBatch getBatch() => _db.batch();

  static Future<DocumentReference> createDoc(String type, Map data) async {
    return await _db.collection(type).add(data).then((DocumentReference ref) {
      if (ref.id == null) return null;
      return ref;
    }).catchError((e) => null);
  }

  static Future<bool> setDoc(String type, String id, Map data) async {
    return await _db
        .collection(type)
        .doc(id)
        .set(data)
        .then((_) => true)
        .catchError((e) => false);
  }

  static Future<DocumentSnapshot> getDoc(String type, String id) async {
    return await _db
        .collection(type)
        .doc(id)
        .get()
        .then((DocumentSnapshot doc) {
      if (!doc.exists) throw Exception("Node doesn't Exists");
      if (doc.data()['deletedAt'] != null)
        throw Exception('Request Deleted Node $id');
      return doc;
    }).catchError((e) => null);
  }

  static DocumentReference getDocRef(String type, [String id]) {
    return _db.collection(type).doc(id);
  }

  static Future<bool> updateDoc(String type, String id, Map data) async {
    // assume modified (updated) data is passed
    return await _db
        .collection(type)
        .doc(id)
        .update({...data, 'modifiedAt': DateTime.now().toIso8601String()})
        .then((_) => true)
        .catchError((e) => false);
  }

  static Future<bool> deleteDoc(String type, String id) async {
    return await _db
        .collection(type)
        .doc(id)
        .update({'deletedAt': DateTime.now().toIso8601String()})
        .then((_) => true)
        .catchError((e) => false);
  }

  static Future<List<DocumentSnapshot>> getDocsByRule(String type,
      {Query Function(Query) rule, int limit, String startId}) async {
    List<DocumentSnapshot> result = [];
    Query query = _db.collection(type).where('deletedAt', isEqualTo: null);
    if (rule != null) query = rule(query);
    if (limit != null && limit > 0) query = query.limit(limit);
    if (startId != null) {
      DocumentSnapshot doc = await _db.collection(type).doc(startId).get();
      if (doc != null && doc.exists) query = query.startAtDocument(doc);
    }
    return await query.get().then((QuerySnapshot queryResult) {
      for (DocumentSnapshot doc in queryResult.docs) result.add(doc);
      return result;
    }).catchError((e) => null);
  }

  static Future<Stream<QuerySnapshot>> getQueryStreamByRule(String type,
      {Query Function(Query) rule, int limit = 30}) async {
    Query query = _db.collection(type).where('deletedAt', isEqualTo: null);
    if (rule != null) query = rule(query);
    if (limit != null && limit > 0) query = query.limit(limit);
    return query.snapshots();
  }
}
