import 'package:flutter/material.dart';
import 'package:padong/ui/theme/app_theme.dart';

class SafePaddingTemplate extends StatelessWidget {
  final String title;
  final AppBar appBar;
  final Widget floatingActionButton;
  final Widget floatingBottomBar;
  final List<Widget> children;

  const SafePaddingTemplate(
      {this.appBar,
      this.floatingActionButton,
      this.floatingBottomBar,
      @required this.children,
      this.title = ''});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: this.appBar,
        floatingActionButton: this.floatingActionButton,
        body: SafeArea(
            child: GestureDetector(
                onTap: () {
                  FocusScopeNode currentFocus = FocusScope.of(context);
                  if (!currentFocus.hasPrimaryFocus &&
                      currentFocus.focusedChild != null)
                    FocusManager.instance.primaryFocus.unfocus();
                },
                child: Stack(children: [
                  SingleChildScrollView(
                      padding: EdgeInsets.symmetric(
                          horizontal: AppTheme.horizontalPadding),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            this.title.length > 0 ? this._topTitle() : null,
                            ...this.children
                          ].where((elm) => elm != null).toList())),
                  Align(
                      alignment: Alignment.bottomCenter,
                      child: this.floatingBottomBar ?? SizedBox.shrink())
                ]))));
  }

  Widget _topTitle() {
    return Container(
        height: AppBar().preferredSize.height,
        alignment: Alignment.centerLeft,
        child: Text(this.title,
            style: AppTheme.getFont(
                fontSize: AppTheme.fontSizes.large,
                color: AppTheme.colors.semiPrimary)));
  }
}
