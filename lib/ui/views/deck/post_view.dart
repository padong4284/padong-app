import 'package:flutter/material.dart';
import 'package:padong/ui/widgets/safe_padding_template.dart';

class PostView extends StatelessWidget {
  final String id;

  PostView({ this.id });

  @override
  Widget build(BuildContext context) {
    return SafePaddingTemplate(
        children: [
          Text('Post id: ${this.id}'),
          IconButton(icon: Icon(Icons.arrow_back), onPressed: () => {
            Navigator.pop(context)
          })
        ],
    );
  }
}