import 'package:equatable/equatable.dart';

class ProductDetailsEnt extends Equatable {
  final int id;
  final String? title;
  final String? description;
  final double? price;
  final double? discountPercentage;
  final double? rating;
  final int? stock;
  final String? brand;
  final String? category;
  final String? thumbnail;
  final List<String?>? images;

  const ProductDetailsEnt({
    required this.id,
     this.title,
     this.description,
     this.price,
     this.discountPercentage,
     this.rating,
     this.stock,
     this.brand,
     this.category,
     this.thumbnail,
     this.images,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        price,
        discountPercentage,
        rating,
        stock,
        brand,
        category,
        thumbnail,
        images
      ];
}
