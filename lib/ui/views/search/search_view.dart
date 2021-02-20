import 'package:flutter/material.dart';
import 'package:padong/ui/widgets/safe_padding_template.dart';
import 'package:padong/ui/widgets/bars/back_app_bar.dart';

class SearchView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafePaddingTemplate(
      appBar: BackAppBar(title: 'Search'),
      children: [],
    );
  }
}
