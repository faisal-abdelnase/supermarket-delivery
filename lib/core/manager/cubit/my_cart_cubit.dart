import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:super_market/features/home/data/model/products_model.dart';
import 'package:super_market/features/payment/data/model/cart_info_model.dart';
import 'package:super_market/features/payment/data/model/reset_cart_model.dart';

part 'my_cart_state.dart';

class MyCartCubit extends Cubit<MyCartState> {
  MyCartCubit() : super(MyCartInitial());

  List<CartInfoModel> productsCart = [];

  ResetCartModel resetCart = ResetCartModel(totalItem: 0, subTotal: 0, vat: 0, shippingFee: 0, totalPayable: 0);


  void addProductToCart(ProductsModel product, int quantity){
    try{

      productsCart.add(
        CartInfoModel(
        id: product.id, 
        image: product.image, 
        poductName: product.name, 
        description: product.description, 
        productPrice: product.price.toString(), 
        productQuantity: quantity)
      );

      resetCart.totalItem = productsCart.fold(
      0,
      (sum, item) => sum + item.productQuantity,
      );

      resetCart.subTotal = resetCart.subTotal + product.price * quantity;
      resetCart.totalPayable = resetCart.subTotal + resetCart.vat + resetCart.shippingFee;

      emit(MyCartSuccess());
    } 
    catch(e){
      emit(MyCartError());
    }
  }


  void updateQuantity({
  required String productId,
  required int newQuantity,
}) {
  try {
    final index =
        productsCart.indexWhere((item) => item.id == productId);

    if (index == -1) return;

    final oldItem = productsCart[index];
    final price = double.parse(oldItem.productPrice);

    // Remove old subtotal
    resetCart.subTotal -= price * oldItem.productQuantity;

    // Replace item (IMMUTABLE)
    productsCart[index] = oldItem.copyWith(
      productQuantity: newQuantity,
    );

    // Add new subtotal
    resetCart.subTotal += price * newQuantity;

    resetCart.totalItem = productsCart.fold(
      0,
      (sum, item) => sum + item.productQuantity,
    );

    resetCart.totalPayable =
        resetCart.subTotal + resetCart.vat + resetCart.shippingFee;

    emit(MyCartSuccess());
  } catch (e) {
    log(e.toString());
  }
}



  void removeFromCart(String productId) {
  final index =
      productsCart.indexWhere((item) => item.id == productId);

  if (index == -1) return;

  final item = productsCart[index];
  final price = double.parse(item.productPrice);

  resetCart.subTotal -= price * item.productQuantity;

  productsCart.removeAt(index);

  resetCart.totalItem = productsCart.fold(
    0,
    (sum, item) => sum + item.productQuantity,
  );

  resetCart.totalPayable =
      resetCart.subTotal + resetCart.vat + resetCart.shippingFee;

  emit(MyCartSuccess());
}





  void getProductFromCart(){

    for(CartInfoModel item in productsCart){

      log(item.poductName);



    }
  }
}
