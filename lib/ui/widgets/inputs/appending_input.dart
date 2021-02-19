import 'package:flutter/material.dart';
import 'package:padong/ui/theme/app_theme.dart';

// only last one is + else x
class AppendingInput extends StatefulWidget {
  final Widget Function() input;

  AppendingInput({@required this.input});

  @override
  _AppendingInputState createState() => _AppendingInputState();
}

class _AppendingInputState extends State<AppendingInput> {
  List<Widget> inputs = [];

  @override
  void initState() {
    super.initState();
    this.inputs.add(widget.input());
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width -
        2 * (AppTheme.horizontalPadding + 30);
    return Column(
        children:
            this.inputs.map((input) => this.getLine(width, input)).toList());
  }

  Widget getLine(double width, Widget input) {
    int idx = this.inputs.indexOf(input);
    return new Row(children: [
      Container(width: width, child: input),
      Container(
          margin: const EdgeInsets.only(left: 10),
          child: IconButton(
            iconSize: 30,
            icon: Icon(
                this.inputs.length - 1 == idx
                    ? Icons.add_rounded
                    : Icons.remove_rounded,
                color: AppTheme.colors.primary),
            onPressed: this.reLine(idx),
          ))
    ]);
  }

  Function reLine(int idx) {
    return () => this.setState(() {
          if (this.inputs.length - 1 == idx)
            this.inputs.add(widget.input());
          else
            this.inputs.removeAt(idx);
        });
  }
}
