import 'dart:convert';

import 'package:fpdart/fpdart.dart';
import 'package:products_app_demo/core/errors/failure.dart';
import 'package:products_app_demo/core/params/product_params.dart';
import 'package:products_app_demo/data/models/product_list_model.dart';
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
  late GetProductListUsecase usecase;
  late ProductListParams params;
  late ProductListEnt productListEnt;

  setUp(() {
    repository = MockProductRepository();
    usecase = GetProductListUsecase(repository);
    params = const ProductListParams(
        limit: 2,
        skip: 0,
        select: ['title', 'price', 'thumbnail', 'stock', 'discountPercentage']);
    productListEnt =
        ProductListModel.fromJson(jsonDecode(fixtures('product_list.json')));
  });

  group('Test GetProductListUsecase.', () {
    test('should get a list of products', () async {
      provideDummy<Either<Failure, ProductListEnt>>((Right(productListEnt)));

      // Arrange
      when(repository.getProductList(params))
          .thenAnswer((realInvocation) async => Right(productListEnt));

      // Act
      final result = await usecase.call(params);

      // Assert
      expect(result, Right(productListEnt));
    });

    test('should return ServerFailure for encountered errors', () async {
      provideDummy<Either<Failure, ProductListEnt>>(
          (const Left(ServerFailure('Internal Server Error.'))));

      // Arrange
      when(repository.getProductList(params)).thenAnswer(
          (realInvocation) async =>
              const Left(ServerFailure('Internal Server Error.')));

      // Act
      final result = await usecase.call(params);

      // Assert
      expect(result, const Left(ServerFailure('Internal Server Error.')));
    });
  });
}
