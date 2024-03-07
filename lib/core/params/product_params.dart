import 'package:equatable/equatable.dart';

import '../../data/models/product_details_model.dart';

class ProductListParams extends Equatable {
  const ProductListParams({required this.limit, required this.skip, required this.select});

  final int limit;
  final int skip;
  final List<String> select;

  @override
  List<Object?> get props => [limit, skip, select];
}

class ProductParams extends Equatable {
  const ProductParams({required this.id});

  final int id;

  @override
  List<Object?> get props => [id];
}
