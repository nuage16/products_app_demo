import 'package:flutter/material.dart';
import 'package:products_app_demo/domain/entities/product_details_ent.dart';
import 'package:products_app_demo/presentation/pages/product_detail_page.dart';
import 'package:products_app_demo/presentation/widgets/product_card.dart';

class ProductGridView extends StatefulWidget {
  const ProductGridView(
      {super.key,
      required this.productList,
      required this.fetchMoreProducts,
      required this.isMaxReached});

  final List<ProductDetailsEnt> productList;
  final Function fetchMoreProducts;
  final bool isMaxReached;

  @override
  State<ProductGridView> createState() => _ProductGridViewState();
}

class _ProductGridViewState extends State<ProductGridView> {
  final _scrollCtrl = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollCtrl.addListener(() {
      if (_scrollCtrl.position.maxScrollExtent == _scrollCtrl.offset) {
        widget.fetchMoreProducts();
      }
    });
  }

  @override
  void dispose() {
    _scrollCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(controller: _scrollCtrl, slivers: <Widget>[
      SliverGrid(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            childAspectRatio: 4 / 5,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20),
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            return ProductCard(
                product: widget.productList[index],
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ProductDetailPage(widget.productList[index])));
                });
          },
          childCount: widget.productList.length,
        ),
      ),
      if (!widget.isMaxReached)
        const SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Center(child: CircularProgressIndicator()),
          ),
        )
    ]);
  }
}
