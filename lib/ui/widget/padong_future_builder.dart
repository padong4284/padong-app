import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:padong/ui/theme/app_theme.dart';

class PadongFutureBuilder extends StatelessWidget {
  final Future<dynamic> future;
  final Widget Function(dynamic data) builder;
  final double height;
  final double size;

  PadongFutureBuilder(
      {@required this.future,
      @required this.builder,
      this.size = 30,
      this.height});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: this.future,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return Container(
                height: this.height,
                alignment: Alignment.center,
                child: SizedBox(
                    width: this.size,
                    height: this.size,
                    child: CircularProgressIndicator()));
          } else if (snapshot.hasError) {
            return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('ERROR: ${snapshot.error}',
                    style: AppTheme.getFont(color: AppTheme.colors.pointRed)));
          } else
            return this.builder(snapshot.data);
        });
  }
}
