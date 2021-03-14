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
import 'package:padong/util/time_manager.dart';

class Node {
  String id;
  PIP pip;
  String parentId;
  String ownerId; // Node User's id
  DateTime createdAt;
  DateTime modifiedAt;
  DateTime deletedAt;
  Map<String, List<Node>> _children = {};
  DocumentSnapshot _ownerDoc;

  Future<DocumentSnapshot> get ownerDoc async {
    if (this._ownerDoc == null)
      this._ownerDoc = await PadongFB.getDoc('user', this.ownerId);
    return this._ownerDoc;
  }

  String get type => this.toString().split("'")[1].toLowerCase();

  Node();

  Node.fromMap(String id, Map snapshot) {
    this.id = id;
    this.pip = parsePIP(snapshot['pip']);
    this.parentId = snapshot['parentId'];
    this.ownerId = snapshot['ownerId'];
    snapshot['createdAt'] = // auto initialize
        snapshot['createdAt'] != null
            ? TimeManager.toDateTime(snapshot['createdAt'])
            : DateTime.now();
    this.createdAt = snapshot['createdAt'];
    this.modifiedAt = // not modified yet
        snapshot['modifiedAt'] != null
            ? TimeManager.toDateTime(snapshot['createdAt'])
            : snapshot['createdAt'];
    this.deletedAt = snapshot['deletedAt'] == null
        ? null // It may not deleted
        : TimeManager.toDateTime(snapshot['deletedAt']);
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
      "createdAt": this.createdAt,
      "modifiedAt": this.modifiedAt ?? this.createdAt,
      "deletedAt": this.deletedAt == null
          ? null // It may not deleted
          : this.deletedAt,
    };
  }

  bool isValidate() {
    List<String> pass = [
      'deletedAt',
      'likes',
      'bookmarks',
      'subscribes',
      'lastMessage',
      'lastItemId',
    ];
    Map<String, dynamic> data = this.toJson();
    for (String key in data.keys) {
      if (pass.contains(key)) continue;
      if (data[key] == null) {
        log('Node(${this.type}) Validation Check Failed. [$key]\n$data');
        return false;
      }
    } // check all fields are not null except deletedAt
    return true;
  }

  Future<Node> getParent(Node parent) async {
    DocumentSnapshot pDoc = await PadongFB.getDoc(parent.type, this.parentId);
    return parent.generateFromMap(pDoc.id, pDoc.data());
  }

  Future<Node> getChild(Node child) async {
    List<Node> _children = await this.getChildren(child);
    return (_children == null || _children.length == 0) ? null : _children[0];
  }

  Future<List<Node>> getChildren(Node child,
      {int limit, Node startAt, bool upToDate = true}) async {
    if (upToDate || (this._children[child.type] == null))
      this._children[child.type] = await PadongFB.getDocsByRule(child.type,
              rule: (query) => query
                  .where('parentId', isEqualTo: this.id)
                  .orderBy("createdAt", descending: true),
              limit: limit,
              startId: startAt != null ? startAt.id : null)
          .then((docs) => docs
              .map((doc) => child.generateFromMap(doc.id, doc.data()))
              .toList())
          .catchError((e) {log(e); return null;});
    return this._children[child.type] ?? [];
  }

  Future<Node> create() async {
    // create document at Fire Base
    if (this.isValidate()) {
      DocumentReference ref =
          await PadongFB.createDoc(this.type, this.toJson());
      if (ref == null) throw Exception('Create Document Failed ${this.type}');
      this.id = ref.id;
      return this;
    }
    return null;
  }

  Future<Node> set(String id) async {
    // set document at Fire Base with id
    this.id = id;

    if (this.isValidate())
      return (await PadongFB.setDoc(this.type, id, this.toJson()))
          ? this
          : null;
    return null;
  }

  Future<bool> update() async {
    // assume this node is already modified (updated)
    // just update Fire Store data
    if (this.isValidate())
      return await PadongFB.updateDoc(this.type, this.id, this.toJson());
    return false;
  }

  Future<bool> delete() async {
    // set deletedAt now, PadongFB.getDoc never return this node;
    if (this.isValidate())
      return await PadongFB.deleteDoc(this.type, this.id); // success or not
    return false;
  }
}
