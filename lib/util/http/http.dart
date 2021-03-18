import 'package:http/http.dart' as http;
import 'package:padong/core/shared/validator.dart';

Future<String> checkHeader(
    String url, Map<String, String> CompareHeader) async {
  var res = await http.head(Uri.parse(url));
  if (res.statusCode != 200) {
    return null;
  }
  for (var i in CompareHeader.keys) {
    if (!Validator.isValid(RegExp(CompareHeader[i]), res.headers[i])) {
      return null;
    }
  }
  return url;
}

Future<List<String>> checkImgUrls(List<String> urls) async {
  return await Future.wait(
          urls.map((url) => checkHeader(url, {'Content-Type': "image/.+"})))
      .timeout(Duration(seconds: 15))
      .then((value) => value.where((element) => element != null).toList());

}
