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
import 'dart:io';
import 'dart:async';
import 'package:crypto/crypto.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:padong/ui/shared/types.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/widget/button/button.dart';
import 'package:padong/ui/widget/button/switch_button.dart';

final ImagePicker _picker = ImagePicker();

class ImageUploader extends StatefulWidget {
  final String storePath;
  final Function(String imgURL) onTapOk;

  ImageUploader(this.onTapOk, {this.storePath});

  @override
  _ImageUploaderState createState() => _ImageUploaderState();

  static Function getImageFromUser(
      BuildContext context, Function(String imgURL) onTapOk,
      {String storePath}) {
    return () => showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return ImageUploader(onTapOk, storePath: storePath);
        });
  }
}

class _ImageUploaderState extends State<ImageUploader> {
  PickedFile _image;
  ImageSource source = ImageSource.gallery;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        titlePadding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        contentPadding: const EdgeInsets.only(left: 0, right: 0, bottom: 20),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(13.0)),
        title: Container(
            height: 40,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      padding: const EdgeInsets.all(0),
                      icon: Icon(Icons.close,
                          color: AppTheme.colors.support, size: 25),
                      onPressed: () => Navigator.pop(context)),
                  Container(
                      width: 70,
                      margin: const EdgeInsets.only(right: 10),
                      child: Button('Ok',
                          buttonSize: ButtonSize.SMALL,
                          borderColor: AppTheme.colors.primary,
                          shadow: false, onTap: () {
                        this._uploadImageWith(widget.onTapOk);
                        Navigator.pop(context);
                      }))
                ])),
        content: SingleChildScrollView(
            child: Column(children: [
          InkWell(
              onTap: () async {
                PickedFile image = await _getImageFromUser();
                setState(() {
                  this._image = image;
                });
              },
              child: Container(
                  width: 280,
                  height: 280,
                  margin: const EdgeInsets.only(bottom: 20),
                  child: this._image != null
                      ? Image.file(File(this._image.path))
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                              Icon(Icons.image_rounded,
                                  color: AppTheme.colors.semiPrimary, size: 50),
                              Text(
                                'Click to Upload',
                                style: AppTheme.getFont(
                                    color: AppTheme.colors.semiPrimary),
                              )
                            ]))),
          SwitchButton(
              options: ['Gallery', 'Camera'],
              onChange: (selected) {
                setState(() {
                  source = selected == 'Gallery'
                      ? ImageSource.gallery
                      : ImageSource.camera;
                });
              })
        ])));
  }

  Future<PickedFile> _getImageFromUser() async {
    try {
      return await _picker.getImage(source: source);
    } catch (e) {
      return null;
    }
  }

  Future<void> _uploadImageWith(Function(String) onTapOk) async {
    if (this._image == null) return;
    Reference firebaseStorageRef = // TODO: identical image file name
        FirebaseStorage.instance.ref().child('image/${
          widget.storePath ?? sha256.convert(await this._image.readAsBytes())
        }');
    UploadTask uploadTask = firebaseStorageRef.putFile(File(this._image.path));
    await uploadTask.whenComplete(() => uploadTask.snapshot.ref
        .getDownloadURL()
        .then((String url) => onTapOk(url)));
  }
}
