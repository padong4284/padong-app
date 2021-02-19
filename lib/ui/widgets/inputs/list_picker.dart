import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/widgets/inputs/input.dart';

class ListPicker extends StatelessWidget {
  final String hintText;
  final List<List> lists;
  final Function onChanged;
  final List<String> titles;
  final EdgeInsets margin;
  final controller = TextEditingController();

  ListPicker(
      {this.hintText,
      @required List list,
      this.onChanged,
      String title,
      this.margin})
      : assert(list != null && list.length > 0),
        this.lists = <List>[list],
        this.titles = [title];

  ListPicker.multiple(
      {this.hintText,
      @required this.lists,
      this.onChanged,
      this.titles,
      this.margin});

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
          margin: this.margin,
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
        builder: (_) => Stack(children: [
              Container(
                  height: 250,
                  color: AppTheme.colors.base,
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppTheme.horizontalPadding),
                  child: Row(
                    children: this
                        .lists
                        .map((list) => Expanded(
                                child: CupertinoPicker(
                              itemExtent: 35,
                              scrollController:
                                  FixedExtentScrollController(initialItem: -1),
                              children: list
                                  .map((elm) => Center(
                                      child: Text(elm.toString())))
                                  .toList(),
                              onSelectedItemChanged: (idx) {
                                // selected idx
                                if (this.onChanged != null) this.onChanged(idx);
                                this.controller.text = list[idx].toString();
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
            children: this
                .titles
                .where((title) => title != null)
                .map((title) => Text(
                      title,
                      style: AppTheme.getFont(
                          color: AppTheme.colors.primary,
                          fontSize: AppTheme.fontSizes.large),
                    ))
                .toList()));
  }
}
