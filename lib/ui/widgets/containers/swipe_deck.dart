import 'package:flutter/material.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/widgets/cards/summary_card.dart';

class SwipeDeck extends StatefulWidget {
  final List<SummaryCard> cards;
  final int numCards;

  SwipeDeck({@required List<SummaryCard> children})
      : this.cards = children.reversed.toList(),
        numCards = children.length;

  @override
  _SwipeDeckState createState() => _SwipeDeckState();
}

class _SwipeDeckState extends State<SwipeDeck> {
  List<Widget> cardList;
  List<Widget> tempList = [];
  int curr = 0;

  @override
  void initState() {
    super.initState();
    this.cardList = this._getCards();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (BuildContext context) {
      return Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
              height: 205,
              alignment: Alignment.bottomCenter,
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                ...Iterable<int>.generate(widget.numCards).map((idx) => Padding(
                    padding: const EdgeInsets.only(left: 1, right: 1),
                    child: Icon(
                        this.curr == idx
                            ? Icons.circle
                            : Icons.radio_button_unchecked,
                        color: AppTheme.colors.support,
                        size: 9)))
              ])),
          ...Iterable<int>.generate(cardList.length).map((idx) => Container(
              margin: EdgeInsets.only(
                  top: 16.0 * (cardList.length - 1) - idx * 16.0),
              child: Transform.scale(
                  scale: 1 / (1 + 0.1 * (cardList.length - 1 - idx)),
                  child: cardList[idx])))
        ],
      );
    });
  }

  List<Widget> _getCards() {
    List<Widget> cardList = new List();
    for (int idx = 0; idx < 3; idx++) {
      cardList.add(
        Draggable(
            onDragEnd: (drag) {
              _removeCard(idx);
            },
            childWhenDragging: Container(),
            feedback: widget.cards[idx],
            child: widget.cards[idx]),
      );
    }
    return cardList;
  }

  void _removeCard(index) {
    setState(() {
      this.curr += 1;
      this.tempList.add(this.cardList.removeLast());
      if (this.cardList.isEmpty) {
        for (int _ = 0; _ < widget.numCards; _++)
          this.cardList.add(this.tempList.removeLast());
        this.curr = 0;
      }
    });
  }
}
