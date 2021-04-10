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
import 'package:flutter/material.dart';
import 'package:padong/core/node/schedule/event.dart';
import 'package:padong/core/node/schedule/memo.dart';
import 'package:padong/ui/template/board_template.dart';
import 'package:padong/ui/widget/card/event_card.dart';
import 'package:padong/ui/widget/dialog/more_dialog.dart';

class EventView extends StatefulWidget {
  final Event event;

  EventView(this.event);

  _EventViewState createState() => _EventViewState();
}

class _EventViewState extends State<EventView> {
  @override
  Widget build(BuildContext context) {
    return BoardTemplate(
      widget.event,
      Memo(),
      setState,
      writeMessage: 'memo',
      postsMessage: 'Memos',
      emptyMessage: 'You can memo anything!',
      onPressMore: () =>
          MoreDialog.show(context, widget.event, editUrl: 'update'),
      center: [
        Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: EventCard(widget.event)),
      ],
    );
  }
}
