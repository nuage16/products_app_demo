import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:products_app_demo/core/errors/failure.dart';
import 'package:products_app_demo/core/params/product_params.dart';
import 'package:products_app_demo/data/models/product_details_model.dart';
import 'package:products_app_demo/data/models/product_list_model.dart';
import 'package:products_app_demo/data/repositories/product_repository_impl.dart';
import 'package:products_app_demo/domain/repositories/product_repository.dart';
import 'package:retrofit/dio.dart';

import '../../fixtures/fixture_reader.dart';
import '../datasources/product_service_test.mocks.dart';

@GenerateNiceMocks([MockSpec<ProductRepository>()]) // @GenerateMocks([
void main() {
  late MockProductService mockProductService;
  late ProductRepositoryImpl repository;

  setUp(() {
    mockProductService = MockProductService();
    repository = ProductRepositoryImpl(mockProductService);
  });

  group('Test ProductRepository implementation.', () {
    group('Test getProductList method', () {
      test('should return ProductListEnt when call is successful', () async {
        // Arrange
        const params = ProductListParams(
            limit: 2, skip: 0, select: ['title', 'price', 'stock']);
        final productListEnt = ProductListModel.fromJson(
            jsonDecode(fixtures('product_list.json')));
        final response = HttpResponse(
            productListEnt,
            Response(
                statusCode: HttpStatus.ok,
                requestOptions: RequestOptions(path: '/products')));

        when(mockProductService
                .getProductList(2, 0, ['title', 'price', 'stock']))
            .thenAnswer((_) async => response);

        // Act
        final result = await repository.getProductList(params);

        // Assert
        verify(mockProductService
            .getProductList(2, 0, ['title', 'price', 'stock']));
        expect(result, Right(productListEnt));
      });

      test('should return ServerFailure when DioException is thrown', () async {
        // Arrange
        const params = ProductListParams(
            limit: 2, skip: 0, select: ['title', 'price', 'stock']);
        final dioException = DioException(
            requestOptions: RequestOptions(path: '/products'),
            response: Response(
                statusCode: HttpStatus.internalServerError,
                statusMessage: 'Internal Server Error!',
                requestOptions: RequestOptions(path: '/products')));

        when(mockProductService.getProductList(any, any, any)).thenThrow(dioException);

        // Act
        final result = await repository.getProductList(params);

        //Assert
        expect(result, const Left(ServerFailure('Internal Server Error!')));
      });
    });

    group('Test getProduct method.', () {
      test('should return ProductDetailsEnt when call is successful', () async {
        // Arrange
        const int id = 1;
        const params = ProductParams(id: id);
        final productEnt =
            ProductDetailsModel.fromJson(jsonDecode(fixtures('product.json')));
        final response = HttpResponse(
            productEnt,
            Response(
                statusCode: HttpStatus.ok,
                requestOptions: RequestOptions(path: '/products')));

        when(mockProductService.getProduct(id))
            .thenAnswer((_) async => response);

        // Act
        final result = await repository.getProduct(params);

        // Assert
        verify(mockProductService.getProduct(id));
        expect(result, Right(productEnt));
      });

      test('should return ServerFailure when DioException is thrown', () async {
        // Arrange
        const int id = 1;
        const params = ProductParams(id: id);
        final dioException = DioException(
          requestOptions: RequestOptions(path: '/products/1'),
          response: Response(
              statusCode: HttpStatus.internalServerError,
              statusMessage: 'Internal Server Error!',
              requestOptions: RequestOptions(path: '/products')),
        );

        when(mockProductService.getProduct(any)).thenThrow(dioException);

        // Act
        final result = await repository.getProduct(params);

        // Assert
        expect(result, const Left(ServerFailure('Internal Server Error!')));
      });
    });

  });
}
