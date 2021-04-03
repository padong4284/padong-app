import 'package:flutter/material.dart';
import 'package:padong/core/node/node.dart';
import 'package:padong/ui/widget/component/no_data_message.dart';

class InfinityScroller extends StatefulWidget {
  final Node node;
  final Node child;
  final Widget Function(Node) builder;
  final int itemPerPage;
  final String emptyMessage;
  final List<Widget> preWidgets;

  InfinityScroller(this.node, this.child, {
    @required this.builder,
    this.itemPerPage = 20,
    this.emptyMessage = 'Nothing to Show You',
    this.preWidgets,
  });

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
      return Column(children: [
        ...(widget.preWidgets ?? []),
        this._isLoading ? this._loadingArea()
            : (this._isError ? this._retryArea()
              : NoDataMessage(widget.emptyMessage, height: 100))
      ]);
    } else return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: (widget.preWidgets != null ? 1 : 0)
          + this._children.length + (this._hasMore ? 1: 0),
      itemBuilder: (context, index) {
        if (this._hasMore && (index == this._children.length - this._nextPageFlag))
          this.fetchChildren();
        if (widget.preWidgets != null && index == 0)
          return Column(children: [...widget.preWidgets]);
        else if (index == this._children.length) {
          if (this._isError) return this._retryArea();
          else if(this._hasMore) return this._loadingArea();
          else return SizedBox(height: 50);
        }
        return widget.builder(this._children[index]);
      }
    );
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
    print('fetch ${this._children.length}');
    try {
      List<Node> children = await widget.node.getChildren(
          widget.child,
          limit: widget.itemPerPage,
          startAt: this._lastChild,
          upToDate: true);
      if(mounted) setState(() {
        this._hasMore = children.length == widget.itemPerPage;
        this._isLoading = false;
        this._lastChild = children.isNotEmpty
                            ? children[children.length - 1]
                            : null;
        this._children.addAll(children);
      });
    } catch (e) {
      if(mounted) setState(() {
        this._isError = true;
        this._isLoading = false;
      });
    }
  }
}