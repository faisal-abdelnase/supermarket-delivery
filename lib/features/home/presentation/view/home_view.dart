import 'package:flutter/material.dart';
import 'package:super_market_app/features/home/presentation/view/widgets/header_home_page.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  static const homeId = "/homeView";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: true,
        child: CustomScrollView(
          slivers: [

            
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                child: HeaderHomePage(),
              ),
            ),
            
          ],
        ),
      ),
    );
  }
}

