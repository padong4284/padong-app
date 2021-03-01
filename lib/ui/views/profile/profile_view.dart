import 'package:flutter/material.dart';
import 'package:padong/core/apis/deck.dart';
import 'package:padong/ui/views/templates/safe_padding_template.dart';
import 'package:padong/ui/widgets/bars/back_app_bar.dart';
import 'package:padong/core/apis/session.dart' as Session;

class ProfileView extends StatelessWidget {
  final String id;
  final bool isMine;
  final Map<String, dynamic> user;

  ProfileView(String id)
      : this.id = id,
        this.isMine = Session.user['id'] == id,
        this.user = getUserAPI(id);

  @override
  Widget build(BuildContext context) {
    return SafePaddingTemplate(
        appBar: BackAppBar(),
        children: [

    ]);
  }
}
