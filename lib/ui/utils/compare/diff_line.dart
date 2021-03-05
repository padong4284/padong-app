import 'dart:math';
import 'package:diff_match_patch/diff_match_patch.dart';

String getCompared(String prev, String next) {
  String compared = '';
  List<Diff> diffs = diffLine(prev, next);
  for (Diff diff in diffs) {
    if (diff.operation == DIFF_EQUAL)
      compared += diff.text;
    else {
      String token = diff.operation == DIFF_DELETE
          ? '--'
          : '++'; // diff.operation == DIFF_INSERT
      compared += '$token${diff.text}$token${'\n'}';
    }
  }
  return compared;
}

String toLinuxNewLine(String t) {
  return t
      .replaceAll('\r\n', '\n') //replace Windows NewLine
      .replaceAll('\r', '\n'); // replace MacOs NewLine
}

//Todo: Have to optimize with https://en.wikipedia.org/wiki/Longest_common_subsequence_problem#Reduce_the_problem_set
//Todo: Have to study google/diff-match-patch's Algorithm (  Myer's diff algorithm, https://neil.fraser.name/writing/diff/ )
List<Diff> diffLine(String prev, String next) {
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
      result.add(Diff(DIFF_EQUAL, p[i]));
    } else if (j > 0 && (i == 0 || lcs[i][j - 1] >= lcs[i - 1][j])) {
      backTrackDiff(i, j - 1);
      result.add(Diff(DIFF_INSERT, n[j]));
    } else if (i > 0 && (j == 0 || lcs[i][j - 1] < lcs[i - 1][j])) {
      backTrackDiff(i - 1, j);
      result.add(Diff(DIFF_DELETE, p[i]));
    } else {}
  };

  backTrackDiff(p.length - 1, n.length - 1);
  return result;
}
