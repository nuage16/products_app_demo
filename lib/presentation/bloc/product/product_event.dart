part of 'product_bloc.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object?> get props => [];
}

class GetProductDetailsInitial extends ProductEvent {
}

class GetProductDetailsEvent extends ProductEvent {
  const GetProductDetailsEvent(this.id);

  final int id;
}
