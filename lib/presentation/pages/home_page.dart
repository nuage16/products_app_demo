import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:products_app_demo/core/errors/error_widget.dart';
import 'package:products_app_demo/presentation/bloc/product_list/product_list_bloc.dart';
import 'package:products_app_demo/presentation/widgets/product_grid_view.dart';

import '../../core/bloc_helper.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(
                  20, 0, 20, 16),
              child: BlocBuilder<ProductListBloc, ProductListState>(
                buildWhen: (previous, current) =>
                current is! LoadingGetProductListState,
                builder: (context, state) {
                  if (state is ErrorGetProductListState) {
                    return CustomErrorWidget(
                        message: state.failure.message,
                        retryFunc: () => productListBloc.add(
                            const GetProductListEvent(
                                skip: 0, productList: [])));
                  }

                  if (state is SuccessGetProductListState) {
                    if (state.productList.isEmpty) {
                      const Center(child: Text('No products available.'));
                    } else {
                      return ProductGridView(
                          fetchMoreProducts: () {
                            productListBloc.add(
                              GetProductListEvent(
                                  productList: state.productList,
                                  skip: state.productList.length),
                            );
                          },
                          productList: state.productList,
                          isMaxReached: state.isMaxReached);
                    }
                  }

                  return const Center(child: CircularProgressIndicator());
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              height: MediaQuery.of(context).size.height * 0.1,
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius:
                      const BorderRadius.only(bottomLeft: Radius.circular(64))),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'AllProducts',
                      style: Theme.of(context)
                          .textTheme
                          .displaySmall!
                          .copyWith(color: Colors.white),
                    ),
                    const Icon(Icons.person, size: 30, color: Colors.white)
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
