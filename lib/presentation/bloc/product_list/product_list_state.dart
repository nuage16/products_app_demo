part of 'product_list_bloc.dart';

abstract class ProductListState extends Equatable {
  const ProductListState();

  @override
  List<Object> get props => [];
}

class ProductListInitial extends ProductListState {}

class LoadingGetProductListState extends ProductListState {}

class SuccessGetProductListState extends ProductListState {
  final List<ProductDetailsEnt> productList;
  final bool isMaxReached;

  const SuccessGetProductListState(this.productList, {required this.isMaxReached});

  @override
  List<Object> get props => [productList, isMaxReached];
}

class ErrorGetProductListState extends ProductListState {
  const ErrorGetProductListState(this.failure);

  final ServerFailure failure;
}
