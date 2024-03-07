import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:products_app_demo/domain/entities/product_details_ent.dart';

class ProductListEnt extends Equatable {
  final List<ProductDetailsEnt> products;
  final int? total;
  final int? skip;
  final int? limit;

  const ProductListEnt({
    required this.products,
    required this.total,
    required this.skip,
    required this.limit,
  });

  @override
  List<Object?> get props => [products, total, skip, limit];
}
