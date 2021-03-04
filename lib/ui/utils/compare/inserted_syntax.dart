import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:markdown/markdown.dart' as md;

class InsertedSyntax extends md.InlineSyntax {
  InsertedSyntax({
    String pattern = r'\+\+(.*?)\+\+',
  }) : super(pattern);

  @override
  bool onMatch(md.InlineParser parser, Match match) {
    final withoutDashes = match.group(0).replaceAll('++', "");
    md.Element el = md.Element.text("insertedDiff", withoutDashes);
    parser.addNode(el);
    return true;
  }
}

class InsertedElementBuilder extends MarkdownElementBuilder {
  @override
  Widget visitElementAfter(md.Element element, TextStyle preferredStyle) {
    return Text(element.textContent,
        style: TextStyle(color: Colors.white, backgroundColor: Colors.blue));
  }
}
