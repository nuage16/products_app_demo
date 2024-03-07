import 'package:flutter_test/flutter_test.dart';
import 'dart:convert';

import 'package:products_app_demo/data/models/product_details_model.dart';
import 'package:products_app_demo/domain/entities/product_details_ent.dart';

import '../../fixtures/fixture_reader.dart';

void main() {
  const productModel = ProductDetailsModel(
    id: 1,
    title: "iPhone 9",
    description: "An apple mobile which is nothing like apple",
    price: 549,
    discountPercentage: 12.96,
    rating: 4.69,
    stock: 94,
    brand: "Apple",
    category: "smartphones",
    thumbnail: "https://cdn.dummyjson.com/product-images/1/thumbnail.jpg",
    images: [
      "https://cdn.dummyjson.com/product-images/1/1.jpg",
      "https://cdn.dummyjson.com/product-images/1/2.jpg",
      "https://cdn.dummyjson.com/product-images/1/3.jpg",
      "https://cdn.dummyjson.com/product-images/1/4.jpg",
      "https://cdn.dummyjson.com/product-images/1/thumbnail.jpg"
    ],
  );
  const productIncModel = ProductDetailsModel(
      id: 1,
      title: "iPhone 9",
      description: "An apple mobile which is nothing like apple",
      images: []);

  test('should be a subclass of ProductDetails entity', () async {
    // Assert
    expect(productModel, isA<ProductDetailsEnt>());
  });

  group('Test fromJson.', () {
    test('should return a valid ProductDetailsModel', () async {
      // Arrange
      final Map<String, dynamic> jsonMap =
          json.decode(fixtures('product.json'));

      // Act
      final result = ProductDetailsModel.fromJson(jsonMap);

      // Assert
      expect(result, equals(productModel));
    });

    test('should return a valid ProductDetails even if a field is null', () async {
      //arrange
      final Map<String, dynamic> jsonMap =
          json.decode(fixtures('product_inc.json'));
      //act
      final result = ProductDetailsModel.fromJson(jsonMap);
      //assert
      expect(result, equals(productIncModel));
    });
  });

  group('Test toJson.', () {
    test('should return a valid json map', () async {
      // Act
      final result = productModel.toJson();
      // Assert
      final expectedMap = json.decode(fixtures('product.json'));

      expect(result, equals(expectedMap));
    });
  });
}
