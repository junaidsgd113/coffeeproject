// import 'package:isar/isar.dart';
// import 'package:json_annotation/json_annotation.dart';
// part 'product_model.g.dart';

// @collection
// @JsonSerializable()
// class Product {
//   String? category;
//   int? quantity;
//   String? title;
//   int? price;
//   String? image;
//   double? rating;
//   String? description;
//   String? uuid;
//   @Index()
//   Id get isarId => fastHash(uuid ?? '');

//   Product(
//       {this.quantity,
//       this.image,
//       this.title,
//       required this.uuid,
//       this.price,
//       this.category,
//       this.description,
//       this.rating});
//   factory Product.fromJson(Map<String, dynamic> json) =>
//       _$ProductFromJson(json);
//   Map<String, dynamic> toJson() => _$ProductToJson(this);
// }

// int fastHash(String string) {
//   var hash = 0xcbf29ce484222325;

//   var i = 0;
//   while (i < string.length) {
//     final codeUnit = string.codeUnitAt(i++);
//     hash ^= codeUnit >> 8;
//     hash *= 0x100000001b3;
//     hash ^= codeUnit & 0xFF;
//     hash *= 0x100000001b3;
//   }

//   return hash;
// }
