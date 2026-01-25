import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:super_market/core/paymob_manager/paymob_manager.dart';
import 'package:super_market/core/services/firebase_service.dart';
import 'package:super_market/features/payment/data/model/cart_info_model.dart';
import 'package:super_market/features/payment/data/model/payment_method_model.dart';
import 'package:super_market/features/payment/data/model/payment_result.dart';


part 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit() : super(PaymentInitial());

  PaymobManager paymobManager = PaymobManager();

  PaymentMethod paymentMethod = PaymentMethod.cach;
  FirebaseService firebaseService = FirebaseService();


    // Store order details for Firebase

  double? _currentAmount;
  String? _currentCurrency;
  List<CartInfoModel>? _currentItems;


  Future<void> processPayment({
  required double amount,
  required String currency,
  required List<CartInfoModel> items,
}) async {
  if (isClosed) return;

  emit(PaymentLoading());

   // Store order details for later use
    _currentAmount = amount;
    _currentCurrency = currency;
    _currentItems = items;

    if(items.isEmpty){
      emit(PaymentError(errorMessage:  "Please add items to cart before proceeding to payment."));
      return;
    }

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
      emit(PaymentError(errorMessage: "Failed to process payment. Please try again later."));
    }
  }
}


void _handlePaymentResult(PaymentResult result) async {
  if (isClosed) return;

  switch (result.status)  {
    case PaymentStatus.success:
      try {
          if (result.transactionId != null && 
              _currentAmount != null && 
              _currentCurrency != null &&
              _currentItems != null) {
            
            await firebaseService.createOrderInFirestore(
              orderId: int.parse(result.transactionId!),
              amount: _currentAmount!,
              currency: _currentCurrency!,
              items: _currentItems!,
              paymentMethod: paymentMethod
            );
            
            if (!isClosed) {
              emit(PaymentSuccese());
            }
          } else {
            // Missing required data
            if (!isClosed) {
              emit(PaymentError(errorMessage: "Incomplete payment data."));
            }
          }
        } catch (e) {
          // Firebase creation failed
          if (!isClosed) {
            emit(PaymentError(errorMessage: "Failed to save order details."));
          }
        }
      break;

    case PaymentStatus.failed:
      emit(PaymentError(errorMessage: result.message ?? "Payment failed. Please try again."));
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
