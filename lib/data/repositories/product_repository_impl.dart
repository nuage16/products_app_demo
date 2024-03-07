import 'dart:io';

import 'package:dio/dio.dart';
import 'package:fpdart/src/either.dart';
import 'package:products_app_demo/core/errors/failure.dart';
import 'package:products_app_demo/core/params/product_params.dart';
import 'package:products_app_demo/data/datasources/product_service.dart';
import 'package:products_app_demo/domain/entities/product_details_ent.dart';
import 'package:products_app_demo/domain/entities/product_list_ent.dart';
import 'package:products_app_demo/domain/repositories/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  ProductRepositoryImpl(this.services);

  final ProductService services;

  @override
  Future<Either<Failure, ProductListEnt>> getProductList(
      ProductListParams params) async {
    try {
      final res = await services.getProductList(
          params.limit, params.skip, params.select);

      if (res.data != null && res.response.statusCode == HttpStatus.ok) {
        return Right(res.data!);
      }

      throw Exception(res.response.statusMessage);
    } on DioException catch (e) {
      return Left(
          ServerFailure(e.response?.statusMessage ?? 'An error occured.'));
    }
  }

  @override
  Future<Either<Failure, ProductDetailsEnt>> getProduct(
      ProductParams params) async {
    try {
      final res = await services.getProduct(params.id);

      if (res.data != null && res.response.statusCode == HttpStatus.ok) {
        return Right(res.data!);
      }

      throw Exception(res.response.statusMessage);
    } on DioException catch (e) {
      return Left(
          ServerFailure(e.response?.statusMessage ?? 'An error occured.'));
    }
  }
}
