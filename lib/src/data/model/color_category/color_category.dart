import 'dart:ui';

import 'package:bloc_clean_architecture/src/common/extensions/string_extension.dart';
import 'package:flutter_core/flutter_core.dart';

import '../../../common/enums/color.dart';

class ColorCategory implements SelectableSearchMixin {
  final String? name;
  final String? hexCode;

  ColorCategory({
    this.name,
    this.hexCode,
  });

  static List<ColorCategory> getColorCategories() {
    return ColorCode.values.map((color) => ColorCategory(name: color.name.splitName(), hexCode: color.hexCode)).toList();
  }

Color hexToColor(String hexCode) {
  hexCode = hexCode.replaceAll("#", ""); // '#' işaretini kaldır
  return Color(int.parse("0xFF$hexCode")); // 0xFF ekleyerek Color'a çevir
}
  @override
  bool get active => true;

  @override
  bool filter(String query) {
    return name?.toLowerCase().contains(query.toLowerCase()) ?? false;
  }

  @override
  String? get subtitle => hexCode;

  @override
  String? get title => name;
}
