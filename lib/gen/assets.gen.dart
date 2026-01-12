/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class $AssetsIconsGen {
  const $AssetsIconsGen();

  /// File path: assets/icons/cash.png
  AssetGenImage get cash => const AssetGenImage('assets/icons/cash.png');

  /// File path: assets/icons/edit.png
  AssetGenImage get editPng => const AssetGenImage('assets/icons/edit.png');

  /// File path: assets/icons/edit.svg
  String get editSvg => 'assets/icons/edit.svg';

  /// File path: assets/icons/emptyIcon.png
  AssetGenImage get emptyIcon =>
      const AssetGenImage('assets/icons/emptyIcon.png');

  /// File path: assets/icons/settings.svg
  String get settings => 'assets/icons/settings.svg';

  /// File path: assets/icons/visa.png
  AssetGenImage get visa => const AssetGenImage('assets/icons/visa.png');

  /// File path: assets/icons/visaCard.png
  AssetGenImage get visaCard =>
      const AssetGenImage('assets/icons/visaCard.png');

  /// File path: assets/icons/visaSvg.svg
  String get visaSvg => 'assets/icons/visaSvg.svg';

  /// List of all assets
  List<dynamic> get values =>
      [cash, editPng, editSvg, emptyIcon, settings, visa, visaCard, visaSvg];
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/detail.png
  AssetGenImage get detail => const AssetGenImage('assets/images/detail.png');

  /// File path: assets/images/guestLogo.png
  AssetGenImage get guestLogoPng =>
      const AssetGenImage('assets/images/guestLogo.png');

  /// File path: assets/images/guestLogo.svg
  String get guestLogoSvg => 'assets/images/guestLogo.svg';

  /// File path: assets/images/placeHolder.png
  AssetGenImage get placeHolder =>
      const AssetGenImage('assets/images/placeHolder.png');

  /// File path: assets/images/server.svg
  String get server => 'assets/images/server.svg';

  /// File path: assets/images/serverfailure.svg
  String get serverfailure => 'assets/images/serverfailure.svg';

  /// File path: assets/images/test.png
  AssetGenImage get test => const AssetGenImage('assets/images/test.png');

  /// File path: assets/images/tomato.png
  AssetGenImage get tomato => const AssetGenImage('assets/images/tomato.png');

  /// List of all assets
  List<dynamic> get values => [
        detail,
        guestLogoPng,
        guestLogoSvg,
        placeHolder,
        server,
        serverfailure,
        test,
        tomato
      ];
}

class $AssetsLogoGen {
  const $AssetsLogoGen();

  /// File path: assets/logo/logo.svg
  String get logo => 'assets/logo/logo.svg';

  /// List of all assets
  List<String> get values => [logo];
}

class $AssetsSplashGen {
  const $AssetsSplashGen();

  /// File path: assets/splash/hungry.png
  AssetGenImage get hungryPng =>
      const AssetGenImage('assets/splash/hungry.png');

  /// File path: assets/splash/hungry.svg
  String get hungrySvg => 'assets/splash/hungry.svg';

  /// List of all assets
  List<dynamic> get values => [hungryPng, hungrySvg];
}

class Assets {
  const Assets._();

  static const $AssetsIconsGen icons = $AssetsIconsGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();
  static const $AssetsLogoGen logo = $AssetsLogoGen();
  static const $AssetsSplashGen splash = $AssetsSplashGen();
}

class AssetGenImage {
  const AssetGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
  });

  final String _assetName;

  final Size? size;
  final Set<String> flavors;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = true,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.medium,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
