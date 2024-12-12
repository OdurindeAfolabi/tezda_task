import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tezda_task/app/shared/helpers/classes/preferences/preferences.dart';

part 'platzi_product_data.freezed.dart';
part 'platzi_product_data.g.dart';

@freezed
class PlatziProductData extends Cachable2 with _$PlatziProductData  {
  const factory PlatziProductData({
    int? id,
    String? title,
    double? price,
    String? description,
    Category? category,
    List<String>? images,
  }) = _PlatziProductData;

  factory PlatziProductData.fromJson(Map<String, dynamic> json) => _$PlatziProductDataFromJson(json);

}

@freezed
class Category with _$Category {
  const factory Category({
    int? id,
    String? name,
    String? image,
  }) = _Category;

  factory Category.fromJson(Map<String, dynamic> json) => _$CategoryFromJson(json);
}
