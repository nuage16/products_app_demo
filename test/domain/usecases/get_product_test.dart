import 'dart:convert';
import 'dart:math';

import 'package:fpdart/fpdart.dart';
import 'package:products_app_demo/core/errors/failure.dart';
import 'package:products_app_demo/core/params/product_params.dart';
import 'package:products_app_demo/data/models/product_details_model.dart';
import 'package:products_app_demo/domain/entities/product_details_ent.dart';
import 'package:products_app_demo/domain/entities/product_list_ent.dart';
import 'package:products_app_demo/domain/repositories/product_repository.dart';
import 'package:products_app_demo/domain/usecases/product_usecase.dart';
import 'package:test/test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import '../../data/repositories/product_repository_impl_test.mocks.dart';
import '../../fixtures/fixture_reader.dart';

@GenerateMocks([ProductRepository])
void main() {
  late MockProductRepository repository;
  late GetProductUsecase usecase;
  late ProductParams params;
  late ProductDetailsEnt productDetailsEnt;

  setUp(() {
    repository = MockProductRepository();
    usecase = GetProductUsecase(repository);
    params = const ProductParams(id: 1);
    productDetailsEnt = ProductDetailsModel.fromJson(jsonDecode(fixtures('product.json')));

   });

  group('get product', () {
    test('should get product with specified id', () async {
      provideDummy<Either<Failure, ProductDetailsEnt>>(
          (Right(productDetailsEnt)));

      //arrange
      when(repository.getProduct(params))
          .thenAnswer((realInvocation) async => Right(productDetailsEnt));

      //act
      final result = await usecase.call(params);

      //assert
      expect(result, Right(productDetailsEnt));
    });

    test('should return ServerFailure for encountered errors', () async {
      provideDummy<Either<Failure, ProductDetailsEnt>>(
          (const Left(ServerFailure('Status 404'))));

      //arrange
      when(repository.getProduct(params))
          .thenAnswer((realInvocation) async => const Left(ServerFailure('Status 404')));

      //act
      final result = await usecase.call(params);

      //assert
      expect(result,  const Left(ServerFailure('Status 404')));
    });
  });
}
