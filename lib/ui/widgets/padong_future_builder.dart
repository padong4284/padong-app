import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:padong/ui/theme/app_theme.dart';

class PadongFutureBuilder extends StatelessWidget {
  final Future<dynamic> future;
  final Widget Function(dynamic data) builder;

  PadongFutureBuilder({@required this.future, @required this.builder});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: (() async => await this.future)(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData == false) {
            return Center(child:CircularProgressIndicator());
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
