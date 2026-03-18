import 'package:json_annotation/json_annotation.dart';
import 'package:sneakers_app/features/shoes/domain/entities/product_entity.dart';

part 'product_api_model.g.dart';


@JsonSerializable()
class ProductApiModel {
  @JsonKey(name: '_id')
  final String id;
  final String shoesName;
  final String brand;
  final double price;
  final String description;
  final String category;
  final List<String> colors;
  final List<String> sizes;
  final String? shoesImage;

  ProductApiModel({
    required this.id,
    required this.shoesName,
    required this.brand,
    required this.price,
    required this.description,
    required this.category,
    required this.colors,
    required this.sizes,
    this.shoesImage,
  });

  factory ProductApiModel.fromJson(Map<String, dynamic> json) =>
      _$ProductApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductApiModelToJson(this);

  ProductEntity toEntity() {
    return ProductEntity(
      id: id,
      shoesName: shoesName,
      brand: brand,
      price: price,
      description: description,
      category: category,
      colors: colors,
      sizes: sizes,
      shoesImage: shoesImage
    );
  }

  factory ProductApiModel.fromEntity(ProductEntity entity) {
    return ProductApiModel(
      id: entity.id,
      shoesName: entity.shoesName,
      brand: entity.brand,
      price: entity.price,
      description: entity.description,
      category: entity.category,
      colors: entity.colors,
      sizes: entity.sizes,
    );
  }

  static List<ProductEntity> toEntityList(List<ProductApiModel> models) {
    return models.map((model) => model.toEntity()).toList();
  }
}
