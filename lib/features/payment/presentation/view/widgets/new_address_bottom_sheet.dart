import 'package:flutter/material.dart';
import 'package:super_market/core/utils/widgets/custom_elvated_button.dart';
import 'package:super_market/features/google_mpas/data/models/selected_location_model.dart';
import 'package:super_market/features/google_mpas/presentation/view/map_screen.dart';
import 'package:super_market/features/payment/data/model/save_address_model.dart';
import 'package:super_market/features/payment/presentation/view/widgets/location_text_field.dart';

class NewAddressBottomSheet extends StatefulWidget {
  const NewAddressBottomSheet({
    super.key,
  });

  @override
  _NewAddressBottomSheetState createState() => _NewAddressBottomSheetState();
}

class _NewAddressBottomSheetState extends State<NewAddressBottomSheet> {
  String groupValue = "not Select";
  late TextEditingController titleController;
  late TextEditingController addressController;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController();
    addressController = TextEditingController();
  }

  @override
  void dispose() {
    titleController.dispose();
    addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          Text("Add New Address", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
          SizedBox(height: 16),
          LocationTextField(
            readOnly: false,
            controller: titleController,
            hintText: "Title",
            icon: Icons.title,
          ),
          SizedBox(height: 12),
          LocationTextField(
            onTap: () async{
              final result = await Navigator.pushNamed(context, DeliveryMapView.routeId);
              if(result != null && result is SelectedLocationModel){
                setState(() {
                  addressController.text = result.address;
                });
              }
            },
            readOnly: true,
            controller: addressController,
            hintText: "Search For Location",
            icon: Icons.search,
          ),
          SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Radio<String>(
                    value: "Home",
                    groupValue: groupValue,
                    onChanged: (value){
                      setState(() {
                        groupValue = value!;
                      });
                    },
                  ),
                  Text("Home", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                ],
              ),
              Row(
                children: [
                  Radio<String>(
                    value: "Work",
                    groupValue: groupValue,
                    onChanged: (value){
                      setState(() {
                        groupValue = value!;
                      });
                    },
                  ),
                  Text("Work", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                ],
              ),
              Row(
                children: [
                  Radio<String>(
                    value: "Other",
                    groupValue: groupValue,
                    onChanged: (value){
                      setState(() {
                        groupValue = value!;
                      });
                    },
                  ),
                  Text("Other", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                ],
              ),
            ],
          ),
          Spacer(),
          CustomElvatedButton(
            text: "Add Address",
            onPressed: (){
              if(titleController.text.isNotEmpty && addressController.text.isNotEmpty && groupValue != "not Select"){
                AddressModel.addressList.add(
                  AddressModel(
                    title: titleController.text,
                    address: addressController.text,
                    icon: groupValue == "Home" ? Icons.home_outlined : groupValue == "Work" ? Icons.work_outline : Icons.location_on_outlined,
                  ),
                );
                Navigator.pop(context);
              }
            }
          )
        ],
      ),
    );
  }
}