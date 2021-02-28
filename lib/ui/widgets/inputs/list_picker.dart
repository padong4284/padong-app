import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/widgets/inputs/input.dart';

class ListPicker extends StatefulWidget {
  final String hintText;
  final bool looping;
  final List<List> lists;
  final List<int> initIdxs;
  final List<String> separators;
  final List<String> titles;
  final EdgeInsets margin;
  final Function beforePick;
  final controller = TextEditingController();

  ListPicker(
      {this.hintText,
      @required List list,
      String title,
      int initIdx,
      this.beforePick,
      this.looping = false,
      this.margin})
      : assert(list != null && list.length > 0),
        assert(initIdx == null || list.length > initIdx),
        this.lists = <List>[list],
        this.initIdxs = initIdx != null ? [initIdx] : null,
        this.separators = null,
        this.titles = [title];

  ListPicker.multiple(
      {this.hintText,
      @required List<List> lists,
      List<String> separators,
      List<String> titles,
      List<int> initIdxs,
      this.beforePick,
      this.looping = false,
      this.margin})
      : assert(initIdxs == null || (lists.length == initIdxs.length)),
        assert(separators == null || (lists.length == separators.length + 1)),
        this.lists = lists,
        this.initIdxs = initIdxs,
        this.separators = separators,
        this.titles = titles ?? [];

  @override
  _ListPickerState createState() => new _ListPickerState();
}

class _ListPickerState extends State<ListPicker> {
  List selectedIdxs;
  String beforePickInfo = '';

  @override
  void initState() {
    super.initState();
    this.beforePickInfo = '';
    this.selectedIdxs =
        widget.initIdxs ?? List.generate(widget.lists.length, (_) => 0);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          this.showPicker(context);
        },
        child: Input(
          hintText: widget.hintText,
          enabled: false,
          toNext: false,
          margin: widget.margin,
          controller: widget.controller,
          onPressIcon: () {
            this.showPicker(context);
          },
          icon: Icon(Icons.expand_more_rounded,
              color: AppTheme.colors.primary, size: 30),
        ));
  }

  void showPicker(BuildContext context) async {
    int len = widget.lists.length;
    if (widget.beforePick != null)
      await widget.beforePick(
          context,
          (info) => setState(() {
                this.beforePickInfo = info;
              }));
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
                    children: List.generate(
                        len,
                        (listIdx) => Expanded(
                                child: CupertinoPicker(
                              looping: widget.looping,
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
                                this.setText(listIdx, idx);
                              },
                            ))), // Add other Lists
                  )),
              this.titleArea()
            ]));
  }

  Widget titleArea() {
    return Container(
        height: 50,
        color: AppTheme.colors.base,
        padding: const EdgeInsets.only(
            top: 10,
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
      String current = this.beforePickInfo;
      if (current.length > 0) current += ' | ';
      for (int i = 0; i < len; i++)
        current += widget.lists[i][this.selectedIdxs[i]].toString() +
            (i != len - 1
                ? (widget.separators != null ? widget.separators[i] : ' ')
                : '');
      widget.controller.text = current;
    });
  }
}
