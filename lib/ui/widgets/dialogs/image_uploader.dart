import 'dart:io';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:padong/ui/shared/types.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/widgets/buttons/button.dart';
import 'package:padong/ui/widgets/buttons/switch_button.dart';

final ImagePicker _picker = ImagePicker();

Function getImageFromUser(BuildContext context, Function(PickedFile) onTapOk) {
  return () => showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return ImageUploader(onTapOk: onTapOk);
      });
}

class ImageUploader extends StatefulWidget {
  final Function(PickedFile) onTapOk;

  ImageUploader({@required this.onTapOk});

  @override
  _ImageUploaderState createState() => _ImageUploaderState();
}

class _ImageUploaderState extends State<ImageUploader> {
  PickedFile _image;
  ImageSource source = ImageSource.gallery;

  Future<PickedFile> _uploadImageToStorage() async {
    try {
      return await _picker.getImage(source: source);
    } catch (e) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      titlePadding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      contentPadding: const EdgeInsets.only(left: 0, right: 0, bottom: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      title: Container(
          height: 40,
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            IconButton(
                padding: const EdgeInsets.all(0),
                icon:
                    Icon(Icons.close, color: AppTheme.colors.support, size: 25),
                onPressed: () => Navigator.pop(context)),
            Container(
                width: 70,
                margin: const EdgeInsets.only(right: 10),
                child: Button(
                    title: 'Ok',
                    buttonSize: ButtonSize.SMALL,
                    borderColor: AppTheme.colors.primary,
                    shadow: false,
                    callback: () {
                      widget.onTapOk(this._image);
                      Navigator.pop(context);
                    }))
          ])),
      content: SingleChildScrollView(
          child: Column(children: [
        InkWell(
            onTap: () async {
              PickedFile image = await _uploadImageToStorage();
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
      ])),
      //actions: [FlatButton(child: new Text("Close"), onPressed: () => Navigator.pop(context))]
    );
  }
}
