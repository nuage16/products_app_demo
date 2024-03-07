import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:products_app_demo/data/datasources/product_service.dart';
import 'package:products_app_demo/data/models/product_details_model.dart';
import 'package:products_app_demo/data/models/product_list_model.dart';
import 'package:retrofit/dio.dart';
import '../../fixtures/fixture_reader.dart';
import 'product_service_test.mocks.dart';

@GenerateMocks([ProductService])
void main() {
  group('Test ProductService.', () {
    late MockProductService mockProductService;

    setUp(() {
      mockProductService = MockProductService();
    });

    group('Test get a list of products.', () {
      final Response response =
          Response(requestOptions: RequestOptions(path: '/products'));
      final ProductListModel productListModel = ProductListModel.fromJson(
          jsonDecode(fixtures('product_list_inc.json')));

      test('should be an HttpResponse<ProductListModel?> object', () async {
        // Assert
        expect(HttpResponse(productListModel, response),
            isA<HttpResponse<ProductListModel?>>());
      });

      test('should return product list', () async {
        //Arrange
        const limit = 2;
        const skip = 0;
        final select = [
          'title',
          'price',
          'thumbnail',
          'stock',
          'discountePercentage'
        ];

        final HttpResponse<ProductListModel?> httpResponse =
            HttpResponse(productListModel, response);

        when(mockProductService.getProductList(limit, skip, select))
            .thenAnswer((_) async => httpResponse);

        //Act
        final result =
            await mockProductService.getProductList(limit, skip, select);

        //Assert
        expect(result.data, productListModel);
      });

      test('should return product list with missing parameters', () async {
        //Arrange
        final HttpResponse<ProductListModel?> httpResponse =
            HttpResponse(productListModel, response);

        when(mockProductService.getProductList(null, null, null))
            .thenAnswer((_) async => httpResponse);

        //Act
        final result =
            await mockProductService.getProductList(null, null, null);

        //Assert
        expect(result.data, productListModel);
      });

      test('should return all products limit greater than total', () async {
        //Arrange
        const limit = 10;
        const skip = 0;
        final select = [
          'title',
          'price',
          'thumbnail',
          'stock',
          'discountPercentage'
        ];

        final HttpResponse<ProductListModel?> httpResponse =
            HttpResponse(productListModel, response);

        when(mockProductService.getProductList(limit, skip, select))
            .thenAnswer((_) async => httpResponse);

        //Act
        final result =
            await mockProductService.getProductList(limit, skip, select);

        //Assert
        expect(result.data, productListModel);
      });

      test(
          'should return product list & disregard parameter if limit/skip is invalid',
          () async {
        //Arrange
        const limit = -5;
        const skip = 0;
        final select = [
          'title',
          'price',
          'thumbnail',
          'stock',
          'discountPercentage'
        ];

        final HttpResponse<ProductListModel?> httpResponse =
            HttpResponse(productListModel, response);

        when(mockProductService.getProductList(limit, skip, select))
            .thenAnswer((_) async => httpResponse);

        //Act
        final result =
            await mockProductService.getProductList(limit, skip, select);

        //Assert
        expect(result.data, productListModel);
      });

      test(
          "should return product list with 'select' properties & the id; "
          "& disregard invalid parameters", () async {
        //Arrange
        const limit = 2;
        const skip = 0;
        final select = [
          'title',
          'price',
          'thumbnail',
          'stock',
          'discountPercentage',
          'random'
        ];

        final HttpResponse<ProductListModel?> httpResponse =
            HttpResponse(productListModel, response);

        when(mockProductService.getProductList(limit, skip, select))
            .thenAnswer((_) async => httpResponse);

        //Act
        final result =
            await mockProductService.getProductList(limit, skip, select);

        //Assert
        expect(result.data, productListModel);
      });

      test('should return an error when request fails', () async {
        //Arrange
        const limit = 2;
        const skip = 0;
        final select = [
          'title',
          'price',
          'thumbnail',
          'stock',
          'discountePercentage'
        ];
        final responseError = Response(
            statusCode: 404,
            statusMessage: "Not found",
            requestOptions: RequestOptions(path: '/products'));
        final HttpResponse<ProductListModel?> httpResponse =
            HttpResponse(null, responseError);

        when(mockProductService.getProductList(limit, skip, select))
            .thenAnswer((_) async => httpResponse);

        //Act
        final result =
            await mockProductService.getProductList(limit, skip, select);

        //Assert
        expect(result.data, null);
        expect(result.response.statusCode, 404);
      });
    });

    group('Test get a product.', () {
      final productModel =
          ProductDetailsModel.fromJson(jsonDecode(fixtures('product.json')));

      test('should be an HttpResponse<ProductDetailsModel?> object', () async {
        //Arrange
        final response = Response(
            requestOptions:
                RequestOptions(path: '/products', queryParameters: {'id': 1}));
        // Assert
        expect(HttpResponse(productModel, response),
            isA<HttpResponse<ProductDetailsModel?>>());
      });

      test("should return a ProductDetailsModel", () async {
        //Arrange
        const int id = 1;
        final response = Response(
            requestOptions:
                RequestOptions(path: '/products', queryParameters: {'id': 1}));
        final httpResponse = HttpResponse(productModel, response);

        when(mockProductService.getProduct(id))
            .thenAnswer((_) async => httpResponse);

        //Act
        final result = await mockProductService.getProduct(id);

        //Assert
        expect(result.data, productModel);
      });

      test("should return null data when id is invalid or request fails",
          () async {
        //Arrange
        const int id = 1;
        final response = Response(
            statusCode: 404,
            statusMessage: "Product with id '101' not found",
            requestOptions:
                RequestOptions(path: '/products', queryParameters: {'id': 1}));
        final httpResponse = HttpResponse(null, response);

        when(mockProductService.getProduct(id))
            .thenAnswer((_) async => httpResponse);

        //Act
        final result = await mockProductService.getProduct(id);

        //Assert
        expect(result.data, null);
        expect(result.response.statusCode, 404);
      });
    });
  });
}
