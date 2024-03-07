import 'dart:convert';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:products_app_demo/core/errors/failure.dart';
import 'package:products_app_demo/core/params/product_params.dart';
import 'package:products_app_demo/data/models/product_list_model.dart';
import 'package:products_app_demo/domain/entities/product_list_ent.dart';
import 'package:products_app_demo/domain/usecases/product_usecase.dart';
import 'package:products_app_demo/presentation/bloc/product_list/product_list_bloc.dart';

import '../../fixtures/fixture_reader.dart';
import '../../presentation/bloc/product_list_bloc_test.mocks.dart';

@GenerateNiceMocks([MockSpec<GetProductListUsecase>()])
void main() {
  late ProductListBloc bloc;
  late MockGetProductListUsecase mockGetProductListUsecase;

  setUp(() {
    mockGetProductListUsecase = MockGetProductListUsecase();
    bloc = ProductListBloc(mockGetProductListUsecase);
  });

  tearDown(() {
    bloc.close();
  });

  group('Test ProductListBloc', () {
    const productListParams = ProductListParams(limit: 2, skip: 0, select: []);
    final productList = ProductListModel.fromJson(
        jsonDecode(fixtures('product_list_inc.json')));
    const failure = ServerFailure('Test failure');

    blocTest<ProductListBloc, ProductListState>(
      'should emit [LoadingGetProductListState, SuccessGetProductListState] '
      'when GetProductListEvent is added successfully',
      build: () {
        provideDummy<Either<Failure, ProductListEnt>>((Right(productList)));
        when(mockGetProductListUsecase(productListParams))
            .thenAnswer((_) async => Right(productList));
        return bloc;
      },
      act: (bloc) => bloc.add(const GetProductListEvent(
        limit: 2,
        skip: 0,
        productList: [],
      )),
      expect: () => [
        LoadingGetProductListState(),
        SuccessGetProductListState(productList.products, isMaxReached: true),
      ],
    );

    blocTest<ProductListBloc, ProductListState>(
      'should emit [LoadingGetProductListState, ErrorGetProductListState] '
      'when GetProductListEvent encounters an error',
      build: () {
        provideDummy<Either<Failure, ProductListEnt>>((const Left(failure)));

        when(mockGetProductListUsecase(productListParams))
            .thenAnswer((_) async => const Left(failure));
        return bloc;
      },
      act: (bloc) => bloc.add(const GetProductListEvent(
        limit: 2,
        skip: 0,
        productList: [],
      )),
      expect: () => [
        LoadingGetProductListState(),
        const ErrorGetProductListState(failure),
      ],
    );

  });
}
