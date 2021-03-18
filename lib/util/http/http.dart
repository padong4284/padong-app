import 'package:http/http.dart' as http;
import 'package:padong/core/shared/validator.dart';

class CheckUrl {
  String url;
  bool checkResult;
  CheckUrl(this.url, this.checkResult);
}

Future<CheckUrl> checkHeader(
    String url, Map<String, String> CompareHeader) async {
  var res = await http.head(Uri.parse(url));
  if (res.statusCode != 200) {
    return CheckUrl(url, false);
  }
  for (var i in CompareHeader.keys) {
    if (!Validator.isValid(RegExp(CompareHeader[i]), res.headers[i])) {
      return CheckUrl(url, false);
    }
  }
  return CheckUrl(url, true);
}

Future<List<CheckUrl>> checkImgUrls(List<String> urls) async {
  return await Future.wait(
      urls.map((url) => checkHeader(url, {'Content-Type': "image/.+"})));
}
