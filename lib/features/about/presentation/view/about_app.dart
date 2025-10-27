import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:super_market/core/utils/shared_preference_function.dart';
import 'package:super_market/features/Auth/presentation/view/type_of_registeration.dart';
import 'package:super_market/features/about/data/model/about_data_model.dart';


class AboutApp extends StatefulWidget {
  const AboutApp({super.key});

  static const aboutAppId = "/aboutApp";

  @override
  State<AboutApp> createState() => _AboutAppState();
}


class _AboutAppState extends State<AboutApp> {

  int count = 1;
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        actions: [
          TextButton(
                onPressed: (){
                  SharedPreferenceFunction.saveFirstDisplayData(isDisplay: true);
                  Navigator.pushReplacementNamed(context, TypeOfRegisteration.registeration);
                }, 
                child: Text("Skip", 
                style: TextStyle(
                  color: Colors.blue,
                  
                ),),
                ),
        ],
      ),
      body: SafeArea(
        top: true,
        
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              
          
                Image.asset(AboutDataModel.aboutData[index].image),

                Column(
                  children: [
                    Text(AboutDataModel.aboutData[index].title, 
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                ),),

                SizedBox(height: 8,),
                Text(AboutDataModel.aboutData[index].subTitle,
                maxLines: 2,
                style: TextStyle(
                  color: Colors.grey,
                ),),
                  ],
                ),

                CircularPercentIndicator(
                  backgroundColor: Colors.transparent,
                  lineWidth: 3,
                  radius: 32,
                  progressColor: Colors.blue,
                  percent: count / 3,
                  center: IconButton(
                    style: IconButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: (){
                      if(count != 3 || index != 2){
                        count++;
                        index++;
                      }
                      else{
                        SharedPreferenceFunction.saveFirstDisplayData(isDisplay: true);
                        Navigator.pushReplacementNamed(context, TypeOfRegisteration.registeration);
                        
                      }
                      

                      setState(() {});
                    }, 
                    icon: Icon(Icons.arrow_forward, size: 35,)
                    ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}