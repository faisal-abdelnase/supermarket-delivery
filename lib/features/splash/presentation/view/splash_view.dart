import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_market/core/constant.dart';
import 'package:super_market/core/utils/shared_preference_function.dart';
import 'package:super_market/features/Auth/presentation/view/type_of_registeration.dart';
import 'package:super_market/features/about/presentation/view/about_app.dart';
import 'package:super_market/features/home/presentation/manager/cubit/products_cubit.dart';
import 'package:super_market/features/home/presentation/view/home_view.dart';
import 'package:super_market/features/profile/presentation/manager/cubit/profile_info_cubit.dart';


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
    BlocProvider.of<ProductsCubit>(context).getAllProducts();
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
        bool isDisplay = await SharedPreferenceFunction.getFirstDisplayData() ?? false;
        bool isLoggedIn = await SharedPreferenceFunction.getLoggedInState() ?? false;

        if(isLoggedIn){
          await BlocProvider.of<ProfileInfoCubit>(context).fetchProfileInfo();
          Navigator.pushReplacementNamed(context, HomeView.homeId);
        }

        else{
          if(isDisplay){
            
              Navigator.pushReplacementNamed(context, TypeOfRegisteration.registeration);
          }
          else{
            Navigator.pushReplacementNamed(context, AboutApp.aboutAppId);
          }
        }
      });
  }


}