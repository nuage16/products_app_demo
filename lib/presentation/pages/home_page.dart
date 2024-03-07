import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:products_app_demo/core/errors/error_widget.dart';
import 'package:products_app_demo/presentation/bloc/product_list/product_list_bloc.dart';
import 'package:products_app_demo/presentation/widgets/product_card.dart';
import 'package:products_app_demo/presentation/widgets/product_grid_view.dart';

import '../../core/bloc_helper.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 32, 20, 16),
        child: Column(
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text(
                'Products Hub',
                style: Theme.of(context).textTheme.displaySmall,
              ),
              const Icon(Icons.person, size: 30)
            ]),
            const SizedBox(height: 8),
            Expanded(
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
            )
          ],
        ),
      ),
    );
  }
}
