// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductApiModel _$ProductApiModelFromJson(Map<String, dynamic> json) =>
    ProductApiModel(
      id: json['_id'] as String,
      shoesName: json['shoesName'] as String,
      brand: json['brand'] as String,
      price: (json['price'] as num).toDouble(),
      description: json['description'] as String,
      category: json['category'] as String,
      colors: (json['colors'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      sizes: (json['sizes'] as List<dynamic>).map((e) => e as String).toList(),
      shoesImage: json['shoesImage'] as String?,
    );

Map<String, dynamic> _$ProductApiModelToJson(ProductApiModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'shoesName': instance.shoesName,
      'brand': instance.brand,
      'price': instance.price,
      'description': instance.description,
      'category': instance.category,
      'colors': instance.colors,
      'sizes': instance.sizes,
      'shoesImage': instance.shoesImage,
    };
