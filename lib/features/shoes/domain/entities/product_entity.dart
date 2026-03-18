import 'package:equatable/equatable.dart';

class ProductEntity extends Equatable {
  final String id;
  final String shoesName;
  final String brand;
  final double price;
  final String description;
  final String category;
  final List<String> colors;
  final List<String> sizes;
  final String? shoesImage;

  const ProductEntity({
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

  @override
  List<Object?> get props => [
    id,
    shoesName,
    brand,
    price,
    description,
    category,
    colors,
    sizes,
    shoesImage,
  ];
}
