import 'package:flutter/material.dart';
import 'package:super_market/core/utils/widgets/custom_elvated_button.dart';
import 'package:super_market/features/google_mpas/presentation/view/map_screen.dart';
import 'package:super_market/features/payment/data/model/save_address_model.dart';
import 'package:super_market/features/payment/presentation/view/widgets/location_text_field.dart';

class NewAddressBottomSheet extends StatelessWidget {
  const NewAddressBottomSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    String groupValue = "not Select";
    TextEditingController titleController = TextEditingController();
    TextEditingController addressController = TextEditingController();
    return StatefulBuilder(
      builder: (context, setState) {
        return  Container(
          padding: EdgeInsets.all(16),
          child: Column(
            spacing: 16,
            children: [
    
              Text("Add New Address", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
              LocationTextField(
                readOnly: false,
                controller: titleController,
                hintText: "Title", 
                icon: Icons.title,
                ),
        
                LocationTextField(
                  onTap: () async{
                    final result = await Navigator.pushNamed(context, MapScreen.mapScreenID);
                    if(result != null){
                      addressController.text = result as String;
                    }
                  },
                  readOnly: true,
                  controller: addressController,
                  hintText: "Search For Location", 
                  icon: Icons.search),
        
        
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      
                      Radio(
                        value: "Home", 
                        groupValue: groupValue, 
                        onChanged: (value){
                          setState(() {
                            groupValue = value!;
                          });
                        }),
                        Text("Home", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                    ],
                  ),
        
                  Row(
                    children: [
                      
                      Radio(
                        value: "Work", 
                        groupValue: groupValue, 
                        onChanged: (value){
                          setState(() {
                            groupValue = value!;
                          });
                        }),
                        Text("Work", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                    ],
                  ),
        
        
                    Row(
                    children: [
                      
                      Radio(
                        value: "Other", 
                        groupValue: groupValue, 
                        onChanged: (value){
                          setState(() {
                            groupValue = value!;
                          });
                        }),
                        Text("Other", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                    ],
                  ),
                ],
              ),
    
              Spacer(),
    
              CustomElvatedButton(
                text: "Add Address", 
                onPressed: (){
                  AddressModel.addressList.add(
                    AddressModel(
                      title: titleController.text,
                      address: addressController.text,
                      icon: groupValue == "Home" ? Icons.home_outlined : groupValue == "Work" ? Icons.work_outline : Icons.location_on_outlined,  
                    ),
                  );
                  Navigator.pop(context);
                })
            ],
          ),
        );
    
      },
    );
  }
}