

import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:products_app_demo/core/utils/extensions/discount_calculator_ext.dart';

void main (){

  group('Test Discount Calculator extension.', () {

    test('should return discounted price when discount is greater than 0', () {
      // Arrange
      const double price = 100;
      const double discount = 15.3;
      const double expectedPrice = 84.7;

      //Act
      final result = price.toDiscountedPrice(discount);

      //Assert
      expect(result, expectedPrice);

    });

    test('should return the original price when discount is null', () {
      //Arrange
      const double price = 100;
      //Act
      final result = price.toDiscountedPrice(null);

      //Assert
      expect(result,price);
    });
    test('should return the original price when discount is 0', () {
      //Arrange
      const double price = 100;
      //Act
      final result = price.toDiscountedPrice(0);

      //Assert
      expect(result,price);
    });


    test('should return 0.00 when discount is 100', () {
      //Arrange
      const double price = 100;
      const double discount = 100;
      const double expectedPrice = 0;
      //Act
      final result = price.toDiscountedPrice(discount);

      //Assert
      expect(result,expectedPrice);
    });
    test('should return negative value when discount is greater than 100', () {
      //Arrange
      const double price = 100;
      const double discount = 110;
      const double expectedPrice = -10;
      //Act
      final result = price.toDiscountedPrice(discount);

      //Assert
      expect(result,expectedPrice);
    });

  });

}