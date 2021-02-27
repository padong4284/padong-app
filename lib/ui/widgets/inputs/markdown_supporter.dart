import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:padong/ui/shared/types.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/theme/markdown_theme.dart';
import 'package:padong/ui/widgets/bars/floating_bottom_bar.dart';
import 'package:padong/ui/widgets/buttons/transp_button.dart';
import 'package:padong/ui/widgets/dialogs/image_uploader.dart';

class MarkdownSupporter extends StatelessWidget {
  final TextEditingController _mdController;
  final bool withAnonym;

  MarkdownSupporter(this._mdController, {this.withAnonym = false});

  @override
  Widget build(BuildContext context) {
    return FloatingBottomBar(
        withAnonym: this.withAnonym,
        child: Container(
          height: 38,
          child: Row(children: [
            TranspButton(
                callback: this.addPhoto(context),
                buttonSize: ButtonSize.GIANT,
                icon: Icon(Icons.photo_camera_rounded,
                    size: 30, color: AppTheme.colors.support)),
            Container(width: 2, color: AppTheme.colors.semiSupport),
            Expanded(
                child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [SizedBox(width: 10), ...this.supporters()]))
          ]),
        ));
  }

  Function addPhoto(context) {
    return getImageFromUser(context, (PickedFile image) {
      this._mdController.text += '![IMAGE](' + image.path + ')';
      // https://github.com/ptyagicodecamp/flutter_cookbook/blob/widgets/flutter_widgets/lib/images/upload_image.dart
      // TODO: upload to firebase
    });
  }

  List<Widget> supporters() {
    Map<Function, Widget> buttons = {
      this.applyH(1): Text('H1', style: MarkdownTheme.h1),
      this.applyH(2): Text('H2', style: MarkdownTheme.h2),
      this.applyH(3): Text('H3', style: MarkdownTheme.h3),
      this.emphasis: Text(' B ', style: MarkdownTheme.strong),
      this.italic: Text(' I ', style: MarkdownTheme.italic),
      this.del: Text(' D ', style: MarkdownTheme.del),
      this.blockQuote: Row(children: [
        Container(width: 4, height: 18, color: AppTheme.colors.support),
        Container(
            padding: const EdgeInsets.only(left: 10, right: 5),
            color: AppTheme.colors.lightSupport,
            child: Text('block quote', style: MarkdownTheme.blockQuote))
      ]),
      this.inlineCode: Text(' inline code ', style: MarkdownTheme.inlineCode),
      this.codeBlock: Container(
          color: Color(0xff202326),
          child:
              Icon(Icons.code_rounded, color: AppTheme.colors.base, size: 20)),
      this.link: Icon(Icons.link_rounded, size: 25),
      this.imgLink: Icon(Icons.image_rounded, size: 20),
    };
    return buttons
        .map((func, widget) => MapEntry(
            func,
            InkWell(
                onTap: func,
                child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    alignment: Alignment.center,
                    height: 22,
                    child: widget))))
        .values
        .toList();
  }

  void _surroundTextSelection(String left, String right) {
    try {
      final currentTextValue = this._mdController.value.text;
      final selection = this._mdController.selection;
      final middle = selection.textInside(currentTextValue);
      final newTextValue = selection.textBefore(currentTextValue) +
          '$left$middle$right' +
          selection.textAfter(currentTextValue);

      this._mdController.value = this._mdController.value.copyWith(
          text: newTextValue,
          selection: TextSelection.collapsed(
              offset: selection.baseOffset + left.length + middle.length));
    } catch (RangeError) {} // not focused on
  }

  Function applyH(int level) =>
      () => this._surroundTextSelection('#' * level + ' ', '');

  void italic() => this._surroundTextSelection('*', '*');

  void del() => this._surroundTextSelection('~', '~');

  void emphasis() => this._surroundTextSelection('**', '**');

  void link() => _surroundTextSelection('[TITLE](https://', ')');

  void imgLink() => _surroundTextSelection('![IMG](https://', ')');

  void blockQuote() => this._surroundTextSelection('> ', '');

  void inlineCode() => this._surroundTextSelection('`', '`');

  void codeBlock() => this._surroundTextSelection('```\n', '\n```');
}
