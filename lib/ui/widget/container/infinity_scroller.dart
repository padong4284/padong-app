import 'package:flutter/material.dart';
import 'package:padong/core/node/node.dart';
import 'package:padong/ui/widget/component/no_data_message.dart';

class InfinityScroller extends StatefulWidget {
  final Node node;
  final Node child;
  final Widget Function(Node) builder;
  final Widget Function(Node, Node, Node) seriesBuilder;
  final int itemPerPage;
  final String emptyMessage;
  final List<Widget> preWidgets;
  final ScrollController scrollController;
  final bool isReversed;
  final double endPadding;

  InfinityScroller(
    this.node,
    this.child, {
    this.builder,
    this.seriesBuilder,
    this.itemPerPage = 20,
    this.emptyMessage = 'Nothing to Show You',
    this.preWidgets,
    this.scrollController,
    this.isReversed = false,
    this.endPadding = 50,
  }): assert((builder != null) ^ (seriesBuilder != null));

  @override
  _InfinityScrollerState createState() => _InfinityScrollerState();
}

class _InfinityScrollerState extends State<InfinityScroller> {
  bool _hasMore = true;
  bool _isError = false;
  bool _isLoading = true;
  List<Node> _children = [];
  Node _lastChild;
  final int _nextPageFlag = 5;

  @override
  void initState() {
    super.initState();
    this.fetchChildren();
  }

  @override
  Widget build(BuildContext context) {
    if (this._children.isEmpty) {
      return ListView(
          reverse: widget.isReversed,
          children: [
            ...(widget.preWidgets ?? []),
            this._isLoading
                ? this._loadingArea()
                : (this._isError
                ? this._retryArea()
                : NoDataMessage(widget.emptyMessage, height: 100))
          ]);
    } else
      return ListView.builder(
          reverse: widget.isReversed,
          scrollDirection: Axis.vertical,
          controller: widget.scrollController,
          itemCount: 2 + this._children.length,
          itemBuilder: (context, index) {
            if (this._hasMore &&
                (index == this._children.length - this._nextPageFlag))
              this.fetchChildren();
            if (index == 0)
              return Column(children: [...(widget.preWidgets ?? [])]);
            else if (index == this._children.length + 1) {
              if (this._isError)
                return this._retryArea();
              else if (this._hasMore)
                return this._loadingArea();
              else
                return SizedBox(height: widget.endPadding);
            } // index is start from 1
            int len = this._children.length;
            return widget.seriesBuilder != null
                ? widget.seriesBuilder(this._children[index - 1],
                        index > 1 ? this._children[index - 2] : null,
                        index < len ? this._children[index] : null)
                : widget.builder(this._children[index - 1]);
          });
  }

  Widget _loadingArea() {
    return Center(
        child: Padding(
      padding: const EdgeInsets.all(15),
      child: CircularProgressIndicator(),
    ));
  }

  Widget _retryArea() {
    return Center(
        child: InkWell(
            onTap: () {
              this._isLoading = true;
              this.fetchChildren();
            },
            child: Padding(
                padding: const EdgeInsets.all(15),
                child: Text('Error while loading.\nTap to Retry'))));
  }

  Future<void> fetchChildren() async {
    try {
      List<Node> children = await widget.node.getChildren(widget.child,
          limit: widget.itemPerPage, startAt: this._lastChild, upToDate: true);
      if (mounted)
        setState(() {
          this._hasMore = children.length == widget.itemPerPage;
          this._isLoading = false;
          this._lastChild =
              children.isNotEmpty ? children[children.length - 1] : null;
          this._children.addAll(children);
        });
    } catch (e) {
      if (mounted)
        setState(() {
          this._isError = true;
          this._isLoading = false;
        });
    }
  }
}
