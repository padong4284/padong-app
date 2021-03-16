import 'dart:async';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'dart:ui' as ui show Image, Picture;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_svg/src/utilities/http.dart';
import 'package:flutter_svg/svg.dart' as flutter_svg;

/// Rasterizes given svg picture for displaying in [Image] widget:
///
/// ```dart
/// Image(
///   width: 32,
///   height: 32,
///   image: Svg('assets/my_icon.svg'),
/// )
/// ```
class Svg extends ImageProvider<SvgImageKey> {
  /// Path to svg file asset
  final String asset;

  /// Size in logical pixels to render.
  /// Useful for [DecorationImage].
  /// If not specified, will use size from [Image].
  /// If [Image] not specifies size too, will use default size 100x100.
  final Size size; // nullable

  /// Color to tint the SVG
  final Color color;

  /// Width and height can also be specified from [Image] constrictor.
  /// Default size is 100x100 logical pixels.
  /// Different size can be specified in [Image] parameters
  const Svg(this.asset, {this.size, this.color}) : assert(asset != null);

  @override
  Future<SvgImageKey> obtainKey(ImageConfiguration configuration) {
    final double logicWidth = size?.width ?? configuration.size?.width ?? 100;
    final double logicHeight = size?.height ?? configuration.size?.width ?? 100;
    final double scale = configuration.devicePixelRatio ?? 1.0;
    final Color color = this.color ?? Colors.transparent;

    return SynchronousFuture<SvgImageKey>(
      SvgImageKey(
          assetName: asset,
          pixelWidth: (logicWidth * scale).round(),
          pixelHeight: (logicHeight * scale).round(),
          scale: scale,
          color: color),
    );
  }

  @override
  ImageStreamCompleter load(SvgImageKey key, nil) {
    return OneFrameImageStreamCompleter(
      _loadAsync(key),
    );
  }

  static Future<ImageInfo> _loadAsync(SvgImageKey key) async {
    final String rawSvg = await rootBundle.loadString(key.assetName);
    final DrawableRoot svgRoot = await svg.fromSvgString(rawSvg, key.assetName);
    final ui.Picture picture = svgRoot.toPicture(
      size: Size(
        key.pixelWidth.toDouble(),
        key.pixelHeight.toDouble(),
      ),
      clipToViewBox: false,
      colorFilter: ColorFilter.mode(key.color, BlendMode.srcATop),
    );
    final ui.Image image = await picture.toImage(
      key.pixelWidth,
      key.pixelHeight,
    );
    return ImageInfo(
      image: image,
      scale: key.scale,
    );
  }

  // Note: == and hashCode not overrided as changes in properties
  // (width, height and scale) are not observable from the here.
  // [SvgImageKey] instances will be compared instead.

  @override
  String toString() => '$runtimeType(${describeIdentity(asset)})';
}

/// Rasterizes given svg picture for displaying in [Image] widget:
///
/// ```dart
/// Image(
///   width: 32,
///   height: 32,
///   image: Svg('assets/my_icon.svg'),
/// )
/// ```
class SvgNetwork extends ImageProvider<SvgImageKey> {
  /// Path to svg file asset
  final String url;
  final Future<Uint8List> Function(String) httpHooker;

  /// Size in logical pixels to render.
  /// Useful for [DecorationImage].
  /// If not specified, will use size from [Image].
  /// If [Image] not specifies size too, will use default size 100x100.
  final Size size; // nullable

  /// Color to tint the SVG
  final Color color;

  @override
  Future<SvgImageKey> obtainKey(ImageConfiguration configuration) {
    final double logicWidth = size?.width ?? configuration.size?.width ?? 100;
    final double logicHeight = size?.height ?? configuration.size?.width ?? 100;
    final double scale = configuration.devicePixelRatio ?? 1.0;
    final Color color = this.color ?? Colors.transparent;

    return SynchronousFuture<SvgImageKey>(
      SvgImageKey(
          assetName: url,
          pixelWidth: (logicWidth * scale).round(),
          pixelHeight: (logicHeight * scale).round(),
          scale: scale,
          color: color),
    );
  }

  /// Width and height can also be specified from [Image] constrictor.
  /// Default size is 100x100 logical pixels.
  /// Different size can be specified in [Image] parameters
  const SvgNetwork(this.url, {this.httpHooker, this.size, this.color})
      : assert(url != null);

