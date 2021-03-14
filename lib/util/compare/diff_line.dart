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
import 'dart:math';

const DELETE = -1;
const INSERT = 1;
const EQUAL = 0;

class Diff {
  final int op;
  final String text;

  Diff(this.op, this.text);
}

//Todo: Have to optimize with https://en.wikipedia.org/wiki/Longest_common_subsequence_problem#Reduce_the_problem_set
//Todo: Have to study google/diff-match-patch's Algorithm (  Myer's diff algorithm, https://neil.fraser.name/writing/diff/ )
List<Diff> diffLine(String prev, String next) {
  if (prev == null || prev.length == 0)
    return [Diff(INSERT, next)];
  else if (next == null || next.length == 0) return [Diff(DELETE, prev)];

  List<Diff> result = List<Diff>();
  List<String> p = toLinuxNewLine(prev).split('\n');
  List<String> n = toLinuxNewLine(next).split('\n');

  //calculate lcs
  List<List<int>> lcs = List<List<int>>.generate(
      p.length, (index) => List<int>.filled(n.length, 0));
  for (var i = 1; i < p.length; i++) {
    for (var j = 1; j < n.length; j++) {
      if (p[i] == n[j])
        lcs[i][j] = lcs[i - 1][j - 1] + 1;
      else
        lcs[i][j] = max(lcs[i][j - 1], lcs[i - 1][j]);
    }
  }

  Function(int, int) backTrackDiff; //define for recursive call
  backTrackDiff = (int i, int j) {
    if (i >= 0 && j >= 0 && p[i] == n[j]) {
      backTrackDiff(i - 1, j - 1);
      result.add(Diff(EQUAL, p[i] + '\n'));
    } else if (j > 0 && (i == 0 || lcs[i][j - 1] >= lcs[i - 1][j])) {
      backTrackDiff(i, j - 1);
      result.add(Diff(INSERT, n[j] + '\n'));
    } else if (i > 0 && (j == 0 || lcs[i][j - 1] < lcs[i - 1][j])) {
      backTrackDiff(i - 1, j);
      result.add(Diff(DELETE, p[i] + '\n'));
    } else {}
  };

  backTrackDiff(p.length - 1, n.length - 1);
  return result;
}

String toLinuxNewLine(String source) {
  return source
      .replaceAll('\r\n', '\n') //replace Windows NewLine
      .replaceAll('\r', '\n'); // replace MacOs NewLine
}
