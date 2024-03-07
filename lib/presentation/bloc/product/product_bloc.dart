import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:products_app_demo/core/errors/failure.dart';
import 'package:products_app_demo/core/params/product_params.dart';
import 'package:products_app_demo/domain/entities/product_details_ent.dart';

import '../../../domain/usecases/product_usecase.dart';

part 'product_event.dart';

part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final GetProductUsecase usecase;

  ProductBloc(this.usecase) : super(ProductInitial()) {
    on<ProductEvent>((event, emit) async {
      if (event is GetProductDetailsEvent) {
        return await _getProductDetails(emit, event.id);
      }
    });
  }

  _getProductDetails(emit, int id) async {
    emit(LoadingGetProductState());

    ProductParams params = ProductParams(id: id);

    final failureOrProduct = await usecase(params);

    failureOrProduct.fold((failure) {
      emit(ErrorGetProductState(failure as ServerFailure));
    }, (product) {
        emit(SuccessGetProductState(product));
    });
  }

}
