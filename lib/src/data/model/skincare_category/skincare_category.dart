import 'package:flutter_core/flutter_core.dart';

import '../../../common/enums/cosmetic_category.dart';

class SkinCareCategory implements SelectableSearchMixin {
  final String? name;

  SkinCareCategory({
    this.name,
  });

  static List<SkinCareCategory> getSkincareCategories() {
    return SkincareCategoryEnum.values.map((category) => SkinCareCategory(name: category.value)).toList();
  }

  @override
  bool get active => true;

  @override
  bool filter(String query) => true;

  @override
  String? get subtitle => "";

  @override
  String? get title => name;
}
