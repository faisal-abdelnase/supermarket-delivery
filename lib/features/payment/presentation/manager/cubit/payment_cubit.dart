import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:super_market/core/paymob_manager/paymob_manager.dart';


part 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit() : super(PaymentInitial());

  PaymobManager paymobManager = PaymobManager();


  Future<void> pay() async {

    emit(PaymentLoading());

    

    try{

      await paymobManager.pay();
      await Future.delayed(const Duration(seconds: 5));
      emit(PaymentSuccese());
    } catch(e){
      emit(PaymentError());
    }
  }
}
