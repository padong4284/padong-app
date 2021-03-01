import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:padong/core/apis/profile.dart';
import 'package:padong/core/padong_router.dart';
import 'package:padong/ui/shared/types.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/views/templates/safe_padding_template.dart';
import 'package:padong/ui/widgets/bars/back_app_bar.dart';
import 'package:padong/ui/widgets/buttons/button.dart';
import 'package:padong/ui/widgets/buttons/user_profile_button.dart';
import 'package:padong/ui/widgets/dialogs/image_uploader.dart';
import 'package:padong/ui/widgets/inputs/input.dart';
import 'package:padong/ui/widgets/inputs/list_picker.dart';
import 'package:padong/core/apis/session.dart' as Session;

class ConfigureView extends StatefulWidget {
  _ConfigureViewState createState() => _ConfigureViewState();
}

class _ConfigureViewState extends State<ConfigureView> {
  bool isVerified;
  Map<String, dynamic> user;
  List<TextEditingController> _controllers;

  @override
  void initState() {
    super.initState();
    this.user = Session.user;
    this.isVerified = this.user['isVerified'];
    this._controllers = List.generate(6, (_) => TextEditingController());
    this._controllers[2].text = this.user['name'];
    this._controllers[3].text = this.user['universityName'];
    this._controllers[4].text = this.user['entranceYear'].toString();
    this._controllers[5].text = this.user['email'];
  }

  @override
  Widget build(BuildContext context) {
    return SafePaddingTemplate(
        appBar: BackAppBar(
          isClose: true,
          actions: [
            Button(
                title: 'Ok',
                buttonSize: ButtonSize.SMALL,
                borderColor: AppTheme.colors.primary,
                callback: this.onTabOk,
                shadow: false),
          ],
        ),
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.end, children: [
            SizedBox(
                width: 32,
                height: 20,
                child: IconButton(
                    padding: const EdgeInsets.all(0),
                    onPressed: () {}, // TODO: more dialog
                    icon: Icon(Icons.more_horiz_rounded,
                        color: AppTheme.colors.support))),
          ]),
          Container(
              margin: const EdgeInsets.only(top: 10, left: 5, bottom: 20),
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
              this.lockedInput(this.user['username']),
              Input(
                  controller: this._controllers[0],
                  margin: EdgeInsets.only(top: 10.0),
                  hintText: 'Password'),
              Input(
                  controller: this._controllers[1],
                  margin: EdgeInsets.only(top: 10.0),
                  hintText: 'Repeat Password'),
              // TODO: check match feedback real-time
              Input(
                  controller: this._controllers[2],
                  margin: EdgeInsets.only(top: 20.0 + paddingBottom),
                  hintText: 'Name'),
              this.isVerified
                  ? this.lockedInput(this.user['universityName'])
                  : ListPicker(this._controllers[3],
                      margin: EdgeInsets.only(top: 10.0),
                      hintText: 'University',
                      list: ['Georgia Tech']),
              // TODO: get univ list
              ListPicker(
                this._controllers[4],
                margin: EdgeInsets.only(top: 10.0),
                hintText: 'Entrance Year',
                list: List.generate(10, (y) => 2021 - y),
              ),
              this.isVerified
                  ? this.lockedInput(this.user['email'])
                  : Input(
                      controller: this._controllers[5],
                      margin: EdgeInsets.only(top: 10.0),
                      hintText: 'Email'),
              this.verifyButton(),
              Container(
                  width: 150,
                  margin: const EdgeInsets.only(top: 30),
                  child: Button(
                      title: 'Sign Out',
                      shadow: false,
                      callback: signOutAPI,
                      buttonSize: ButtonSize.REGULAR,
                      borderColor: AppTheme.colors.pointRed))
            ])));
  }

  Widget verifyButton() {
    return Container(
        height: 38,
        alignment: Alignment.center,
        margin: const EdgeInsets.only(top: 10),
        decoration: BoxDecoration(
            color: this.isVerified
                ? AppTheme.colors.primary
                : AppTheme.colors.pointYellow,
            borderRadius: const BorderRadius.all(Radius.circular(13.0))),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          this.isVerified
              ? Padding(
                  padding: const EdgeInsets.only(right: 5),
                  child: Icon(Icons.verified_rounded,
                      size: 22, color: AppTheme.colors.base))
              : SizedBox.shrink(),
          Text(this.isVerified ? 'Verified' : 'Verify',
              style: AppTheme.getFont(
                  color: AppTheme.colors.base,
                  fontSize: AppTheme.fontSizes.mlarge)),
          SizedBox(width: this.isVerified ? 20 : 0)
        ]));
  }

  Widget lockedInput(String text) {
    return Container(
        height: 38,
        alignment: Alignment.centerLeft,
        margin: const EdgeInsets.only(top: 10),
        padding: const EdgeInsets.only(left: 28, right: 15),
        decoration: BoxDecoration(
            color: AppTheme.colors.base,
            borderRadius: const BorderRadius.all(Radius.circular(13.0)),
            boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)]),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(text,
              style: AppTheme.getFont(
                  color: AppTheme.colors.primary,
                  fontSize: AppTheme.fontSizes.mlarge)),
          Icon(Icons.lock_rounded, color: AppTheme.colors.primary, size: 20)
        ]));
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

  void onTabOk() {
    Map<String, dynamic> data = {};
    if (this._controllers[0].text == this._controllers[1].text &&
        this._controllers[0].text.length > 0)
      updatePasswordAPI(this._controllers[0].text);

    String name = this._controllers[2].text;
    String year = this._controllers[4].text;
    data['name'] = name.length > 0 ? name : this.user['name'];
    data['entranceYear'] = year.length > 0 ? year : this.user['entranceYear'];
    if (!this.isVerified) {
      String univ = this._controllers[3].text;
      String email = this._controllers[5].text;
      // TODO: update univId
      data['universityName'] =
          univ.length > 0 ? univ : this.user['universityName'];
      data['email'] = email.length > 0 ? email : this.user['email'];
    }
    updateProfileAPI(data);
    PadongRouter.goBack();
  }
}
