import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:products_app_demo/core/bloc_helper.dart';
import 'package:products_app_demo/core/utils/extensions/discount_calculator_ext.dart';
import 'package:products_app_demo/core/utils/extensions/string_ext.dart';
import 'package:products_app_demo/domain/entities/product_details_ent.dart';
import 'package:products_app_demo/presentation/bloc/product/product_bloc.dart';
import 'package:products_app_demo/presentation/widgets/custom_network_image.dart';
import 'package:products_app_demo/presentation/widgets/custom_rich_text.dart';

import '../../core/errors/error_widget.dart';

class ProductDetailPage extends StatefulWidget {
  const ProductDetailPage(this.initProduct, {super.key});

  final ProductDetailsEnt initProduct;

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  final CarouselController _carouselCtrl = CarouselController();
  late ProductDetailsEnt product;

  @override
  void initState() {
    super.initState();
    productBloc.add(GetProductDetailsEvent(widget.initProduct.id));
    product = widget.initProduct;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async =>
            productBloc.add(GetProductDetailsEvent(product.id)),
        child: Stack(
          children: [
            BlocBuilder<ProductBloc, ProductState>(
              builder: (context, state) {
                if (state is SuccessGetProductState) {
                  product = state.product;

                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                            padding: const EdgeInsets.only(
                                top: kTextTabBarHeight + 32),
                            height: MediaQuery.of(context).size.height * 0.5,
                            child: product.images!.isEmpty
                                ? const Text('Product has no images')
                                : CarouselSlider.builder(
                                    itemCount: product.images?.length ?? 0,
                                    carouselController: _carouselCtrl,
                                    itemBuilder: (BuildContext context,
                                        int itemIndex, int pageViewIndex) {
                                      return CustomNetworkImage(
                                          imgUrl: product.images![itemIndex]!);
                                    },
                                    options: CarouselOptions(
                                      height: 400,
                                      aspectRatio: 16 / 9,
                                      viewportFraction: 0.8,
                                      initialPage: 0,
                                      enableInfiniteScroll: true,
                                      reverse: false,
                                      autoPlay: false,
                                      autoPlayInterval:
                                          const Duration(seconds: 3),
                                      autoPlayAnimationDuration:
                                          const Duration(milliseconds: 800),
                                      autoPlayCurve: Curves.fastOutSlowIn,
                                      enlargeCenterPage: true,
                                      enlargeFactor: 0.3,
                                      onPageChanged:
                                          (index, carouselPageReason) {},
                                      scrollDirection: Axis.horizontal,
                                    ),
                                  )),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(product.title ?? 'Title',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineLarge!
                                      .copyWith(fontWeight: FontWeight.bold)),
                              Text(product.brand ?? 'No brand',
                                  style:
                                      Theme.of(context).textTheme.titleMedium),
                              const SizedBox(height: 16),
                              Row(children: [
                                Text(
                                    '\$${product.price?.toStringAsFixed(2) ?? '0.00'}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(
                                            color: Colors.black54,
                                            decoration:
                                                TextDecoration.lineThrough)),
                                const SizedBox(width: 8),
                                Text(
                                    '\$${_discountedPrice(product.price, product.discountPercentage)}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall),
                              ]),
                              const SizedBox(height: 32),
                              Row(children: [
                                const Icon(Icons.grid_view_rounded),
                                const SizedBox(width: 4),
                                Text(product.category?.toTitleCase() ?? ''),
                                const Spacer(flex: 1),
                                const Icon(Icons.inventory),
                                const SizedBox(width: 4),
                                Text(product.stock.toString(),
                                    style:
                                        Theme.of(context).textTheme.bodyLarge),
                                const Spacer(flex: 1),
                                Icon(Icons.star, color: Colors.amber),
                                const SizedBox(width: 4),
                                Text(product.rating!.toStringAsFixed(1),
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium),
                                const Spacer(flex: 5),
                              ]),
                              const SizedBox(height: 16),
                              const Divider(height: 1),
                              const SizedBox(height: 16),
                              Text('Description',
                                  style:
                                      Theme.of(context).textTheme.titleMedium),
                              const SizedBox(height: 4),
                              Text(
                                product.description ?? 'No Description',
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }
                if (state is ErrorGetProductState) {
                  return CustomErrorWidget(
                    message: state.failure.message,
                    retryFunc: () =>
                        productBloc.add(GetProductDetailsEvent(product.id)),
                  );
                }

                return const Center(child: CircularProgressIndicator());
              },
            ),
            Positioned(
              top: 24,
              left: 4,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                ),
                child: const Icon(Icons.arrow_back_rounded),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _discountedPrice(double? price, double? discount) {
    return price?.toDiscountedPrice(discount).toString() ?? '0.00';
  }
}
