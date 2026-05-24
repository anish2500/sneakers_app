import 'package:hive_flutter/adapters.dart';
import 'package:sneakers_app/core/constants/hive_table_constant.dart';
import 'package:sneakers_app/features/shoes/domain/entities/product_entity.dart';
import 'package:uuid/uuid.dart';

part 'product_hive_model.g.dart';

@HiveType(typeId: HiveTableConstant.productTypeId)
class ProductHiveModel extends HiveObject {
  @HiveField(0)
  final String? id;

  @HiveField(1)
  final String shoesName;

  @HiveField(2)
  final String brand;

  @HiveField(3)
  final double price;

  @HiveField(4)
  final String description;

  @HiveField(5)
  final String category;

  @HiveField(6)
  final List<String> colors;

  @HiveField(7)
  final List<String> sizes;

  @HiveField(8)
  final String? shoesImage;

  ProductHiveModel({
    String? id,
    required this.shoesName,
    required this.brand,
    required this.price,
    required this.description,
    required this.category,
    required this.colors,
    required this.sizes,
    this.shoesImage,
  }) : id = id ?? const Uuid().v4();

  String get generatedProductId => id ?? const Uuid().v4();

  factory ProductHiveModel.fromEntity(ProductEntity entity) {
    return ProductHiveModel(
      id: entity.id,
      shoesName: entity.shoesName,
      brand: entity.brand,
      price: entity.price,
      description: entity.description,
      category: entity.category,
      colors: entity.colors,
      sizes: entity.sizes,
      shoesImage: entity.shoesImage,
    );
  }
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
    );
  }

  static List<ProductEntity> toEntityList(List<ProductHiveModel> models) {
    return models.map((model) => model.toEntity()).toList();
  }
}
