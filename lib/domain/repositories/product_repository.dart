import 'package:fpdart/fpdart.dart';
import 'package:products_app_demo/core/params/product_params.dart';
import 'package:products_app_demo/domain/entities/product_details_ent.dart';
import 'package:products_app_demo/domain/entities/product_list_ent.dart';

import '../../core/errors/failure.dart';

abstract class ProductRepository {
  Future<Either<Failure, ProductListEnt>> getProductList(ProductListParams params);
  Future<Either<Failure, ProductDetailsEnt>> getProduct(ProductParams params);
}
