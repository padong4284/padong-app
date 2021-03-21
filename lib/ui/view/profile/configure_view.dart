///*********************************************************************
///* Copyright (C) 2021-2021 Taejun Jang <padong4284@gmail.com>
///* All Rights Reserved.
///* This file is part of PADONG.
///*
///* PADONG can not be copied and/or distributed without the express
///* permission of Taejun Jang, Daewoong Ko, Hyunsik Kim, Seongbin Hong
///*
///* Github [https://github.com/padong4284]
///*********************************************************************
import 'package:flutter/material.dart';
import 'package:padong/core/node/common/university.dart';
import 'package:padong/core/node/common/user.dart';
import 'package:padong/core/padong_router.dart';
import 'package:padong/core/service/session.dart';
import 'package:padong/ui/shared/types.dart';
import 'package:padong/ui/template/safe_padding_template.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/widget/bar/back_app_bar.dart';
import 'package:padong/ui/widget/button/button.dart';
import 'package:padong/ui/widget/button/profile_button.dart';
import 'package:padong/ui/widget/dialog/image_uploader.dart';
import 'package:padong/ui/widget/input/input.dart';
import 'package:padong/ui/widget/input/list_picker.dart';

class ConfigureView extends StatefulWidget {
  _ConfigureViewState createState() => _ConfigureViewState();
}

class _ConfigureViewState extends State<ConfigureView> {
  bool isVerified;
  User user;
  String _pwMatchError;
  List<TextEditingController> _controllers;

  @override
  void initState() {
    super.initState();
    this.user = Session.user;
    this.isVerified = this.user.isVerified;
    this._controllers = List.generate(6, (_) => TextEditingController());
    this._controllers[2].text = this.user.name;
    this._controllers[3].text = this.user.university;
    this._controllers[4].text = this.user.entranceYear.toString();
    this._controllers[5].text = this.user.userEmails[0];
  }

  @override
  Widget build(BuildContext context) {
    return SafePaddingTemplate(
        appBar: BackAppBar(
          isClose: true,
          actions: [
            Button('Ok',
                buttonSize: ButtonSize.SMALL,
                borderColor: AppTheme.colors.primary,
                onTap: this.onTabOk,
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
                ProfileButton(Session.user, size: 80, isBold: true),
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
              this.lockedInput(this.user.userId),
              Input(
                  isPrivacy: true,
                  controller: this._controllers[0],
                  margin: EdgeInsets.only(top: 10.0),
                  labelText: 'Password',
                  onChanged: (_) => setState(() {
                        this._controllers[1].text = '';
                        this._pwMatchError = null;
                      })),
              Input(
                  isPrivacy: true,
                  controller: this._controllers[1],
                  margin: EdgeInsets.only(top: 10.0),
                  labelText: 'Repeat Password',
                  errorText: this._pwMatchError,
                  onChanged: (repeat) => setState(() => this._pwMatchError =
                      repeat != this._controllers[0].text
                          ? "Repeat Password doesn't match"
                          : null)),
              // TODO: check match feedback real-time
              Input(
                  controller: this._controllers[2],
                  margin: EdgeInsets.only(top: 20.0 + paddingBottom),
                  labelText: 'Name'),
              this.isVerified
                  ? this.lockedInput(this.user.university)
                  : ListPicker(this._controllers[3],
                      margin: EdgeInsets.only(top: 10.0),
                      labelText: 'University',
                      list: ['Georgia Tech']),
              // TODO: get univ list
              ListPicker(
                this._controllers[4],
                margin: EdgeInsets.only(top: 10.0),
                labelText: 'Entrance Year',
                list: List.generate(10, (y) => 2021 - y),
              ),
              this.isVerified
                  ? this.lockedInput(this.user.userEmails[0])
                  : Input(
                      controller: this._controllers[5],
                      margin: EdgeInsets.only(top: 10.0),
                      labelText: 'Email'),
              this.verifyButton(),
              Container(
                  width: 150,
                  margin: const EdgeInsets.only(top: 30),
                  child: Button('Sign Out',
                      shadow: false,
                      onTap: () => Session.signOutUser(context),
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
          Text(this.isVerified ? 'Verified' : 'Please Verify Email',
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
    return ImageUploader.getImageFromUser(context, (String image) {
      setState(() {
        this.user.profileImageURL = image;
        this.user.update();
      });
    });
  }

  void onTabOk() async {
    if (this._controllers[0].text == this._controllers[1].text &&
        this._controllers[0].text.length > 0)
      Session.updateUserPassword(this._controllers[0].text);

    bool isUpdated = false;
    bool univUpdated = false;
    University university;
    String name = this._controllers[2].text;
    int year = int.tryParse(this._controllers[4].text);
    if (name.isNotEmpty && name != this.user.name) {
      this.user.name = name;
      isUpdated = true;
    }
    if (year != null && year != this.user.entranceYear) {
      this.user.entranceYear = year;
      isUpdated = true;
    }
    if (!this.isVerified) {
      String univName = this._controllers[3].text;
      String email = this._controllers[5].text;

      if (univName.isNotEmpty && univName != this.user.university) {
        university = await University.getUniversityByName(univName);
        if (university != null) {
          this.user.parentId = university.id;
          this.user.university = univName;
          univUpdated = true;
        }
      }
      if (email.isNotEmpty && !this.user.userEmails.contains(email)) {
        await Session.changeUserEmail(email, context);
        isUpdated = false; // user.update() is already called
      }
    }
    if (isUpdated || univUpdated) await this.user.update();
    if (univUpdated) {
      Session.userUniversity = university;
      Session.changeCurrentUniversity(university);
    }
    else
      PadongRouter.goBack();
  }
}
