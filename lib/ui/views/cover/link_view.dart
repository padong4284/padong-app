import 'package:flutter/material.dart';
import 'package:padong/ui/views/templates/safe_padding_template.dart';

class LinkView extends StatelessWidget {
  final String id;

  LinkView(wikiId) : this.id = wikiId;

  @override
  Widget build(BuildContext context) {
    return SafePaddingTemplate(
      children: [],
    );
  }
}
