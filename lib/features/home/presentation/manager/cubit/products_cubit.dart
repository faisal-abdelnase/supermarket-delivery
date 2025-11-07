import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:super_market/features/home/data/model/products_model.dart';

part 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  ProductsCubit() : super(ProductsInitial());

  final Dio dio = Dio();

  getAllProducts() async {

    emit(ProductsLodaing());

    List<ProductsModel> products = [];

    try {
      final response = await dio.get('https://vercel-api-five-liard.vercel.app/product');
      if (response.statusCode == 200) {

        List data = response.data;
        products = data.map((product) => ProductsModel.fromJson(product)).toList();

        emit(ProductsSuccess(products: products));
      }
    } catch (e) {
      emit(ProductsError(errorMessage: "Failed to fetch products}"));
    }
  }


}
