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
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:padong/core/shared/types.dart';
import 'package:padong/core/service/padong_fb.dart';

class Node {
  String id;
  PIP pip;
  String parentId;
  String ownerId; // Node User's id
  DateTime createdAt;
  DateTime modifiedAt;
  DateTime deletedAt;
  Map<String, List<Node>> _children;

  String get type => this.toString().split("'")[1].toLowerCase();

  Node();

  Node.fromMap(String id, Map snapshot) {
    this.id = id;
    this.pip = parsePIP(snapshot['pip']);
    this.parentId = snapshot['parentId'];
    this.ownerId = snapshot['ownerId'];
    snapshot['createdAt'] = // auto initialize
        snapshot['createdAt']!=null ? (snapshot['createdAt'] as Timestamp).toDate() : DateTime.now();
    this.createdAt = snapshot['createdAt'];
    this.modifiedAt = // not modified yet
        snapshot['modifiedAt']!= null ? (snapshot['createdAt'] as Timestamp).toDate() : snapshot['createdAt'];
    this.deletedAt = snapshot['deletedAt'] == null
        ? null // It may not deleted
        : (snapshot['deletedAt'] as Timestamp).toDate();
    if (!this.isValidate())
      throw Exception(
          'Invalid data try to construct ${this.type}\n${this.toJson()}');
  }

  Node generateFromMap(String id, Map snapshot) => Node.fromMap(id, snapshot);

  Map<String, dynamic> toJson() {
    return {
      "id": this.id,
      "pip": pipToString(this.pip),
      "type": this.type,
      "parentId": this.parentId,
      "ownerId": this.ownerId,
      "createdAt": this.createdAt.toIso8601String(),
      "modifiedAt": (this.modifiedAt ?? this.createdAt).toIso8601String(),
      "deletedAt": this.deletedAt == null
          ? null // It may not deleted
          : this.deletedAt.toIso8601String(),
    };
  }

  bool isValidate() {
    List<String> pass = ['deletedAt', 'likes', 'bookmarks', 'lastMessage'];
    Map<String, dynamic> data = this.toJson();
    for (String key in data.keys) {
      if (pass.contains(key)) continue;
      if (data[key] == null) {
        log('Node(${this.type}) Validation Check Failed.\n$data');
        return false;
      }
    } // check all fields are not null except deletedAt
    return true;
  }

  Future<Node> getParent(Node parent) async {
    DocumentSnapshot pDoc = await PadongFB.getDoc(parent.type, this.parentId);
    return parent.generateFromMap(pDoc.id, pDoc.data());
  }

  Future<List<Node>> getChildren(Node child,
      {int limit, Node startAt, bool upToDate}) async {
    if (upToDate || (this._children[child.type] == null))
      this._children[child.type] = await PadongFB.getDocsByRule(child.type,
              rule: (query) => query
                  .where(this.id, isEqualTo: 'parentId')
                  .orderBy("createdAt", descending: true),
              limit: limit,
              startId: startAt.id)
          .then((docs) => docs
              .map((doc) => child.generateFromMap(doc.id, doc.data()))
              .toList())
          .catchError((_) => null);
    return this._children[child.type];
  }

  void _refreshCreatedAt(Map<String,dynamic> data){
    data['createdAt'] = FieldValue.serverTimestamp();
  }
  void _refreshModifiedAt(Map<String,dynamic> data){
    data['modifiedAt'] = FieldValue.serverTimestamp();
  }
  void _refreshDeletedAt(Map<String,dynamic> data){
    data['modifiedAt'] = FieldValue.serverTimestamp();
  }

  Future<Node> create() async {
    // create document at Fire Base
    //this.createdAt = DateTime.now();
    var data = this.toJson();
    _refreshCreatedAt(data);
    _refreshModifiedAt(data);

    if (this.isValidate()) {
      DocumentReference ref =
          await PadongFB.createDoc(this.type, data);
      if (ref == null) throw Exception('Create Document Failed ${this.type}');
      this.id = ref.id;
      return this;
    }
    return null;
  }

  Future<Node> set(String id) async {
    // set document at Fire Base with id
    this.id = id;

    var data = this.toJson();
    await PadongFB.getDoc("node", id).catchError((e) {
      _refreshCreatedAt(data);
    });
    _refreshModifiedAt(data);

    if (this.isValidate())
      return (await PadongFB.setDoc(this.type, id, data))
          ? this
          : null;
    return null;
  }

  Future<bool> update() async {
    // assume this node is already modified (updated)
    // just update Fire Store data
    var data = this.toJson();
    _refreshModifiedAt(data);
    if (this.isValidate())
      return await PadongFB.updateDoc(this.type, this.id, data);
    return false;
  }

  Future<bool> delete() async {
    // set deletedAt now, PadongFB.getDoc never return this node;
    var data = this.toJson();
    _refreshDeletedAt(data);
    if (this.isValidate())
      return await PadongFB.deleteDoc(this.type, this.id); // success or not
    return false;
  }
}
