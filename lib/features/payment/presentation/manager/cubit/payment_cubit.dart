import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:super_market/core/paymob_manager/paymob_manager.dart';
import 'package:super_market/features/payment/data/model/payment_method_model.dart';
import 'package:super_market/features/payment/data/model/payment_result.dart';


part 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit() : super(PaymentInitial());

  PaymobManager paymobManager = PaymobManager();

  PaymentMethod paymentMethod = PaymentMethod.cach;


  


  // Future<void> pay() async {

  //   emit(PaymentLoading());
  //   try{

  //     await paymobManager.pay();
  //     await Future.delayed(const Duration(seconds: 5));
  //     emit(PaymentSuccese());
  //   } catch(e){
  //     emit(PaymentError());
  //   }
  // }

  


  Future<void> processPayment({
  required int amount,
  required String currency,
}) async {
  if (isClosed) return;

  emit(PaymentLoading());

  try {
    await paymobManager.payWithTracking(
      amount: amount,
      currency: currency,
      onPaymentResult: _handlePaymentResult,
    );

    // Payment page opened successfully
    if (!isClosed) {
      emit(PaymentPending());
    }
  } catch (e) {
    if (!isClosed) {
      emit(PaymentError());
    }
  }
}


void _handlePaymentResult(PaymentResult result) {
  if (isClosed) return;

  switch (result.status) {
    case PaymentStatus.success:
      emit(PaymentSuccese());
      break;

    case PaymentStatus.failed:
      emit(PaymentError());
      break;

    case PaymentStatus.canceled:
      emit(PaymentCancel());
      break;

    case PaymentStatus.pending:
      // Avoid spamming pending state
      if (state is! PaymentPending) {
        emit(PaymentPending());
      }
      break;
  }
}


}
