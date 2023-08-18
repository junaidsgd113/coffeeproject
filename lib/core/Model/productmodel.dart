import 'package:freezed_annotation/freezed_annotation.dart';


part 'productmodel.freezed.dart';
part 'productmodel.g.dart';
@freezed
class Product with _$Product {
  factory Product({
    String? category,
  int? quantity,
  String? title,
  String? price,
  String? image,
  String? rating,
  String? description,
  required  DateTime  date,
 String ?id,
 String ?uid,
  }) = _product;
  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);
}