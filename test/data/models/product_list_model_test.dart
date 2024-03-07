import 'package:flutter_test/flutter_test.dart';
import 'dart:convert';

import 'package:products_app_demo/data/models/product_details_model.dart';
import 'package:products_app_demo/data/models/product_list_model.dart';
import 'package:products_app_demo/domain/entities/product_list_ent.dart';

import '../../fixtures/fixture_reader.dart';

void main() {
  const productListModel = ProductListModel(
    products: [
      ProductDetailsModel(
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
      ),
      ProductDetailsModel(
        id: 2,
        title: "iPhone X",
        description:
            "SIM-Free, Model A19211 6.5-inch Super Retina HD display with OLED technology A12 Bionic chip with ...",
        price: 899,
        discountPercentage: 17.94,
        rating: 4.44,
        stock: 34,
        brand: "Apple",
        category: "smartphones",
        thumbnail: "https://cdn.dummyjson.com/product-images/2/thumbnail.jpg",
        images: [
          "https://cdn.dummyjson.com/product-images/2/1.jpg",
          "https://cdn.dummyjson.com/product-images/2/2.jpg",
          "https://cdn.dummyjson.com/product-images/2/3.jpg",
          "https://cdn.dummyjson.com/product-images/2/thumbnail.jpg"
        ],
      ),
    ],
    total: 2,
    skip: 0,
    limit: 2,
  );

  test('should be a subclass of ProductList entity', () async {
    // Assert
    expect(productListModel, isA<ProductListEnt>());
  });

  group('Test fromJson.', () {
    test('should return a valid ProductListModel', () async {
      // Arrange
      final Map<String, dynamic> jsonMap =
          json.decode(fixtures('product_list.json'));
      //act
      final result = ProductListModel.fromJson(jsonMap);
      //assert
      expect(result, equals(productListModel));
    });
  });

  group('Test toJson.', () {
    test('should return a valid json map', () async {
      // Act
      final result = productListModel.toJson();
      // Assert
      final expectedMap = json.decode(fixtures('product_list.json'));
      expect(result, equals(expectedMap));
    });
  });
}
