import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:padong/ui/shared/types.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/views/templates/safe_padding_template.dart';
import 'package:padong/ui/widgets/bars/back_app_bar.dart';
import 'package:padong/ui/widgets/buttons/button.dart';
import 'package:padong/ui/widgets/buttons/user_profile_button.dart';
import 'package:padong/core/apis/session.dart' as Session;
import 'package:padong/ui/widgets/dialogs/image_uploader.dart';
import 'package:padong/ui/widgets/inputs/input.dart';
import 'package:padong/ui/widgets/inputs/list_picker.dart';

class ConfigureView extends StatefulWidget {
  _ConfigureViewState createState() => _ConfigureViewState();
}

class _ConfigureViewState extends State<ConfigureView> {
  Map<String, dynamic> user;
  TextEditingController _univController = TextEditingController();
  TextEditingController _yearController = TextEditingController();

  @override
  void initState() {
    super.initState();
    this.user = Session.user;
  }

  @override
  Widget build(BuildContext context) {
    return SafePaddingTemplate(
        appBar: BackAppBar(
          isClose: true,
          actions: [
            SizedBox(
                width: 32,
                child: IconButton(
                    onPressed: () {}, // TODO: more dialog
                    icon: Icon(Icons.more_horiz_rounded,
                        color: AppTheme.colors.support)))
          ],
        ),
        children: [
          Container(
              margin: const EdgeInsets.only(top: 30, left: 5, bottom: 20),
              alignment: Alignment.center,
              child: Stack(children: [
                UserProfileButton(Session.user['id'], size: 80, isBold: true),
                Container(
                    margin: const EdgeInsets.only(left: 50, top: 50),
                    width: 35,
                    height: 35,
                    decoration: BoxDecoration(
                        color: AppTheme.colors.primary,
                        borderRadius: BorderRadius.circular(17.5)),
                    child: IconButton(
                        icon: Icon(Icons.edit_rounded,
                            size: 20, color: AppTheme.colors.base),
                        onPressed: this.addPhotoFunction(context)))
              ])),
          this.configures(context),
        ]);
  }

  Widget configures(BuildContext context) {
    double paddingBottom = MediaQuery.of(context).padding.bottom;
    return Container(
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width,
        child: Container(
            width: MediaQuery.of(context).size.width -
                2 * (AppTheme.horizontalPadding + 30),
            child: Column(children: [
              Input(margin: EdgeInsets.only(top: 10.0), hintText: 'ID'),
              Input(margin: EdgeInsets.only(top: 10.0), hintText: 'Password'),
              Input(
                  margin: EdgeInsets.only(top: 10.0),
                  hintText: 'Repeat Password'),
              Input(
                  margin: EdgeInsets.only(top: 20.0 + paddingBottom),
                  hintText: 'Name'),
              ListPicker(this._univController,
                  margin: EdgeInsets.only(top: 10.0),
                  hintText: 'University',
                  list: ['Georgia Tech']),
              ListPicker(
                this._yearController,
                margin: EdgeInsets.only(top: 10.0),
                hintText: 'Entrance Year',
                list: List.generate(10, (y) => 2021 - y),
              ),
              Input(margin: EdgeInsets.only(top: 10.0), hintText: 'Email'),
              Container(
                  height: 40,
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(top: 10),
                  decoration: BoxDecoration(
                      color: AppTheme.colors.primary,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(13.0))),
                  child: Text('Verified',
                      style: AppTheme.getFont(
                          color: AppTheme.colors.base,
                          fontSize: AppTheme.fontSizes.mlarge))),
              Container(
                  width: 150,
                  margin: const EdgeInsets.only(top: 30),
                  child: Button(
                      title: 'Sign Out',
                      shadow: false,
                      buttonSize: ButtonSize.REGULAR,
                      borderColor: AppTheme.colors.pointRed))
            ])));
  }

  Function addPhotoFunction(context) {
    return getImageFromUser(context, (PickedFile image) {
      setState(() {
        this.user['profileImgURL'] = image.path;
        // https://github.com/ptyagicodecamp/flutter_cookbook/blob/widgets/flutter_widgets/lib/images/upload_image.dart
        // TODO: upload to firebase
      });
    });
  }
}
