import 'package:flutter_test/flutter_test.dart';
import 'package:products_app_demo/core/utils/extensions/string_ext.dart';

void main() {

  group('Test String Capitalize extension', () {

    test('should capitalize given string', () {
      // Arrange
      const inputString = 'hello';
      const expectedOutput = 'Hello';

      // Act
      final result = inputString.toTitleCase();

      // Assert
      expect(result, expectedOutput);
    });

    test('should capitalize given string with more than one word', () {
      // Arrange
      const inputString = 'hello world!';
      const expectedOutput = 'Hello World!';

      // Act
      final result = inputString.toTitleCase();

      // Assert
      expect(result, expectedOutput);
    });

    test('should capitalize empty string', () {
      // Arrange
      const inputString = '';
      const expectedOutput = '';

      // Act
      final result = inputString.toTitleCase();

      // Assert
      expect(result, expectedOutput);
    });



    test('should capitalize empty leading and extra string', () {
      // Arrange
      const inputString = ' hello thEre ';
      const expectedOutput = ' Hello There ';

      // Act
      final result = inputString.toTitleCase();

      // Assert
      expect(result, expectedOutput);
    });

  });







}
