import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/widgets/inputs/input.dart';

class ListPicker extends StatelessWidget {
  final String hintText;
  final List<List> lists;
  final Function onChanged;
  final controller = TextEditingController();

  ListPicker({this.hintText, @required List list, this.onChanged})
      : assert(list != null && list.length > 0),
        this.lists = <List>[list];

  ListPicker.multiple({this.hintText, @required this.lists, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          this._showPicker(context);
        },
        child: Input(
          hintText: this.hintText,
          enabled: false,
          toNext: false,
          controller: this.controller,
          onPressIcon: () {
            this._showPicker(context);
          },
          icon: Icon(Icons.expand_more_rounded,
              color: AppTheme.colors.primary, size: 30),
        ));
  }

  void _showPicker(BuildContext context) {
    showCupertinoModalPopup(
        context: context,
        builder: (_) => Container(
            height: 250,
            color: AppTheme.colors.base,
            padding: const EdgeInsets.symmetric(horizontal: AppTheme.horizontalPadding),
            child: Row(children:
              this.lists.map((list) =>
              Expanded(
                  child: CupertinoPicker(
                itemExtent: 30,
                scrollController: FixedExtentScrollController(initialItem: -1),
                children: list.map((elm) => Text(elm.toString())).toList(),
                onSelectedItemChanged: (idx) {
                  // selected idx
                  if (this.onChanged != null) this.onChanged(idx);
                  this.controller.text = list[idx].toString();
                },
              ))).toList(), // Add other Lists
            )));
  }
}
