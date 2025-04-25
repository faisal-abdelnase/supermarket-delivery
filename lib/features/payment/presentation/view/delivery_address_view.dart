
import 'package:flutter/material.dart';
import 'package:super_market_app/core/utils/widgets/custom_arrow_back_button.dart';
import 'package:super_market_app/core/utils/widgets/custom_elvated_button.dart';
import 'package:super_market_app/features/payment/presentation/view/widgets/custom_dotted_border_button.dart';
import 'package:super_market_app/features/payment/presentation/view/widgets/new_address_bottom_sheet.dart';
import 'package:super_market_app/features/payment/presentation/view/widgets/save_address.dart';
import 'package:super_market_app/features/payment/presentation/view/widgets/location_text_field.dart';

class DeliveryAddressView extends StatefulWidget {
  const DeliveryAddressView({super.key});

  static String addressViewID = "/address view id";

  @override
  State<DeliveryAddressView> createState() => _DeliveryAddressViewState();
}

class _DeliveryAddressViewState extends State<DeliveryAddressView> {

  TextEditingController locationController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: SafeArea(
        top: true,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 16,
              children: [
                Row(
                  spacing: MediaQuery.of(context).size.width * 0.2,
                  children: [
                    CustomArrowBackButton(
                      onPressed: (){
                        Navigator.pop(context);
                      },
                    ),
                    Text("Delivery Address", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),),
                    
                  ],
                ),

                LocationTextField(
                  controller: locationController,
                  hintText: "Search For Location",
                  icon: Icons.search,
                ),

                Text("Save Address", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),

                SaveAddress(),

                CustomDottedBorderButton(
                  onPressed: () {
                    addAddressBottomSheet(context);
                  },
                ),

                SizedBox(height: 64,),

                CustomElvatedButton(text: "Apply", onPressed: (){}),

                
              ],
            ),
          ),
        ),
      ),

      
    
    );
  }

  Future<dynamic> addAddressBottomSheet(BuildContext context) {
    return showModalBottomSheet(
            context: context, 
            builder: (context){
              return NewAddressBottomSheet();
            });
  }
}



