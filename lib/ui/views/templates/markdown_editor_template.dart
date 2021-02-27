import 'package:flutter/material.dart';
import 'package:padong/core/models/pip.dart';
import 'package:padong/core/padong_router.dart';
import 'package:padong/ui/shared/types.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/widgets/title_header.dart';
import 'package:padong/ui/widgets/paddong_markdown.dart';
import 'package:padong/ui/widgets/bars/back_app_bar.dart';
import 'package:padong/ui/widgets/buttons/button.dart';
import 'package:padong/ui/widgets/buttons/switch_button.dart';
import 'package:padong/ui/widgets/inputs/input.dart';
import 'package:padong/ui/widgets/inputs/markdown_supporter.dart';
import 'package:padong/ui/views/templates/safe_padding_template.dart';

const List<String> PIPs = ['Public', 'Internal', 'Private'];

class MarkdownEditorTemplate extends StatefulWidget {
  final List<Widget> children;
  final bool withAnonym;
  final Widget topArea;
  final String editTxt;
  final String titleHint;
  final String contentHint;
  final Function(Map) onSubmit;

  MarkdownEditorTemplate(
      {this.children,
      this.withAnonym = false,
      this.editTxt = 'make',
      this.topArea,
      this.titleHint = 'Title of Board',
      @required this.onSubmit,
      this.contentHint});

  @override
  _MarkdownEditorTemplateState createState() => _MarkdownEditorTemplateState();
}

class _MarkdownEditorTemplateState extends State<MarkdownEditorTemplate> {
  int pipIdx = 0;
  bool isPreview = false;
  TextEditingController _titleController = TextEditingController();
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
                  callback: this.onTabOk,
                  shadow: false)
            ]),
        floatingBottomBar: MarkdownSupporter(this._mdController,
            withAnonym: widget.withAnonym),
        children: [
          this.topArea(),
          ...(this.isPreview
              ? [
                  TitleHeader(this._titleController.text, link: ''),
                  PadongMarkdown(this._mdController.text)
                ]
              : [
                  Input(
                      controller: this._titleController,
                      hintText: widget.titleHint,
                      type: InputType.UNDERLINE),
                  Input(
                      controller: this._mdController,
                      hintText: widget.contentHint ?? pipHint,
                      type: InputType.PLAIN)
                ]),
          SizedBox(height: 20),
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
                options: PIPs,
                buttonType: SwitchButtonType.SHADOW,
                onChange: (String selected) {
                  setState(() {
                    this.pipIdx = PIPs.indexOf(selected);
                  });
                }));
  }

  void onTabOk() {
    Map data = {
      'title': this._titleController.text,
      'description': this._mdController.text,
    };
    if (widget.topArea == null)
      data['pip'] = [PIP.PUBLIC, PIP.INTERNAL, PIP.PRIVATE][this.pipIdx];
    widget.onSubmit(data);
    PadongRouter.goBack();
    // TODO: show dialog or snackBar to alert submit complete
  }
}

String pipHint = """PIP Access 
- Public
  Everyone can see and edit.

- Internal
  Everyone can see, but only students of this
  university can edit.

- Private
  Students of this university can see & edit.""";
