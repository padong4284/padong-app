import 'package:flutter/material.dart';
import 'package:padong/ui/theme/app_theme.dart';

class AppendsController {
  List<TextEditingController> ctrls;
  List get list => Set.from(this.ctrls.map((ctrl) => ctrl.text))
      .where((elm) => elm.length > 0)
      .toList();

  AppendsController() : this.ctrls = [];

  void init() => this.ctrls = [];
  void add(TextEditingController ctrl) => this.ctrls.add(ctrl);
  void removeAt(int idx) => this.ctrls.removeAt(idx);
}

// only last one is + else x
class AppendingInput extends StatefulWidget {
  final AppendsController controller;
  final Widget Function(TextEditingController ctrl) input;

  AppendingInput(this.controller, {@required this.input});

  @override
  _AppendingInputState createState() => _AppendingInputState();
}

class _AppendingInputState extends State<AppendingInput> {
  List<Widget> inputs = [];

  @override
  void initState() {
    super.initState();
    widget.controller.init();
    TextEditingController ctrl = TextEditingController();
    this.inputs.add(widget.input(ctrl));
    widget.controller.add(ctrl);
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
          if (this.inputs.length - 1 == idx) {
            TextEditingController ctrl = TextEditingController();
            widget.controller.add(ctrl);
            this.inputs.add(widget.input(ctrl));
          } else {
            this.inputs.removeAt(idx);
            widget.controller.removeAt(idx);
          }
        });
  }
}
