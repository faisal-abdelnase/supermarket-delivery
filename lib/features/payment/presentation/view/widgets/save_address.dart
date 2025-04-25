import 'package:flutter/material.dart';
import 'package:super_market_app/features/payment/data/model/save_address_model.dart';

class SaveAddress extends StatefulWidget {
  const SaveAddress({
    super.key,
  });


  @override
  State<SaveAddress> createState() => _SaveAddressState();
}

class _SaveAddressState extends State<SaveAddress> {

  

  String groupValue = "not select";
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: AddressModel.addressList.length,
      itemBuilder: (context, index) {
        return  Container(
        padding: EdgeInsets.all(8),
        margin: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(10),
        ),
        child: ListTile(
          isThreeLine: true,
          leading: Icon(AddressModel.addressList[index].icon),
          title: Text(AddressModel.addressList[index].title, 
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
          subtitle: Text(AddressModel.addressList[index].address, 
          style: TextStyle(fontSize: 13, color: Colors.grey),),
          trailing: Radio(
            activeColor: Colors.blue,
            
            value: "select$index", 
            groupValue: groupValue, 
            onChanged: (value){
              setState(() {
                groupValue = value!;
              });
            }),
        ),
      );

      },
          );
  }
}