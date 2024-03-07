import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:products_app_demo/data/datasources/product_service.dart';
import 'package:products_app_demo/domain/usecases/product_usecase.dart';
import 'package:products_app_demo/presentation/bloc/product_list/product_list_bloc.dart';

import '../data/repositories/product_repository_impl.dart';
import '../domain/repositories/product_repository.dart';
import '../presentation/bloc/product/product_bloc.dart';

final injector = GetIt.instance;

class DependencyManager {
  Future<void> initialize() async {
    WidgetsFlutterBinding.ensureInitialized();
    await initializeDependencies();
  }
}



Future<void> initializeDependencies() async {
  // Dio client
  injector.registerSingleton<Dio>(Dio());

  // Dependencies and API services
  injector.registerSingleton<ProductService>(ProductService(injector()));

  //Repositories
  injector
      .registerSingleton<ProductRepository>(ProductRepositoryImpl(injector()));

  // UseCases
  injector.registerSingleton<GetProductListUsecase>(
      GetProductListUsecase(injector()));
  injector.registerSingleton<GetProductUsecase>(GetProductUsecase(injector()));

  // Blocs
  injector.registerFactory<ProductListBloc>(() => ProductListBloc(injector()));
  injector.registerFactory<ProductBloc>(() => ProductBloc(injector()));
}
