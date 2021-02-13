import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../shared/types.dart';
import 'transp_button.dart';

class PostCard extends StatelessWidget {
  final String _id; // node's _id
  final String title;
  final String description;

  PostCard(id, {this.title, this.description}) : this._id = id;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 140,
        height: 220,
        margin: const EdgeInsets.all(7),
<<<<<<< HEAD
        child: InkWell(
            onTap: () {}, // TODO: Routing to Post
            child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                elevation: 3.0,
                child: Column(children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                        color: AppTheme.colors.lightSupport,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(5),
                            topRight: Radius.circular(5))),
                    width: 140,
                    height: 130,
                  ),
                  Container(
                      alignment: Alignment.centerLeft,
                      margin: const EdgeInsets.only(
                          top: 10.0, left: 10.0, right: 10.0),
                      child: Text('Title', // TODO: this.title
                          style: TextStyle(
                              height: 1.25,
                              color: AppTheme.colors.fontPalette[2],
                              letterSpacing: 0.025,
                              fontWeight: FontWeight.bold,
                              fontSize: AppTheme.fontSizes.regular))),
                  Container(
                      alignment: Alignment.centerLeft,
                      margin: const EdgeInsets.only(left: 10.0, right: 10.0),
                      child: Text('Summary', // TODO: this.description2summary
                          style: TextStyle(
                              height: 1.25,
                              color: AppTheme.colors.fontPalette[3],
                              letterSpacing: 0.025,
                              fontSize: AppTheme.fontSizes.regular))),
                  Container(
                      width: 140,
                      padding: const EdgeInsets.only(top: 7),
                      child: Stack(
                        children: [
                          Container(
                              margin: const EdgeInsets.only(left: 10),
                              child: TranspButton(
                                  title: '0',
                                  buttonSize: ButtonSize.REGULAR,
                                  color: AppTheme.colors.support,
                                  icon: Icon(
                                    Icons.favorite_border_rounded,
                                    size: 16.0,
                                  ))),
                          Container(
                              margin: const EdgeInsets.only(left: 55),
                              child: TranspButton(
                                  title: '0',
                                  buttonSize: ButtonSize.REGULAR,
                                  color: AppTheme.colors.support,
                                  icon: Icon(
                                    Icons.bookmark_border_rounded,
                                    size: 16.0,
                                  )))
                        ],
                      ))
                ]))));
=======
        child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
            elevation: 3.0,
            child: Column(children: <Widget>[
              Container(
                decoration: BoxDecoration(
                    color: AppTheme.colors.lightSupport,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(5),
                        topRight: Radius.circular(5))),
                width: 140,
                height: 130,
              ),
              Container(
                  alignment: Alignment.centerLeft,
                  margin:
                      const EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
                  child: Text('Title', // TODO: this.title
                      style: TextStyle(
                          height: 1.25,
                          color: AppTheme.colors.fontPalette[2],
                          letterSpacing: 0.025,
                          fontWeight: FontWeight.bold,
                          fontSize: AppTheme.fontSizes.regular))),
              Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.only(left: 10.0, right: 10.0),
                  child: Text('Summary', // TODO: this.description2summary
                      style: TextStyle(
                          height: 1.25,
                          color: AppTheme.colors.fontPalette[3],
                          letterSpacing: 0.025,
                          fontSize: AppTheme.fontSizes.regular))),
              Container(
                width: 140,
                  padding: const EdgeInsets.only(top: 7),
                  child: Stack(
                    children: [
                      Container(
                          margin: const EdgeInsets.only(left: 10),
                          child: TranspButton(
                              title: '0',
                              buttonSize: ButtonSize.REGULAR,
                              color: AppTheme.colors.support,
                              icon: Icon(
                                Icons.favorite_border_rounded,
                                size: 16.0,
                              ))),
                      Container(
                          margin: const EdgeInsets.only(left: 55),
                          child: TranspButton(
                              title: '0',
                              buttonSize: ButtonSize.REGULAR,
                              color: AppTheme.colors.support,
                              icon: Icon(
                                Icons.bookmark_border_rounded,
                                size: 16.0,
                              )))
                    ],
                  ))
            ])));
>>>>>>> feat: PostCard implementing
  }
}
