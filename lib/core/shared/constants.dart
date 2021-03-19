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
const String MEMO_RULE = """You can memo anything!
Memo is always Internal.

only you and your friends can read and write!
""";

const String ASK_RULE = """You can ask anything!
Question is always Public.

Anyone can see your Question,
and Everyone can help you.

Ask Freely! It's Free!
""";

const String MEMO_HINT = """You can memo anything!
Memo is always Internal.

only you and your friends can read and write!
""";

const String QUESTION_HINT = """You can ask anything!
Question is always Public.

Anyone can see your Question,
and Everyone can help you.

Ask Freely! It's Free!
""";

const String PIP_HINT = """PIP Access 
- Public
  Everyone can see and edit.

- Internal
  Everyone can see, but only students of this
  university can edit.

- Private
  Students of this university can see & edit.""";

const String CHAT_RULE = """PIP Access 

- Public
  Group Chat Room which anyone can search
  and join.

- Internal
  Group Chat Room which only invitees 
  participate

- Private
  1:1 Chat Room.
""";

const List<List<String>> KEYBOARDS = [
  ["1234567890", "QWERTYUIOP", "ASDFGHJKL", "ZXCVBNM"],
  [
    "!@#\$%^&*()",
    "ㅂㅈㄷㄱㅅㅛㅕㅑㅐㅔ",
    "ㅁㄴㅇㄹㅎㅗㅓㅏㅣ",
    "ㅋㅌㅊㅍㅠㅜㅡ",
  ],
];
