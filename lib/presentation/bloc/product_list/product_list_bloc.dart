import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';
import 'package:products_app_demo/core/params/product_params.dart';
import 'package:products_app_demo/domain/entities/product_list_ent.dart';
import 'package:products_app_demo/domain/usecases/product_usecase.dart';

import '../../../core/errors/failure.dart';
import '../../../domain/entities/product_details_ent.dart';

part 'product_list_event.dart';

part 'product_list_state.dart';

class ProductListBloc extends Bloc<ProductListEvent, ProductListState> {
  final GetProductListUsecase usecase;

  ProductListBloc(this.usecase) : super(ProductListInitial()) {
    on<ProductListEvent>((event, emit) async {
      if (event is GetProductListEvent) {
        await _getProductList(event, emit);
      }
    });
  }

  _getProductList(GetProductListEvent event, emit) async {
    emit(LoadingGetProductListState());
    const selectedDetails = [
      'title',
      'price',
      'thumbnail',
      'stock',
      'discountPercentage'
    ];
    ProductListParams params = ProductListParams(
        limit: event.limit, skip: event.skip, select: selectedDetails);

    final failureOrProductList = await usecase(params);

    failureOrProductList.fold((failure) {
      emit(ErrorGetProductListState(failure as ServerFailure));
    }, (list) {
      final List<ProductDetailsEnt> updatedList = List.from(
          event.productList.filter((t) => t.stock != null && t.stock! > 0))
        ..addAll(list.products);
      emit(SuccessGetProductListState(updatedList,
          isMaxReached: _maxTotalChecker(list.total ?? 0, updatedList.length)));
    });
  }

  bool _maxTotalChecker(int maxTotal, int totalFetchedItems) {
    return totalFetchedItems >= maxTotal ? true : false;
  }
}