  @override
  ImageStreamCompleter load(SvgImageKey key, nil,
      {PictureErrorListener onError}) {
    return OneFrameImageStreamCompleter(_loadAsync(key, onError: onError),
        informationCollector: () sync* {
      yield DiagnosticsProperty<ImageProvider>('Picture provider', this);
      yield DiagnosticsProperty<SvgImageKey>('Picture key', key);
    });
  }

  //static Future<ImageInfo> _loadAsync(SvgImageKey key) async {
  Future<ImageInfo> getImageInfo(Uint8List bytes, SvgImageKey key) async {
    final DrawableRoot svgRoot =
        await flutter_svg.svg.fromSvgBytes(bytes, "networkPicture");
    final ui.Picture picture = svgRoot.toPicture(
      size: Size(key.pixelWidth.toDouble(), key.pixelHeight.toDouble()),
      clipToViewBox: false,
      colorFilter: ColorFilter.mode(key.color, BlendMode.srcATop),
    );
    final ui.Image image = await picture.toImage(
      key.pixelWidth,
      key.pixelHeight,
    );
    return ImageInfo(
      image: image,
      scale: key.scale,
    );
  }

  Future<ImageInfo> _loadAsync(SvgImageKey key,
      {PictureErrorListener onError}) async {
    //assert(key == this);
    final Uint8List bytes = this.httpHooker != null
        ? await this.httpHooker(url)
        : await httpGet(url);
    if (onError != null) {
      return await getImageInfo(bytes, key).catchError(onError);
    }
    return await getImageInfo(bytes, key);
  }

  /*{
    final String rawSvg = await rootBundle.loadString(key.assetName);
    final DrawableRoot svgRoot = await svg.fromSvgString(rawSvg, key.assetName);
    final ui.Picture picture = svgRoot.toPicture(
      size: Size(
        key.pixelWidth.toDouble(),
        key.pixelHeight.toDouble(),
      ),
      clipToViewBox: false,
      colorFilter: ColorFilter.mode(key.color, BlendMode.srcATop),
    );
    final ui.Image image = await picture.toImage(
      key.pixelWidth,
      key.pixelHeight,
    );
    return ImageInfo(
      image: image,
      scale: key.scale,
    );
  }*/

  // Note: == and hashCode not overrided as changes in properties
  // (width, height and scale) are not observable from the here.
  // [SvgImageKey] instances will be compared instead.

  @override
  String toString() => '$runtimeType(${describeIdentity(url)})';

  @override
  bool operator ==(dynamic other) {
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is SvgNetwork &&
        url == other.url &&
        this.color == other.color &&
        this.size == other.size;
  }

  static Future<Uint8List> convertWikiToSvg(String url) async {
    var res = await http.read(Uri.parse(url));
    url = "https:" + res.split("fullMedia\"><p><a href=\"")[1].split("\"")[0];
    return await http.readBytes(Uri.parse(url));
  }
}

@immutable
class SvgImageKey {
  const SvgImageKey({
    @required this.assetName,
    @required this.pixelWidth,
    @required this.pixelHeight,
    @required this.scale,
    this.color,
  })  : assert(assetName != null),
        assert(pixelWidth != null),
        assert(pixelHeight != null),
        assert(scale != null);

  /// Path to svg asset.
  final String assetName;

  /// Width in physical pixels.
  /// Used when raterizing.
  final int pixelWidth;

  /// Height in physical pixels.
  /// Used when raterizing.
  final int pixelHeight;

  /// Color to tint the SVG
  final Color color;

  /// Used to calculate logical size from physical, i.e.
  /// logicalWidth = [pixelWidth] / [scale],
  /// logicalHeight = [pixelHeight] / [scale].
  /// Should be equal to [MediaQueryData.devicePixelRatio].
  final double scale;

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is SvgImageKey &&
        other.assetName == assetName &&
        other.pixelWidth == pixelWidth &&
        other.pixelHeight == pixelHeight &&
        other.scale == scale;
  }

  @override
  int get hashCode => hashValues(assetName, pixelWidth, pixelHeight, scale);

  @override
  String toString() => '${objectRuntimeType(this, 'SvgImageKey')}'
      '(assetName: "$assetName", pixelWidth: $pixelWidth, pixelHeight: $pixelHeight, scale: $scale)';
}
