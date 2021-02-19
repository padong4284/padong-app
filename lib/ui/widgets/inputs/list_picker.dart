import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/widgets/inputs/input.dart';

class ListPicker extends StatefulWidget {
  final String hintText;
  final List<List> lists;
  final void Function(int, int) onChanged; // listIdx, idx
  final List<String> titles;
  final List<int> initIdxs;
  final EdgeInsets margin;
  final controller = TextEditingController();

  ListPicker(
      {this.hintText,
      @required List list,
      this.onChanged,
      String title,
      int initIdx,
      this.margin})
      : assert(list != null && list.length > 0),
        assert(initIdx == null || list.length > initIdx),
        this.lists = <List>[list],
        this.initIdxs = initIdx != null ? [initIdx] : null,
        this.titles = [title];

  ListPicker.multiple(
      {this.hintText,
      @required List<List> lists,
      this.onChanged,
      List<String> titles,
      List<int> initIdxs,
      this.margin})
      : assert(initIdxs == null || (lists.length == initIdxs.length)),
        this.lists = lists,
        this.initIdxs = initIdxs,
        this.titles = titles ?? [];

  @override
  _ListPickerState createState() => new _ListPickerState();
}

class _ListPickerState extends State<ListPicker> {
  List selectedIdxs;

  @override
  void initState() {
    super.initState();
    this.selectedIdxs = widget.initIdxs ??
        Iterable<int>.generate(widget.lists.length).map((_) => 0).toList();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          this._showPicker(context);
        },
        child: Input(
          hintText: widget.hintText,
          enabled: false,
          toNext: false,
          margin: widget.margin,
          controller: widget.controller,
          onPressIcon: () {
            this._showPicker(context);
          },
          icon: Icon(Icons.expand_more_rounded,
              color: AppTheme.colors.primary, size: 30),
        ));
  }

  void _showPicker(BuildContext context) {
    int len = widget.lists.length;
    this.setText(0, this.selectedIdxs[0]);
    showCupertinoModalPopup(
        context: context,
        builder: (_) => Stack(children: [
              Container(
                  height: 250,
                  color: AppTheme.colors.base,
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppTheme.horizontalPadding),
                  child: Row(
                    children: Iterable<int>.generate(len)
                        .map((listIdx) => Expanded(
                                child: CupertinoPicker(
                              itemExtent: 35,
                              scrollController: FixedExtentScrollController(
                                  initialItem: widget.initIdxs != null
                                      ? widget.initIdxs[listIdx]
                                      : -1),
                              children: widget.lists[listIdx]
                                  .map((elm) =>
                                      Center(child: Text(elm.toString())))
                                  .toList(),
                              onSelectedItemChanged: (idx) {
                                // selected idx
                                if (widget.onChanged != null)
                                  widget.onChanged(listIdx, idx);
                                this.setText(listIdx, idx);
                              },
                            )))
                        .toList(), // Add other Lists
                  )),
              this.titleArea()
            ]));
  }

  Widget titleArea() {
    return Container(
        height: 50,
        color: AppTheme.colors.base,
        padding: const EdgeInsets.only(
            top: 15,
            left: AppTheme.horizontalPadding,
            right: AppTheme.horizontalPadding),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: widget.titles
                .where((title) => title != null)
                .map((title) => Text(
                      title,
                      style: AppTheme.getFont(
                          color: AppTheme.colors.primary,
                          fontSize: AppTheme.fontSizes.large),
                    ))
                .toList()));
  }

  void setText(int listIdx, int idx) {
    int len = this.selectedIdxs.length;
    setState(() {
      this.selectedIdxs[listIdx] = idx;
      String current = '';
      for (int i = 0; i < len; i++)
        current += widget.lists[i][this.selectedIdxs[i]].toString() + ' ';
      widget.controller.text = current;
    });
  }
}
