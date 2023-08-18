// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'productmodel.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Product _$ProductFromJson(Map<String, dynamic> json) {
  return _product.fromJson(json);
}

/// @nodoc
mixin _$Product {
  String? get category => throw _privateConstructorUsedError;
  int? get quantity => throw _privateConstructorUsedError;
  String? get title => throw _privateConstructorUsedError;
  String? get price => throw _privateConstructorUsedError;
  String? get image => throw _privateConstructorUsedError;
  String? get rating => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  DateTime get date => throw _privateConstructorUsedError;
  String? get id => throw _privateConstructorUsedError;
  String? get uid => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ProductCopyWith<Product> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProductCopyWith<$Res> {
  factory $ProductCopyWith(Product value, $Res Function(Product) then) =
      _$ProductCopyWithImpl<$Res, Product>;
  @useResult
  $Res call(
      {String? category,
      int? quantity,
      String? title,
      String? price,
      String? image,
      String? rating,
      String? description,
      DateTime date,
      String? id,
      String? uid});
}

/// @nodoc
class _$ProductCopyWithImpl<$Res, $Val extends Product>
    implements $ProductCopyWith<$Res> {
  _$ProductCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? category = freezed,
    Object? quantity = freezed,
    Object? title = freezed,
    Object? price = freezed,
    Object? image = freezed,
    Object? rating = freezed,
    Object? description = freezed,
    Object? date = null,
    Object? id = freezed,
    Object? uid = freezed,
  }) {
    return _then(_value.copyWith(
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String?,
      quantity: freezed == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int?,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      price: freezed == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as String?,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
      rating: freezed == rating
          ? _value.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      uid: freezed == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_productCopyWith<$Res> implements $ProductCopyWith<$Res> {
  factory _$$_productCopyWith(
          _$_product value, $Res Function(_$_product) then) =
      __$$_productCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? category,
      int? quantity,
      String? title,
      String? price,
      String? image,
      String? rating,
      String? description,
      DateTime date,
      String? id,
      String? uid});
}

/// @nodoc
class __$$_productCopyWithImpl<$Res>
    extends _$ProductCopyWithImpl<$Res, _$_product>
    implements _$$_productCopyWith<$Res> {
  __$$_productCopyWithImpl(_$_product _value, $Res Function(_$_product) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? category = freezed,
    Object? quantity = freezed,
    Object? title = freezed,
    Object? price = freezed,
    Object? image = freezed,
    Object? rating = freezed,
    Object? description = freezed,
    Object? date = null,
    Object? id = freezed,
    Object? uid = freezed,
  }) {
    return _then(_$_product(
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String?,
      quantity: freezed == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int?,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      price: freezed == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as String?,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
      rating: freezed == rating
          ? _value.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      uid: freezed == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_product implements _product {
  _$_product(
      {this.category,
      this.quantity,
      this.title,
      this.price,
      this.image,
      this.rating,
      this.description,
      required this.date,
      this.id,
      this.uid});

  factory _$_product.fromJson(Map<String, dynamic> json) =>
      _$$_productFromJson(json);

  @override
  final String? category;
  @override
  final int? quantity;
  @override
  final String? title;
  @override
  final String? price;
  @override
  final String? image;
  @override
  final String? rating;
  @override
  final String? description;
  @override
  final DateTime date;
  @override
  final String? id;
  @override
  final String? uid;

  @override
  String toString() {
    return 'Product(category: $category, quantity: $quantity, title: $title, price: $price, image: $image, rating: $rating, description: $description, date: $date, id: $id, uid: $uid)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_product &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.rating, rating) || other.rating == rating) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.uid, uid) || other.uid == uid));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, category, quantity, title, price,
      image, rating, description, date, id, uid);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_productCopyWith<_$_product> get copyWith =>
      __$$_productCopyWithImpl<_$_product>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_productToJson(
      this,
    );
  }
}

abstract class _product implements Product {
  factory _product(
      {final String? category,
      final int? quantity,
      final String? title,
      final String? price,
      final String? image,
      final String? rating,
      final String? description,
      required final DateTime date,
      final String? id,
      final String? uid}) = _$_product;

  factory _product.fromJson(Map<String, dynamic> json) = _$_product.fromJson;

  @override
  String? get category;
  @override
  int? get quantity;
  @override
  String? get title;
  @override
  String? get price;
  @override
  String? get image;
  @override
  String? get rating;
  @override
  String? get description;
  @override
  DateTime get date;
  @override
  String? get id;
  @override
  String? get uid;
  @override
  @JsonKey(ignore: true)
  _$$_productCopyWith<_$_product> get copyWith =>
      throw _privateConstructorUsedError;
}
