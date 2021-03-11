import 'package:flutter/material.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/utils/time_manager.dart';
import 'package:padong/ui/widgets/buttons/more_button.dart';

class VerticalTimeline extends StatefulWidget {
  final String date; // TODO: DateTime class
  final List<String> dots;
  final List<List<Widget>> cards;
  final bool hideTopDate;
  final bool expandable;

  VerticalTimeline(
      {this.date,
      @required List<String> dots,
      @required List<List<Widget>> cards,
      this.hideTopDate = false,
      this.expandable = false})
      : assert(dots.length == cards.length),
        this.dots = dots,
        this.cards = cards;

  _VerticalTimelineState createState() => _VerticalTimelineState();
}

class _VerticalTimelineState extends State<VerticalTimeline> {
  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    int len = (widget.expandable && !this.expanded) ? 3 : widget.dots.length;
    return Stack(children: [
      Positioned.fill(
          top: widget.hideTopDate ? 15 : 35,
          left: 4,
          right: MediaQuery.of(context).size.width -
              2 * (AppTheme.horizontalPadding + 4),
          child: SizedBox(
              width: 2, child: Container(color: AppTheme.colors.lightSupport))),
      Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Column(children: [
            widget.hideTopDate ? SizedBox.shrink() : this.getTopDate(),
            ...List.generate(
                len,
                (idx) => Column(children: [
                      this.getDotTime(widget.dots[idx]),
                      Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: Column(children: widget.cards[idx]))
                    ]))
          ])),
      widget.expandable
          ? Positioned(
              right: 0,
              child: MoreButton('',
                  expanded: this.expanded,
                  expandFunction: () => setState(() {
                        this.expanded = !this.expanded;
                      })))
          : SizedBox.shrink()
    ]);
  }

  Widget getTopDate() {
    bool isToday = TimeManager.todayString() == widget.date;
    return Row(children: [
      Text(
        isToday ? 'Today ' : widget.date,
        style: AppTheme.getFont(
            color: AppTheme.colors.support,
            fontSize: AppTheme.fontSizes.mlarge,
            isBold: true),
      ),
      isToday
          ? Text(widget.date,
              style: AppTheme.getFont(color: AppTheme.colors.semiSupport))
          : SizedBox.shrink()
    ]);
  }

  Widget getDotTime(String dotTime) {
    return Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Container(
                  width: 12, height: 12, color: AppTheme.colors.primary),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, bottom: 2),
              child: Text(dotTime,
                  style: AppTheme.getFont(color: AppTheme.colors.semiSupport)),
            )
          ],
        ));
  }
}
