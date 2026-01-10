part of 'my_cart_cubit.dart';

sealed class MyCartState{
  const MyCartState();
}

final class MyCartInitial extends MyCartState {}

final class MyCartLoading extends MyCartState {}

final class MyCartSuccess extends MyCartState {}

final class MyCartError extends MyCartState {}

