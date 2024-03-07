import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:products_app_demo/presentation/bloc/product/product_bloc.dart';
import 'package:products_app_demo/presentation/bloc/product_list/product_list_bloc.dart';
import 'package:products_app_demo/presentation/pages/home_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/injector.dart';

void main() async {
  //Initialize dependencies
  await DependencyManager().initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ProductBloc>(
          create: (_) => injector()..add(GetProductDetailsInitial()),
        ),
        BlocProvider<ProductListBloc>(
          create: (_) => injector()
            ..add(const GetProductListEvent(skip: 0, productList: [])),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Products Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          textTheme: GoogleFonts.poppinsTextTheme(),
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
          useMaterial3: true,
        ),
        home: const HomePage(),
        key: MyApp.navigatorKey,
      ),
    );
  }
}
