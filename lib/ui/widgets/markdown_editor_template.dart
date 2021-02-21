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

class MarkdownEditorTemplate extends StatefulWidget {
  final List<Widget> children;
  final Widget topArea;
  final String titleHint;
  final String contentHint;

  MarkdownEditorTemplate(
      {this.children,
      this.topArea,
      this.titleHint = 'Title of Post',
      this.contentHint});

  @override
  _MarkdownEditorTemplateState createState() => _MarkdownEditorTemplateState();
}

class _MarkdownEditorTemplateState extends State<MarkdownEditorTemplate> {
  bool isPreview = false;

  @override
  Widget build(BuildContext context) {
    return SafePaddingTemplate(
        appBar: BackAppBar(
            isClose: true,
            switchButton: SwitchButton(
                options: ['write', 'prev'],
                onChange: (String selected) {
                  setState(() {
                    this.isPreview = selected == 'prev';
                  });
                }),
            actions: [
              Button(
                  title: 'Ok',
                  buttonSize: ButtonSize.SMALL,
                  borderColor: AppTheme.colors.primary,
                  shadow: false)
            ]),
        floatingBottomBar: MarkdownSupporter(),
        children: [
          Container(
              height: 55,
              alignment: Alignment.centerLeft,
              child: widget.topArea ??
                  SwitchButton(
                    options: ['Public', 'Internal', 'Private'],
                    buttonType: SwitchButtonType.SHADOW,
                  )),
          ...(isPreview
              ? [PadongMarkdown()]
              : [
                  Input(hintText: widget.titleHint, type: InputType.UNDERLINE),
                  Input(
                      hintText: widget.contentHint ?? pipHint,
                      type: InputType.PLANE)
                ]),
          ...(widget.children != null ? widget.children : [])
        ]);
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
