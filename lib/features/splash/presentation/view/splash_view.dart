import 'package:flutter/material.dart';
import 'package:super_market_app/constant.dart';
import 'package:super_market_app/core/utils/first_display_shared_preference.dart';
import 'package:super_market_app/features/about/presentation/view/about_app.dart';
import 'package:super_market_app/features/home/presentation/view/home_view.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView>  with SingleTickerProviderStateMixin {

  late AnimationController animationController;
  late Animation<Offset> slidingAnimation;

  @override
  void initState() {
    initSplashAnimation();
    navigateToHome();
    super.initState();
  }

  

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          
          children: [
            Image.asset(logo,width: 200,),
            const SizedBox(height: 20,),
            AnimatedBuilder(
              animation: slidingAnimation,
              builder: (context, _){
                return SlideTransition(
                  position: slidingAnimation,
                  child: Text("Super Market Delivery", 
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Lobster"
              ),),
                );
              },
            ),
          ],
        ),
      ),
    );
  }



  void initSplashAnimation(){
    animationController = AnimationController(vsync: this, duration: Duration(seconds: 2));

    slidingAnimation = Tween<Offset>(
      begin: Offset(0,10), end: Offset.zero).animate(animationController);
      animationController.forward();
    
  }

  void navigateToHome() {
    Future.delayed(Duration(seconds: 3),() async{
        bool isDisplay = await FirstDisplaySharedPreference.getData() ?? false;
        isDisplay ? Navigator.pushReplacementNamed(context, HomeView.homeId) 
        : Navigator.pushReplacementNamed(context, AboutApp.aboutAppId);
      });
  }


}