import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:super_market_app/features/home/presentation/view/home_details_view.dart';
import 'package:super_market_app/features/payment/presentation/view/my_cart.dart';
import 'package:super_market_app/features/profile/presentation/view/my_profile_view.dart';


class HomeView extends StatefulWidget {
  const HomeView({super.key});

  static const homeId = "/homeView";

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  int currentIndex = 0;
  List<Widget> pages =  [
    const HomeDetailsView(),
    const Center(child: Text("Favorite")),
    const MyCart(),
    const MyProfileView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],


      bottomNavigationBar: CurvedNavigationBar(
        items: const [
          Icon(Icons.home_outlined),
          Icon(Icons.favorite_border),
          Icon(Icons.shopping_cart_outlined),
          Icon(Icons.person_outline_outlined)
        ],

        animationDuration: Duration(milliseconds: 400),

        index: currentIndex,
        height: 60,
        onTap: (index) {
          currentIndex = index;
          setState(() {});
        },
      ),
    );
  }
}



