import 'package:freezed_annotation/freezed_annotation.dart';
import 'timestamp_converter.dart';
part 'product.freezed.dart';
part 'product.g.dart';
@freezed
class Product with _$Product {
  factory Product({
    String? category,
   required int totalquantity,
  @Default(0) int soldquantity,
  String? title,
  int? soldprice,
   int? actualprice,
  String? image,
  double? rating,
  String? description,
  // required  int  createdatdate,
 required  String id,

 @TimestampConverter() timestamp,

  }) = _product;


  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

 
}

