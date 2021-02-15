import 'package:flutter/material.dart';
import 'main_view.dart';

import 'package:padong/ui/views/cover/wiki_cover_view.dart';
import 'package:padong/ui/views/deck/deck_view.dart';
import 'package:padong/ui/views/lecture/lecture_list_view.dart';
import 'package:padong/ui/views/map/map_view.dart';
import 'package:padong/ui/views/schedule/schedule_view.dart';

class PMainView extends StatelessWidget {
  Widget build(BuildContext context) {
    return MainView(isPMain: true);
  }
}