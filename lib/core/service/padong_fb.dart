import 'dart:math';

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

  static var documentId = FieldPath.documentId;

  static Future<DocumentReference> createDoc(String type, Map data) async {
    data.remove('id');
    return await _db.collection(type).add({
      ...data,
      'modifiedAt': FieldValue.serverTimestamp(),
      'createdAt': FieldValue.serverTimestamp()
    }).then((DocumentReference ref) {
      if (ref.id == null) return null;
      return ref;
    }).catchError((e) => null);
  }

  static Future<bool> setDoc(String type, String id, Map data) async {
    data.remove('id');
    if (await PadongFB.getDoc(type, id) == null)
      data['createdAt'] = FieldValue.serverTimestamp();

    return await _db
        .collection(type)
        .doc(id)
        .set({...data, 'modifiedAt': FieldValue.serverTimestamp()})
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
        .update({...data, 'modifiedAt': FieldValue.serverTimestamp()})
        .then((_) => true)
        .catchError((e) => false);
  }

  static Future<bool> deleteDoc(String type, String id, Map data) async {
    return await _db
        .collection(type)
        .doc(id)
        .update({...data, 'deletedAt': FieldValue.serverTimestamp()})
        .then((_) => true)
        .catchError((e) => false);
  }

  static Future<bool> removeDoc(String type, String id) async {
    return await _db
        .collection(type)
        .doc(id)
        .delete()
        .then((_) => true)
        .catchError((e) => false);
  }

  static Future<List<DocumentSnapshot>> getDocsByRule(String type,
      {Query Function(Query) rule,
      int limit,
      String startId,
      Map<dynamic, List<String>> whereIn}) async {
    if (whereIn != null) {
      List<DocumentSnapshot> result = [];
      for (var key in whereIn.keys) {
        int len = whereIn[key].length;
        for (int i = 0; i * 10 < len; i++)
          result += await _getDocsByRule(
            type,
            limit: limit,
            startId: startId,
            rule: (query) => (rule != null ? rule(query) : query).where(key,
                whereIn: whereIn[key].sublist(10 * i, min(10 * (i + 1), len))),
          );
      }
      return result;
    }
    return await _getDocsByRule(type,
        rule: rule, limit: limit, startId: startId);
  }

  static Future<List<DocumentSnapshot>> _getDocsByRule(String type,
      {Query Function(Query) rule, int limit, String startId}) async {
    Query query = _db.collection(type).where('deletedAt', isNull: true);
    if (rule != null) query = rule(query);
    if (limit != null && limit > 0) query = query.limit(limit);
    if (startId != null) {
      DocumentSnapshot doc = await _db.collection(type).doc(startId).get();
      if (doc != null && doc.exists) query = query.startAfterDocument(doc);
    }
    return await query.get().then((QuerySnapshot queryResult) {
      return <DocumentSnapshot>[...queryResult.docs];
    }).catchError((e) => null);
  }

  static Future<Stream<QuerySnapshot>> getQueryStreamByRule(String type,
      {Query Function(Query) rule, int limit = 30, String startId}) async {
    Query query = _db.collection(type).where('deletedAt', isNull: true);
    if (rule != null) query = rule(query);
    if (limit != null && limit > 0) query = query.limit(limit);
    if (startId != null) {
      DocumentSnapshot doc = await _db.collection(type).doc(startId).get();
      if (doc != null && doc.exists) query = query.startAfterDocument(doc);
    }
    return query.snapshots();
  }
}
