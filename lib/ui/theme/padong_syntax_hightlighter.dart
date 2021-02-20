import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:highlight/highlight.dart' show highlight, Node;
import 'package:padong/ui/theme/app_theme.dart';

class PadongSyntaxHighlighter extends SyntaxHighlighter {
  final String language;
  static const _defaultFontFamily = 'monospace';
  static const _rootKey = 'root';
  static const _defaultFontColor = Color(0xff000000);
  static const _defaultBackgroundColor = Color(0xffffffff);
  final Map<String, TextStyle> theme = codeTheme;

  PadongSyntaxHighlighter({this.language='python'});

  @override
  TextSpan format(String source) {
    var _textStyle = TextStyle(
      fontFamily: _defaultFontFamily,
      color: theme[_rootKey]?.color ?? _defaultFontColor,
    );
    return TextSpan(
      style: _textStyle,
      children: _convert(highlight.parse(source, language: 'python').nodes),
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
          if (n == node.children.last) {
            currentSpans = stack.isEmpty ? spans : stack.removeLast();
          }
        });
      }
    }
    for (var node in nodes)_traverse(node);
    return spans;
  }
}

// GENERATED CODE - DO NOT MODIFY BY HAND


const codeTheme = {
  'root':
  TextStyle(backgroundColor: Color(0xffffffff), color: Color(0xff000000)),
  'comment': TextStyle(color: Color(0xff007400)),
  'quote': TextStyle(color: Color(0xff007400)),
  'tag': TextStyle(color: Color(0xffaa0d91)),
  'attribute': TextStyle(color: Color(0xffaa0d91)),
  'keyword': TextStyle(color: Color(0xffaa0d91)),
  'selector-tag': TextStyle(color: Color(0xffaa0d91)),
  'literal': TextStyle(color: Color(0xffaa0d91)),
  'name': TextStyle(color: Color(0xffaa0d91)),
  'variable': TextStyle(color: Color(0xff3F6E74)),
  'template-variable': TextStyle(color: Color(0xff3F6E74)),
  'code': TextStyle(color: Color(0xffc41a16)),
  'string': TextStyle(color: Color(0xffc41a16)),
  'meta-string': TextStyle(color: Color(0xffc41a16)),
  'regexp': TextStyle(color: Color(0xff0E0EFF)),
  'link': TextStyle(color: Color(0xff0E0EFF)),
  'title': TextStyle(color: Color(0xff1c00cf)),
  'symbol': TextStyle(color: Color(0xff1c00cf)),
  'bullet': TextStyle(color: Color(0xff1c00cf)),
  'number': TextStyle(color: Color(0xff1c00cf)),
  'section': TextStyle(color: Color(0xff643820)),
  'meta': TextStyle(color: Color(0xff643820)),
  'type': TextStyle(color: Color(0xff5c2699)),
  'built_in': TextStyle(color: Color(0xff5c2699)),
  'builtin-name': TextStyle(color: Color(0xff5c2699)),
  'params': TextStyle(color: Color(0xff5c2699)),
  'attr': TextStyle(color: Color(0xff836C28)),
  'subst': TextStyle(color: Color(0xff000000)),
  'formula': TextStyle(
      backgroundColor: Color(0xffeeeeee), fontStyle: FontStyle.italic),
  'addition': TextStyle(backgroundColor: Color(0xffbaeeba)),
  'deletion': TextStyle(backgroundColor: Color(0xffffc8bd)),
  'selector-id': TextStyle(color: Color(0xff9b703f)),
  'selector-class': TextStyle(color: Color(0xff9b703f)),
  'doctag': TextStyle(fontWeight: FontWeight.bold),
  'strong': TextStyle(fontWeight: FontWeight.bold),
  'emphasis': TextStyle(fontStyle: FontStyle.italic),
};
