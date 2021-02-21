import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:markdown/markdown.dart' as md;
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/theme/markdown_theme.dart';

class PadongMarkdown extends StatelessWidget {
  Future<Widget> parseMarkdown(String data) {
    return Future(() {
      return MarkdownBody(
          data: data,
          syntaxHighlighter: MarkdownTheme.syntaxHighlighter,
          styleSheet: MarkdownStyleSheet(
              p: MarkdownTheme.p,
              a: MarkdownTheme.a,
              h1: MarkdownTheme.h1,
              h2: MarkdownTheme.h2,
              h3: MarkdownTheme.h3,
              strong: MarkdownTheme.strong,
              em: MarkdownTheme.em,
              blockquote: MarkdownTheme.blockQuote,
              blockquotePadding:
                  const EdgeInsets.symmetric(vertical: 5, horizontal: 12),
              blockquoteDecoration: BoxDecoration(
                  color: AppTheme.colors.lightSupport,
                  border: Border(
                      left: BorderSide(
                          width: 4, color: AppTheme.colors.support))),
              code: MarkdownTheme.codeBlock,
              codeblockDecoration: BoxDecoration(
                color: Color(0xFF202326),
                borderRadius: BorderRadius.circular(2.0),
              ),
              horizontalRuleDecoration: MarkdownTheme.horizontalRule),
          //syntaxHighlighter: ,
          extensionSet: md.ExtensionSet(
            md.ExtensionSet.gitHubFlavored.blockSyntaxes,
            [
              md.EmojiSyntax(),
              ...md.ExtensionSet.gitHubFlavored.inlineSyntaxes
            ],
          ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: rootBundle.loadString("assets/test.md"),
        builder: (BuildContext context, AsyncSnapshot<String> mdSnapshot) {
          if (mdSnapshot.connectionState == ConnectionState.done)
            return FutureBuilder(
                future: this.parseMarkdown(mdSnapshot.data),
                builder:
                    (BuildContext context, AsyncSnapshot<Widget> snapshot) {
                  if (snapshot.connectionState == ConnectionState.done)
                    return snapshot.data;
                  else
                    return CircularProgressIndicator();
                });
          return CircularProgressIndicator();
        });
  }
}
