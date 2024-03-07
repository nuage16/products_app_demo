import 'package:flutter/material.dart';
import 'package:products_app_demo/domain/entities/product_details_ent.dart';
import 'package:products_app_demo/presentation/widgets/custom_network_image.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.product, required this.onTap});

  final ProductDetailsEnt product;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).cardColor,
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: () => onTap(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(
            children: [
              if (product.thumbnail != null)
                Center(
                  child: Column(
                    children: [
                      SizedBox(
                          height: 100,
                          child:
                              CustomNetworkImage(imgUrl: product.thumbnail!)),
                      const Spacer(),
                      Text(product.title ?? 'Unknown',
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          style: Theme.of(context).textTheme.titleMedium),
                      const Spacer(),
                      Text("\$${(product.price?.toStringAsFixed(2)) ?? 0.00}",
                          style: Theme.of(context).textTheme.titleLarge),
                    ],
                  ),
                ),
              if (product.discountPercentage != null)
                Positioned(
                    child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                  decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(8)),
                  child: Text(
                    '${product.discountPercentage!.ceil()}%',
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w500),
                  ),
                )),
            ],
          ),
        ),
      ),
    );
  }
}
