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
import 'package:padong/ui/theme/app_theme.dart';

class ToggleIconButton extends StatefulWidget {
  final IconData defaultIcon;
  final IconData toggleIcon;
  final double size; //  GIANT, LARGE, REGULAR, SMALL
  final Color defaultColor;
  final Color toggleColor;
  final Function onPressed;
  final bool isToggled;
  final bool disabled;
  final bool initEveryTime;
  final Alignment alignment;

  ToggleIconButton(defaultIcon,
      {toggleIcon,
      this.size = 25,
      defaultColor,
      toggleColor,
      this.onPressed,
      this.isToggled = false,
      this.disabled = false,
      this.initEveryTime = false,
      this.alignment = Alignment.center})
      : this.defaultIcon = defaultIcon,
        this.toggleIcon = toggleIcon ?? defaultIcon,
        defaultColor = defaultColor ?? AppTheme.colors.support,
        toggleColor = toggleColor ?? (defaultColor ?? AppTheme.colors.support);

  @override
  _ToggleIconButtonState createState() => _ToggleIconButtonState();
}

class _ToggleIconButtonState extends State<ToggleIconButton> {
  bool toggled;

  @override
  void initState() {
    super.initState();
    this.toggled = widget.isToggled;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.initEveryTime)
      setState(() {
        this.toggled = widget.isToggled;
      });
    return Container(
        width: widget.size,
        height: widget.size,
        child: IconButton(
            iconSize: widget.size,
            padding: const EdgeInsets.all(0),
            alignment: widget.alignment,
            onPressed: () {
              if (!widget.disabled) {
                setState(() {
                  this.toggled = !this.toggled;
                });
                if (widget.onPressed != null) widget.onPressed();
              }
            },
            icon: Icon(this.toggled ? widget.toggleIcon : widget.defaultIcon,
                color: toggled ? widget.toggleColor : widget.defaultColor,
                size: widget.size)));
  }
}
