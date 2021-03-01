import 'package:flutter/material.dart';
import 'package:padong/core/apis/deck.dart';
import 'package:padong/ui/views/templates/safe_padding_template.dart';
import 'package:padong/ui/widgets/bars/back_app_bar.dart';
import 'package:padong/core/apis/session.dart' as Session;
import 'package:padong/ui/widgets/containers/tab_container.dart';

class FriendsView extends StatelessWidget {
  final String id;
  final bool isMine;
  final Map<String, dynamic> user;

  FriendsView(String id)
      : this.id = id,
        this.isMine = Session.user['id'] == id,
        this.user = getUserAPI(id);

  @override
  Widget build(BuildContext context) {
    return SafePaddingTemplate(
        appBar: BackAppBar(isClose: true, title: 'Friends'),
        children: [
          SizedBox(height: 10),
          TabContainer(tabWidth: 85.0,
              tabs: ['Friends', 'Receives', 'Sends'],
              children: [Container(), Container(), Container()])
        ]);
  }
}
