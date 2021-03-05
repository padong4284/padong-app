import 'package:diff_match_patch/diff_match_patch.dart';

String toLinuxNewLine(String t) {
  return t
      .replaceAll('\r\n', '\n') //replace Windows NewLine
      .replaceAll('\r', '\n'); // replace MacOs NewLine
}

//Todo: Have to optimize with https://en.wikipedia.org/wiki/Longest_common_subsequence_problem#Reduce_the_problem_set
//Todo: Have to study google/diff-match-patch's Algorithm (  Myer's diff algorithm, https://neil.fraser.name/writing/diff/ )
List<Diff> diff(String prev, String next) {
  List<String> p = toLinuxNewLine(prev).split('\n');
  List<String> n = toLinuxNewLine(next).split('\n');
  List<List<int>> lcs = List<List<int>>.generate(p.length, (index) => List<int>.filled(n.length, 0));
  List<Diff> result = List<Diff>();

  var max = (int a,int b) => ( a<b ? b : a);

  //caculate lcs
  for (var i = 1; i < p.length; i++) {
    for (var j = 1; j < n.length; j++) {
      if (p[i] == n[j]){
        lcs[i][j] = lcs[i-1][j-1] + 1;
      }
      else {
        lcs[i][j] = max(lcs[i][j-1], lcs[i-1][j]);
      }
    }
  }

  Function(int,int) backtrack_diff; //define for recursive call
  backtrack_diff = (int i, int j) {
    if (i >= 0 && j >= 0 && p[i] == n[j]){
      backtrack_diff(i-1, j-1);
      result.add(Diff(DIFF_EQUAL, p[i]));
    }
    else if (j > 0 && (i == 0 || lcs[i][j-1] >= lcs[i-1][j]))
    {
      backtrack_diff(i, j-1);
      result.add(Diff(DIFF_INSERT, n[j]));
    }
    else if (i > 0 &&(j == 0 || lcs[i][j-1] < lcs[i-1][j])){
      backtrack_diff(i-1, j);
      result.add(Diff(DIFF_DELETE, p[i]));
    }
    else{

    }
  };
  backtrack_diff(p.length-1, n.length-1);
  return result;
}