import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:products_app_demo/core/errors/failure.dart';
import 'package:products_app_demo/core/params/product_params.dart';
import 'package:products_app_demo/domain/entities/product_details_ent.dart';
import 'package:products_app_demo/domain/usecases/product_usecase.dart';
import 'package:products_app_demo/presentation/bloc/product/product_bloc.dart';

import 'product_bloc_test.mocks.dart';


@GenerateNiceMocks([MockSpec<GetProductUsecase>()])
void main() {
  late ProductBloc bloc;
  late MockGetProductUsecase mockUsecase;

  setUp(() {
    mockUsecase = MockGetProductUsecase();
    bloc = ProductBloc(mockUsecase);
  });

  tearDown(() {
    bloc.close();
  });

  group('Test ProductBloc', () {
    const int id = 1;
    const product =  ProductDetailsEnt(
      id: id,
      title: 'Test Product');
    const failure = ServerFailure('Test failure');
    provideDummy<Either<Failure, ProductDetailsEnt>>((const Right(product)));


    blocTest<ProductBloc, ProductState>(
      'should emit [LoadingGetProductState, SuccessGetProductState] '
          'when GetProductDetailsEvent is added successfully',
      build: () {
        when(mockUsecase(const ProductParams(id: id)))
            .thenAnswer((_) async => const Right(product));
        return bloc;
      },
      act: (bloc) => bloc.add(const GetProductDetailsEvent(id)),
      expect: () => [
        LoadingGetProductState(),
        const SuccessGetProductState(product),
      ],
    );

    blocTest<ProductBloc, ProductState>(
      'emits [LoadingGetProductState, ErrorGetProductState] '
          'when GetProductDetailsEvent encounters an error',
      build: () {
        when(mockUsecase(const ProductParams(id: id)))
            .thenAnswer((_) async => const Left(failure));
        return bloc;
      },
      act: (bloc) => bloc.add(const GetProductDetailsEvent(id)),
      expect: () => [
        LoadingGetProductState(),
        const ErrorGetProductState(failure),
      ],
    );
  });
}
