import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:padong/ui/theme/app_theme.dart';

class SafePaddingTemplate extends StatefulWidget {
  final String title;
  final PreferredSizeWidget appBar;
  final Widget floatingActionButton;
  final Widget Function(bool)
      floatingActionButtonGenerator; // (isScrollingDown) => Widget
  final Widget floatingBottomBar;
  final Widget Function(bool)
      floatingBottomBarGenerator; // (isScrollingDown) => Widget
  final List<Widget> children;
  final bool isBottomBar;
  final Widget background;

  const SafePaddingTemplate(
      {this.appBar,
      floatingActionButton,
      floatingActionButtonGenerator,
      floatingBottomBar,
      floatingBottomBarGenerator,
      @required this.children,
        this.background,
      this.title = ''})
      : assert((floatingActionButton == null) ||
            (floatingActionButtonGenerator == null)),
        assert((floatingBottomBar == null) ||
            (floatingBottomBarGenerator == null)),
        this.floatingActionButton = floatingActionButton,
        this.floatingActionButtonGenerator = floatingActionButtonGenerator,
        this.floatingBottomBar = floatingBottomBar,
        this.floatingBottomBarGenerator = floatingBottomBarGenerator,
        this.isBottomBar =
            (floatingBottomBar != null) || (floatingBottomBarGenerator != null);

  @override
  _SafePaddingTemplateState createState() => new _SafePaddingTemplateState();
}

class _SafePaddingTemplateState extends State<SafePaddingTemplate> {
  ScrollController _scrollController; // set controller on scrolling
  bool isScrollingDown = false;

  @override
  void initState() {
    super.initState();
    this._scrollController = new ScrollController();
    this._scrollController.addListener(() {
      if (this._scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        setState(() {
          isScrollingDown = true;
        });
      } else {
        setState(() {
          isScrollingDown = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: widget.appBar,
        floatingActionButton: widget.floatingActionButton ??
            (widget.floatingActionButtonGenerator != null
                ? widget.floatingActionButtonGenerator(this.isScrollingDown)
                : SizedBox.shrink()),
        body: Stack(children: [
          widget.background ?? SizedBox.shrink(),
          SafeArea(
            child: GestureDetector(
                onTap: () {
                  FocusScopeNode currentFocus = FocusScope.of(context);
                  if (!currentFocus.hasPrimaryFocus &&
                      currentFocus.focusedChild != null)
                    FocusManager.instance.primaryFocus.unfocus();
                },
                child: Stack(children: [
                  SingleChildScrollView(
                      controller: this._scrollController,
                      padding: EdgeInsets.symmetric(
                          horizontal: AppTheme.horizontalPadding),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            widget.title.length > 0 ? this._topTitle() : null,
                            ...widget.children,
                            widget.isBottomBar ? SizedBox(height: 80) : null
                          ].where((elm) => elm != null).toList())),
                  Align(
                      alignment: Alignment.bottomCenter,
                      child: widget.floatingBottomBar ??
                          (widget.floatingBottomBarGenerator != null
                              ? widget.floatingBottomBarGenerator(
                                  this.isScrollingDown)
                              : SizedBox.shrink()))
                ])))]));
  }

  Widget _topTitle() {
    return Container(
        height: AppBar().preferredSize.height,
        alignment: Alignment.centerLeft,
        child: Text(widget.title,
            style: AppTheme.getFont(
                fontSize: AppTheme.fontSizes.large,
                color: AppTheme.colors.semiPrimary)));
  }

  @override
  void dispose() {
    this._scrollController.removeListener(() {});
    this._scrollController.dispose();
    super.dispose();
  }
}
