import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:padong/ui/theme/app_theme.dart';

class PadongFutureBuilder extends StatelessWidget {
  final Future<dynamic> future;
  final Widget Function(dynamic data) builder;
  final double size;

  PadongFutureBuilder(
      {@required this.future, @required this.builder, this.size = 30});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: this.future,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData == false) {
            return Center(
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
