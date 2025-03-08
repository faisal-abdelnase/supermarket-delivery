import 'package:flutter/material.dart';
import 'package:super_market_app/features/Auth/presentation/view/type_of_registeration.dart';
import 'package:super_market_app/features/about/presentation/view/about_app.dart';
import 'package:super_market_app/features/home/presentation/view/home_view.dart';
import 'package:super_market_app/features/splash/presentation/view/splash_view.dart';

void main() {
  runApp(const SuperMarketDelivery());
}

class SuperMarketDelivery extends StatelessWidget {
  const SuperMarketDelivery({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Super Market Delivery",
      debugShowCheckedModeBanner: false,
      routes: <String,WidgetBuilder>{
        "/":(context) => const SplashView(),
        HomeView.homeId: (context) => HomeView(),
        AboutApp.aboutAppId : (context) => AboutApp(),
        TypeOfRegisteration.registeration : (context) => TypeOfRegisteration()
      },
    );
  }
}