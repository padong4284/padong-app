import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:highlight/highlight.dart' show highlight, Node;
import 'package:flutter/painting.dart';
import 'package:padong/ui/theme/app_theme.dart';

class PadongSyntaxHighlighter extends SyntaxHighlighter {
  final String language;
  final _rootKey = 'root';
  final _defaultFontFamily = 'monospace';
  final _defaultFontColor = Color(0xfffdfeff);
  final Map<String, TextStyle> theme = codeTheme;

  PadongSyntaxHighlighter({this.language = 'python'});

  @override
  TextSpan format(String source) {
    source += '\n'+ ' '*82;
    var _textStyle = TextStyle(
      fontFamily: this._defaultFontFamily,
      color: this.theme[this._rootKey].color ?? this._defaultFontColor,
    );
    return TextSpan(
      style: _textStyle,
      children: _convert(highlight
          .parse(source, autoDetection: true, language: this.language)
          .nodes),
    );
  }

  List<TextSpan> _convert(List<Node> nodes) {
    List<TextSpan> spans = [];
    var currentSpans = spans;
    List<List<TextSpan>> stack = [];

    _traverse(Node node) {
      if (node.value != null) {
        currentSpans.add(node.className == null
            ? TextSpan(text: node.value)
            : TextSpan(text: node.value, style: theme[node.className]));
      } else if (node.children != null) {
        List<TextSpan> tmp = [];
        currentSpans.add(TextSpan(children: tmp, style: theme[node.className]));
        stack.add(currentSpans);
        currentSpans = tmp;

        node.children.forEach((n) {
          _traverse(n);
          if (n == node.children.last)
            currentSpans = stack.isEmpty ? spans : stack.removeLast();
        });
      }
    }

    for (var node in nodes) _traverse(node);
    return spans;
  }
}

const codeTheme = {
  'root': TextStyle(
      backgroundColor: Color(0xff202326), color: Color(0xfffdfeff)), //
  'comment': TextStyle(color: Color(0xff669955)), //
  'quote': TextStyle(color: Color(0xff007400)),
  'tag': TextStyle(color: Color(0xff8fcfdf)), //
  'selector-tag': TextStyle(color: Color(0xff8fcfdf)), //
  'attribute': TextStyle(color: Color(0xff4ec9b0)),
  'keyword': TextStyle(color: Color(0xff05b0ea)), //
  'literal': TextStyle(color: Color(0xffff6600)), // True
  'name': TextStyle(color: Color(0xffff6600)),
  'variable': TextStyle(color: Color(0xff9cdcfe)), //
  'template-variable': TextStyle(color: Color(0xff3F6E74)),
  'code': TextStyle(color: Color(0xfff51525)),
  'string': TextStyle(color: Color(0xffff9900)), //
  'meta-string': TextStyle(color: Color(0xffff5353)),
  'regexp': TextStyle(color: Color(0xff10c0e0)),
  'link': TextStyle(color: Color(0xff8fcfdf)),
  'title': TextStyle(color: Color(0xfff0d070)), //
  'symbol': TextStyle(color: Color(0xffb5cea8)), //
  'bullet': TextStyle(color: Color(0xff059acb)),
  'number': TextStyle(color: Color(0xffff5353)), //
  'section': TextStyle(color: Color(0xfff51525)),
  'meta': TextStyle(color: Color(0xfff51525)),
  'type': TextStyle(color: Color(0xff4ec9b0)),
  'built_in': TextStyle(color: Color(0xff05b0ea)), //
  'builtin-name': TextStyle(color: Color(0xff059acb)),
  'params': TextStyle(color: Color(0xff9cdcfe)), //
  'attr': TextStyle(color: Color(0xff10c0e0)),
  'subst': TextStyle(color: Color(0xffff6600)), //
  'formula': TextStyle(
      backgroundColor: Color(0xffff6600), fontStyle: FontStyle.italic),
  'addition': TextStyle(backgroundColor: Color(0xff9cdcfe)),
  'deletion': TextStyle(backgroundColor: Color(0xfff0d070)),
  'selector-id': TextStyle(color: Color(0xffff9900)),
  'selector-class': TextStyle(color: Color(0xfff0d070)),
  'doctag': TextStyle(fontWeight: FontWeight.bold),
  'strong': TextStyle(fontWeight: FontWeight.bold),
  'emphasis': TextStyle(fontStyle: FontStyle.italic),
};
