import 'dart:convert';

import 'package:products_app_demo/data/models/product_details_model.dart';
import 'package:products_app_demo/domain/entities/product_details_ent.dart';
import 'package:products_app_demo/domain/entities/product_list_ent.dart';

ProductListModel productListEntFromJson(String str) =>
    ProductListModel.fromJson(json.decode(str));

String productListEntToJson(ProductListModel data) =>
    json.encode(data.toJson());

class ProductListModel extends ProductListEnt {
  final List<ProductDetailsEnt> products;
  final int? total;
  final int? skip;
  final int? limit;

  const ProductListModel({
    required this.products,
    this.total,
    this.skip,
    this.limit,
  }) : super(products: products, total: total, skip: skip, limit: limit);

  factory ProductListModel.fromJson(Map<String, dynamic> json) =>
      ProductListModel(
        products: List<ProductDetailsEnt>.from(
            json["products"].map((x) => ProductDetailsModel.fromJson(x))),
        total: json["total"],
        skip: json["skip"],
        limit: json["limit"],
      );

  Map<String, dynamic> toJson() => {
        "products": List<dynamic>.from(
            products.map((x) => (x as ProductDetailsModel).toJson())),
        "total": total,
        "skip": skip,
        "limit": limit,
      };
}
