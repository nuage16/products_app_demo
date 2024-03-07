part of 'product_bloc.dart';

abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

class ProductInitial extends ProductState {}

class LoadingGetProductState extends ProductState {}

class SuccessGetProductState extends ProductState {
  final ProductDetailsEnt product;

  const SuccessGetProductState(this.product);
}

class ErrorGetProductState extends ProductState {
  const ErrorGetProductState(this.failure);

  final ServerFailure failure;
}
