// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'productmodel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_product _$$_productFromJson(Map<String, dynamic> json) => _$_product(
      category: json['category'] as String?,
      quantity: json['quantity'] as int?,
      title: json['title'] as String?,
      price: json['price'] as String?,
      image: json['image'] as String?,
      rating: json['rating'] as String?,
      description: json['description'] as String?,
      date: DateTime.parse(json['date'] as String),
      id: json['id'] as String?,
      uid: json['uid'] as String?,
    );

Map<String, dynamic> _$$_productToJson(_$_product instance) =>
    <String, dynamic>{
      'category': instance.category,
      'quantity': instance.quantity,
      'title': instance.title,
      'price': instance.price,
      'image': instance.image,
      'rating': instance.rating,
      'description': instance.description,
      'date': instance.date.toIso8601String(),
      'id': instance.id,
      'uid': instance.uid,
    };
