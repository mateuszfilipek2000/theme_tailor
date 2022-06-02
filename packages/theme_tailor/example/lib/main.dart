// ignore_for_file: unused_element

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

part 'main.tailor.dart';
part 'main.tailor.target.dart';

/// Define your colors somewhere in the app
class AppColors {
  static const Color blue = Colors.blue;
  static const Color orange = Colors.orange;
}

/// EXAMPLES
/// **************************************************************************
/// Default theme - default definition [@tailor] generates theme with 2 modes:
/// light and dark and 2 properties: [int] and [String] properties.
/// Without further customization it is not useful

class _Test {
  const _Test();
}

const test = _Test();

/// Test Comment
// Test comment
// @tailor
// class _$DefaultTheme {}

// **************************************************************************
/// Default theme - light / dark with additional fields
/// h1 - text style
/// appBar - with different colors per mode (light: blue, dark: orange)

// @Tailor([
//   TailorProp('h1', [TextStyle(), TextStyle()]),
//   TailorProp('appBar', [AppColors.blue, AppColors.orange]),
//   TailorProp('card', [AppColors.blue, AppColors.orange]),
//   TailorProp('surface', [AppColors.blue, AppColors.orange]),
//   TailorProp('material', [AppColors.blue, AppColors.orange])
// ])
// class _$ThemeWithColorsAndTextStyles {}

// **************************************************************************
/// DOC

class ColorEncoder extends SimpleThemeEncoder<MaterialColor> {
  const ColorEncoder();

  @override
  Lerp<MaterialColor> get lerp => (a, b, t) => t < 0.5 ? a : b;
}

// @Tailor([
//   TailorProp('appBar', [AppColors.blue, AppColors.orange], encoder: ColorEncoder())
// ])
// class _$ThemeWithColorsAndTextStylesCustomEncoder {}

// **************************************************************************
/// DOC - Multitheme, custom encoders

enum SuperThemeEnum {
  light,
  superLight,
  dark,
  superDark,
}

class SuperThemeEnumEncoder extends SimpleThemeEncoder<SuperThemeEnum> {
  const SuperThemeEnumEncoder();

  @override
  Lerp<SuperThemeEnum> get lerp => (a, b, t) => t < 0.5 ? a : b;
}

/// TODO type 'SimpleIdentifierImpl' is not a subtype of type 'ListLiteral' in type cast

const themes = ['light', 'superLight', 'dark', 'superDark'];
const themesEnums = [SuperThemeEnum.light, SuperThemeEnum.superLight, SuperThemeEnum.dark, SuperThemeEnum.superDark];

// @Tailor([
//   TailorProp(
//       'themeType', [SuperThemeEnum.light, SuperThemeEnum.superLight, SuperThemeEnum.dark, SuperThemeEnum.superDark]),
//   TailorProp(
//       'themeType2', [SuperThemeEnum.light, SuperThemeEnum.superLight, SuperThemeEnum.dark, SuperThemeEnum.superDark],
//       encoder: SuperThemeEnumEncoder()),
// ], themes)
class _$SuperThemeEnumThemeExtension {}

// **************************************************************************
/// DOC - Custom encoders

class NumerEncoder extends ThemeEncoder<int, double> {
  const NumerEncoder();

  @override
  Lerp<double> get lerp => (a, b, t) => lerpDouble(a, b, t)!;

  @override
  TransformData<int, double>? get transformData => (v, _) => v.toDouble();
}

/// Custom data to encode in prefered format
class TextData {
  const TextData({
    this.fontFamily,
    this.size,
    this.lineHeight,
    this.spacing,
    this.fontWeight,
    this.defaultColor,
  });

  final String? fontFamily;
  final double? size;
  final double? lineHeight;
  final double? spacing;
  final int? fontWeight;
  final Color? defaultColor;

  static const h3 = TextData(defaultColor: AppColors.orange);

  TextStyle toTextStyle(Color color) => TextStyle(color: color);
}

/// Encoder to transform data before it is encoded to theme
/// During data transformation, custom properties can be encoded from the
/// [TextDataEncoder.colors] in the [TextDataEncoder.transformData]
class TextDataEncoder extends ThemeEncoder<TextData, TextStyle> {
  const TextDataEncoder(this.colors);

  final List<Color> colors;

  @override
  Lerp<TextStyle> get lerp => (a, b, t) => TextStyle.lerp(a, b, t)!;

  @override
  TransformData<TextData, TextStyle>? get transformData => (v, i) => v.toTextStyle(colors[i]);
}

const textDataEncoderBlackWhite = TextDataEncoder([Colors.black, Colors.white]);

class PColor extends Prop<Color> {
  const PColor(super.values);
}

class PInt extends Prop<int> {
  const PInt(super.values);
}

class PDouble extends Prop<double> {
  const PDouble(super.values);
}

class PTextData extends BaseProp<TextData, TextStyle> {
  const PTextData(super.values, super.themeEncoder);
}

class A {
  const A(this.map);

  final Map<String, List> map;
}

@Tailor({
  'h3': PTextData([TextData.h3, TextData()], TextDataEncoder([Colors.blue, Colors.orange])),
  'h4': PTextData([TextData.h3, TextData()], TextDataEncoder([Colors.red, Colors.amber])),
  'luckyNumber': PInt([3, 8]),
  'appBar': PColor([AppColors.blue, AppColors.orange]),
})
class _$CustomThemeExtensionLightDark2 {}
