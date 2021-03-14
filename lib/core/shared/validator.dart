RegExp idRule = new RegExp(r"[a-z0-9.]{6,30}");

// https://www.regular-expressions.info/email.html
// perfect email regexp is not exists
RegExp emailRule =
    new RegExp(r"(^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$)");

bool isValid(RegExp regexp, String data) {
  RegExpMatch matchResult = regexp.firstMatch(data);
  if (matchResult == null) return false;
  return (matchResult.start == 0 && matchResult.end == data.length);
}
