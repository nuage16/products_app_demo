part of 'product_list_bloc.dart';

abstract class ProductListEvent extends Equatable {
  const ProductListEvent();

  @override
  List<Object?> get props => [];
}

class GetProductListEvent extends ProductListEvent {
  const GetProductListEvent(
      {this.limit = 10, required this.skip, required this.productList});

  final List<ProductDetailsEnt> productList;
  final int skip;
  final int limit;
}
