import 'package:flutter/material.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/widgets/bars/back_app_bar.dart';
import 'package:padong/ui/widgets/buttons/button.dart';
import 'package:padong/ui/shared/types.dart';
import 'package:padong/ui/widgets/buttons/switch_button.dart';
import 'package:padong/ui/widgets/inputs/input.dart';
import 'package:padong/ui/widgets/inputs/markdown_supporter.dart';
import 'package:padong/ui/widgets/paddong_markdown.dart';
import 'package:padong/ui/widgets/safe_padding_template.dart';

List<String> PIP = ['Public', 'Internal', 'Private'];

class MarkdownEditorTemplate extends StatefulWidget {
  final List<Widget> children;
  final Widget topArea;
  final String editTxt;
  final String titleHint;
  final String contentHint;

  MarkdownEditorTemplate(
      {this.children,
      this.editTxt = 'edit',
      this.topArea,
      this.titleHint = 'Title of Post',
      this.contentHint});

  @override
  _MarkdownEditorTemplateState createState() => _MarkdownEditorTemplateState();
}

class _MarkdownEditorTemplateState extends State<MarkdownEditorTemplate> {
  int pipIdx = 0;
  bool isPreview = false;
  TextEditingController _mdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafePaddingTemplate(
        appBar: BackAppBar(
            isClose: true,
            switchButton: this.prevSwitch(),
            actions: [
              Button(
                  title: 'Ok',
                  buttonSize: ButtonSize.SMALL,
                  borderColor: AppTheme.colors.primary,
                  shadow: false)
            ]),
        floatingBottomBar: MarkdownSupporter(),
        children: [
          this.topArea(),
          ...(isPreview
              ? [PadongMarkdown()]
              : [
                  Input(hintText: widget.titleHint, type: InputType.UNDERLINE),
                  Input(
                      controller: this._mdController,
                      hintText: widget.contentHint ?? pipHint,
                      type: InputType.PLANE)
                ]),
          ...(widget.children ?? [])
        ]);
  }

  Widget prevSwitch() {
    return SwitchButton(
        options: [widget.editTxt, 'prev'],
        onChange: (String selected) {
          setState(() {
            this.isPreview = selected == 'prev';
          });
        });
  }

  Widget topArea() {
    return Container(
        height: 55,
        alignment: Alignment.centerLeft,
        child: widget.topArea ??
            SwitchButton(
                options: PIP,
                buttonType: SwitchButtonType.SHADOW,
                onChange: (String selected) {
                  setState(() {
                    this.pipIdx = PIP.indexOf(selected);
                  });
                }));
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
}

String pipHint = """PIP Access 
- Public
  Everyone can see and edit.

- Internal
  Everyone can see, but only students of this
  university can edit.

- Private
  Students of this university can see & edit.


You must follow the rules below.
- Use the Markdown syntax.

- Some syntaxes may not be supported.

- Before finish the editing, check preview.
""";
