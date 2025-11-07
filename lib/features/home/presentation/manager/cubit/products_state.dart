part of 'products_cubit.dart';

sealed class ProductsState extends Equatable {
  const ProductsState();

  @override
  List<Object> get props => [];
}

final class ProductsInitial extends ProductsState {}
final class ProductsLodaing extends ProductsState {}
final class ProductsSuccess extends ProductsState {
  final List<ProductsModel> products;

  const ProductsSuccess({required this.products});
}
final class ProductsError extends ProductsState {
  final String errorMessage;

  const ProductsError({required this.errorMessage});
}
