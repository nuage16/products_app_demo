import 'package:flutter_bloc/flutter_bloc.dart';
import '../main.dart';
import '../presentation/bloc/product/product_bloc.dart';
import '../presentation/bloc/product_list/product_list_bloc.dart';

final productBloc =
    BlocProvider.of<ProductBloc>(MyApp.navigatorKey.currentContext!);
final productListBloc =
    BlocProvider.of<ProductListBloc>(MyApp.navigatorKey.currentContext!);
