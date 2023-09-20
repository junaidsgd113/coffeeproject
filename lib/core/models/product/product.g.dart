// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_product _$$_productFromJson(Map<String, dynamic> json) => _$_product(
      category: json['category'] as String?,
      totalquantity: json['totalquantity'] as int,
      soldquantity: json['soldquantity'] as int? ?? 0,
      title: json['title'] as String?,
      soldprice: json['soldprice'] as int?,
      actualprice: json['actualprice'] as int?,
      image: json['image'] as String?,
      rating: (json['rating'] as num?)?.toDouble(),
      description: json['description'] as String?,
      createdatdate: json['createdatdate'] as int,
      id: json['id'] as String,
      timestamp: json['timestamp'],
    );

Map<String, dynamic> _$$_productToJson(_$_product instance) =>
    <String, dynamic>{
      'category': instance.category,
      'totalquantity': instance.totalquantity,
      'soldquantity': instance.soldquantity,
      'title': instance.title,
      'soldprice': instance.soldprice,
      'actualprice': instance.actualprice,
      'image': instance.image,
      'rating': instance.rating,
      'description': instance.description,
      'createdatdate': instance.createdatdate,
      'id': instance.id,
      'timestamp': instance.timestamp,
    };
