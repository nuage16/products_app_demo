import 'package:fpdart/src/either.dart';
import 'package:products_app_demo/core/errors/failure.dart';
import 'package:products_app_demo/core/params/product_params.dart';
import 'package:products_app_demo/core/usecase.dart';
import 'package:products_app_demo/domain/entities/product_details_ent.dart';
import 'package:products_app_demo/domain/entities/product_list_ent.dart';
import 'package:products_app_demo/domain/repositories/product_repository.dart';

class GetProductListUsecase extends Usecase<ProductListEnt, ProductListParams> {
  GetProductListUsecase(this.productRepository);

  final ProductRepository productRepository;

  @override
  Future<Either<Failure, ProductListEnt>> call(ProductListParams params) async {
    return await productRepository.getProductList(params);
  }
}

class GetProductUsecase extends Usecase<ProductDetailsEnt, ProductParams> {
  GetProductUsecase(this.productRepository);

  final ProductRepository productRepository;

  @override
  Future<Either<Failure, ProductDetailsEnt>> call(ProductParams params) async {

    return await productRepository.getProduct(params);
  }
}
