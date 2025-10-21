
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:super_market/constant.dart';
import 'package:super_market/features/Auth/presentation/manager/bloc/auth_bloc.dart';
import 'package:super_market/features/Auth/presentation/view/forgot_password.dart';
import 'package:super_market/features/Auth/presentation/view/otp_page.dart';
import 'package:super_market/features/Auth/presentation/view/phone_auth.dart';
import 'package:super_market/features/Auth/presentation/view/reset_passowrd.dart';
import 'package:super_market/features/Auth/presentation/view/sign_in.dart';
import 'package:super_market/features/Auth/presentation/view/sign_up.dart';
import 'package:super_market/features/Auth/presentation/view/type_of_registeration.dart';
import 'package:super_market/features/about/presentation/view/about_app.dart';
import 'package:super_market/features/home/presentation/view/home_view.dart';
import 'package:super_market/features/home/presentation/view/product_details_view.dart';
import 'package:super_market/features/home/presentation/view/search_by_filter.dart';
import 'package:super_market/features/payment/presentation/view/checkout_view.dart';
import 'package:super_market/features/payment/presentation/view/delivery_address_view.dart';
import 'package:super_market/features/payment/presentation/view/my_cart.dart';
import 'package:super_market/features/payment/presentation/view/payment_method_view.dart';
import 'package:super_market/features/profile/data/model/user_info.dart';
import 'package:super_market/features/profile/presentation/manager/cubit/profile_info_cubit.dart';
import 'package:super_market/features/profile/presentation/view/my_order_view.dart';
import 'package:super_market/features/profile/presentation/view/my_profile_view.dart';
import 'package:super_market/features/splash/presentation/view/splash_view.dart';
import 'package:super_market/firebase_options.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,);
    
  await Hive.initFlutter();
  Hive.registerAdapter(UserInfoAdapter());
  await Hive.openBox<UserInfoModel>(kProfileBox);


  runApp(const SuperMarketDelivery());
}


class SuperMarketDelivery extends StatelessWidget {
  const SuperMarketDelivery({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        BlocProvider(create: (context) => AuthBloc(),),
        BlocProvider(create: (context) => ProfileInfoCubit(),),
      ],
      child: MaterialApp(
        title: "Super Market Delivery",
        debugShowCheckedModeBanner: false,
        routes: <String,WidgetBuilder> {
          "/":(context) => const SplashView(),
          HomeView.homeId: (context) => HomeView(),
          AboutApp.aboutAppId : (context) => AboutApp(),
          TypeOfRegisteration.registeration : (context) => TypeOfRegisteration(),
          SignUpPage.signUpId : (context) => SignUpPage(),
          SignInPage.signInId : (context) => SignInPage(),
          ForgotPassword.forgetPasswordId : (context) => ForgotPassword(),
          OtpPage.otpPageId : (context) => OtpPage(),
          ResetPassowrd.resetPasswordId :(context) => ResetPassowrd(),
          SearchByFilter.searchByFilterId : (context) => SearchByFilter(),
          ProductDetailsView.productDetailsId : (context) => ProductDetailsView(),
          MyCart.myCartId: (context) => MyCart(),
          CheckoutView.checkoutId : (context) => CheckoutView(),
          DeliveryAddressView.addressViewID : (context) => DeliveryAddressView(),
          MyProfileView.myProfileId :(context) => MyProfileView(),
          MyOrderView.myOrderId :(context) => MyOrderView(),
          PaymentMethodView.paymentMethodId :(context) => PaymentMethodView(),
          PhoneAuth.phoneAuthId :(context) => PhoneAuth(),
        },
      ),
    );
  }
}