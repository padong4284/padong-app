import 'package:flutter/material.dart';
import 'package:padong/core/node/node.dart';

class InfinityScroller extends StatefulWidget {
  final Node node;
  final Node child;
  final Widget Function(Node) builder;
  final int itemPerPage;

  InfinityScroller(this.node, this.child, {
    @required this.builder, this.itemPerPage = 10});

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
    if (this._children.isEmpty){
      if(this._isLoading) return this._loadingArea();
      else if (this._isError) return this._retryArea();
    } else return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemCount: this._children.length + (this._hasMore ? 1: 0),
      itemBuilder: (context, index) {
        if (this._hasMore && (index == this._children.length - this._nextPageFlag))
          this.fetchChildren();
        if (index == this._children.length) {
          if (this._isError) return this._retryArea();
          else return this._loadingArea();
        }
        return widget.builder(this._children[index]);
      }
    );
    return Container();
  }

  Widget _loadingArea() {
    return Center(
        child: Padding(padding:  const EdgeInsets.all(15),
          child: CircularProgressIndicator(),)
    );
  }

  Widget _retryArea() {
    return Center(
        child: InkWell(onTap: () {
          this._isLoading = true;
          this.fetchChildren();
        },
            child: Padding(padding: const EdgeInsets.all(15),
                child: Text('Error while loading.\nTap to Retry'))
        )
    );
  }

  Future<void> fetchChildren() async {
    try {
      List<Node> children = await widget.node.getChildren(
          widget.child,
          limit: widget.itemPerPage,
          startAt: this._lastChild,
          upToDate: true);
      setState(() {
        this._hasMore = children.length == widget.itemPerPage;
        this._isLoading = false;
        this._lastChild = children[children.length - 1];
        this._children.addAll(children);
      });
    } catch (e) {
      setState(() {
        this._isError = true;
        this._isLoading = false;
      });
    }
  }
}