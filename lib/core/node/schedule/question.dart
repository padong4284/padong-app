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
import 'package:padong/core/node/deck/post.dart';

// parent: Lecture
class Question extends Post {
  Question();

  Question.fromMap(String id, Map snapshot) : super.fromMap(id, snapshot);

  @override
  generateFromMap(String id, Map snapshot) => Question.fromMap(id, snapshot);

// TODO: Adopt an answer
}
