part of 'orders_cubit.dart';

sealed class OrdersState extends Equatable {
  const OrdersState();

  @override
  List<Object> get props => [];
}

final class OrdersInitial extends OrdersState {}
final class OrdersLoading extends OrdersState {}
final class OrdersSuccess extends OrdersState {}
final class OrdersError extends OrdersState {
  final String errMessage;

  const OrdersError({required this.errMessage});
  
}
