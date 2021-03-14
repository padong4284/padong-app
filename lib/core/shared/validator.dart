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
// check validation of user input with RefExp

class Validator {
  static RegExp idRule = new RegExp(r"[a-z0-9.]{6,30}");

  // https://www.regular-expressions.info/email.html
  // perfect email regexp is not exists
  static RegExp emailRule =
      new RegExp(r"(^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$)");

  static RegExp specialChar = new RegExp(r"\W");
  static RegExp alphabetChar = new RegExp(r"[a-zA-Z]");
  static RegExp numberChar = new RegExp(r"[0-9]");

  static bool isValid(RegExp regexp, String data) {
    RegExpMatch matchResult = regexp.firstMatch(data);
    if (matchResult == null) return false;
    return (matchResult.start == 0 && matchResult.end == data.length);
  }

  static bool pwIsValid(
      String pw, bool Function(int idx, String errorText) setErrorText) {
    if (pw.length < 8) return setErrorText(1, "The length must 8 or more.");
    if (!specialChar.hasMatch(pw) &&
        alphabetChar.hasMatch(pw) &&
        numberChar.hasMatch(pw))
      return setErrorText(
          1, "Use combination of letters, numbers, and symbols");
    return true;
  }
}
