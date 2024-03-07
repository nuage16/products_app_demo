// Mocks generated by Mockito 5.4.4 from annotations
// in products_app_demo/test/domain/usecases/get_product_list_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:fpdart/src/either.dart' as _i5;
import 'package:mockito/mockito.dart' as _i1;
import 'package:mockito/src/dummies.dart' as _i9;
import 'package:products_app_demo/core/errors/failure.dart' as _i6;
import 'package:products_app_demo/core/params/product_params.dart' as _i8;
import 'package:products_app_demo/domain/entities/product_list_ent.dart' as _i7;
import 'package:products_app_demo/domain/repositories/product_repository.dart'
    as _i2;
import 'package:products_app_demo/domain/usecases/product_usecase.dart' as _i3;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeProductRepository_0 extends _i1.SmartFake
    implements _i2.ProductRepository {
  _FakeProductRepository_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [GetProductListUsecase].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetProductListUsecase extends _i1.Mock
    implements _i3.GetProductListUsecase {
  @override
  _i2.ProductRepository get productRepository => (super.noSuchMethod(
        Invocation.getter(#productRepository),
        returnValue: _FakeProductRepository_0(
          this,
          Invocation.getter(#productRepository),
        ),
        returnValueForMissingStub: _FakeProductRepository_0(
          this,
          Invocation.getter(#productRepository),
        ),
      ) as _i2.ProductRepository);

  @override
  _i4.Future<_i5.Either<_i6.Failure, _i7.ProductListEnt>> call(
          _i8.ProductListParams? params) =>
      (super.noSuchMethod(
        Invocation.method(
          #call,
          [params],
        ),
        returnValue:
            _i4.Future<_i5.Either<_i6.Failure, _i7.ProductListEnt>>.value(
                _i9.dummyValue<_i5.Either<_i6.Failure, _i7.ProductListEnt>>(
          this,
          Invocation.method(
            #call,
            [params],
          ),
        )),
        returnValueForMissingStub:
            _i4.Future<_i5.Either<_i6.Failure, _i7.ProductListEnt>>.value(
                _i9.dummyValue<_i5.Either<_i6.Failure, _i7.ProductListEnt>>(
          this,
          Invocation.method(
            #call,
            [params],
          ),
        )),
      ) as _i4.Future<_i5.Either<_i6.Failure, _i7.ProductListEnt>>);
}