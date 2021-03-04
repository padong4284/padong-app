import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:markdown/markdown.dart' as md;

class DeletedSyntax extends md.InlineSyntax {
  DeletedSyntax({
    String pattern = r'--(.*?)--',
  }) : super(pattern);

  @override
  bool onMatch(md.InlineParser parser, Match match) {
    final withoutDashes = match.group(0).replaceAll(RegExp('--'), "");
    md.Element el = md.Element.text("deletedDiff", withoutDashes);
    parser.addNode(el);
    return true;
  }
}

class DeletedElementBuilder extends MarkdownElementBuilder {
  @override
  Widget visitElementAfter(md.Element element, TextStyle preferredStyle) {
    return Text(element.textContent,
        style: TextStyle(color: Colors.white, backgroundColor: Colors.red));
  }
}
