import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:padong/core/apis/deck.dart';
import 'package:padong/ui/views/templates/markdown_editor_template.dart';
import 'package:padong/ui/widgets/title_header.dart';

class PinView extends StatelessWidget {
  final String mappaId;
  final LatLng location;

  PinView(this.mappaId, String lat, String lng)
      : this.location = LatLng(double.parse(lat), double.parse(lng));

  @override
  Widget build(BuildContext context) {
    print(this.location.toJson());
    return MarkdownEditorTemplate(
      editTxt: 'pin',
      onSubmit: this.createBoard,
      children: [
        TitleHeader('Services'),
      ],
    );
  }

  void createBoard(Map data) {
    data['parentId'] = this.mappaId;
    createBoardAPI(data);
  }
}
