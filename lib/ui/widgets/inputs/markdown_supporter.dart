import 'package:flutter/material.dart';
import 'package:padong/ui/shared/types.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/theme/markdown_theme.dart';
import 'package:padong/ui/widgets/bars/floating_bottom_bar.dart';
import 'package:padong/ui/widgets/buttons/transp_button.dart';

class MarkdownSupporter extends StatelessWidget {
  final TextEditingController _mdController;

  MarkdownSupporter(this._mdController);

  @override
  Widget build(BuildContext context) {
    return FloatingBottomBar(
        child: Container(
      height: 38,
      child: Row(children: [
        TranspButton(
            callback: this.addPhoto,
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

  void addPhoto() {}

  List<Widget> supporters() {
    Map<Function, Widget> buttons = {
      () => this.applyH(1): Text('H1', style: MarkdownTheme.h1),
      () => this.applyH(2): Text('H2', style: MarkdownTheme.h2),
      () => this.applyH(3): Text('H3', style: MarkdownTheme.h3),
      this.emphasis: Text(' emphasis ', style: MarkdownTheme.strong),
      this.blockQuote: Row(children: [
        Container(width: 4, height: 18, color: AppTheme.colors.support),
        Container(
            padding: const EdgeInsets.only(left: 10, right: 5),
            color: AppTheme.colors.lightSupport,
            child: Text('block quote', style: MarkdownTheme.blockQuote))
      ]),
      this.codeBlock: Text(' code block ', style: MarkdownTheme.codeBlock)
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
  }

  void applyH(int level) {
    _surroundTextSelection('#' * level + ' ', '');
  }

  void emphasis() {
    _surroundTextSelection('**', '**');}

  void blockQuote() {
    _surroundTextSelection('> ', '');
  }

  void codeBlock() {
    _surroundTextSelection('```\n', '\n```');
  }
}
