import 'package:flutter/material.dart';
import 'package:padong/ui/widgets/summary_card.dart';

class SwipeDeck extends StatefulWidget {
  List<SummaryCard> cards;

  SwipeDeck({@required List<SummaryCard> cards})
      : this.cards = cards.reversed.toList();

  @override
  _SwipeDeckState createState() => _SwipeDeckState();
}

class _SwipeDeckState extends State<SwipeDeck> {
  List<Widget> cardList;
  List<Widget> tempList = [];

  @override
  void initState() {
    super.initState();
    cardList = this._getCards();
    tempList = [];
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (BuildContext context) {
      return Stack(
        alignment: Alignment.topCenter,
        children: [
          SizedBox(height: 200),
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
      tempList.add(cardList.removeLast());
      if (cardList.isEmpty) {
        int len = tempList.length;
        for (int _ = 0; _ < len; _++) cardList.add(tempList.removeLast());
      }
    });
  }
}
