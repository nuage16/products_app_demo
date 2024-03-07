import 'package:dio/dio.dart' hide Headers;
import 'package:products_app_demo/core/constants.dart';
import 'package:products_app_demo/data/models/product_details_model.dart';
import 'package:products_app_demo/data/models/product_list_model.dart';
import 'package:retrofit/retrofit.dart';

part 'product_service.g.dart';

@RestApi(baseUrl: baseUrl)
abstract class ProductService {
  factory ProductService(Dio dio, {String baseUrl}) = _ProductService;

  @GET('/products')
  @Headers(<String, dynamic>{"Content-Type": "application/json"})
  Future<HttpResponse<ProductListModel?>> getProductList(
    @Query("limit") int limit,
    @Query("skip") int skip,
    @Query("select") List<String> select,
  );

  @GET('/products/{id}')
  @Headers(<String, dynamic>{"Content-Type": "application/json"})
  Future<HttpResponse<ProductDetailsModel?>> getProduct(
    @Path("id") int id,
  );
}
