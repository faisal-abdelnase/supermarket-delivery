import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:super_market/features/Auth/presentation/view/widgets/custom_text_form_filed.dart';

class EnterPhoneNumber extends StatefulWidget {
  const EnterPhoneNumber({
    super.key,
    required this.phoneController,
  });


  final TextEditingController phoneController;

  @override
  State<EnterPhoneNumber> createState() => _EnterPhoneNumberState();
}

class _EnterPhoneNumberState extends State<EnterPhoneNumber> {
  String countryCode = "+";
  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 8,
      children: [
        GestureDetector(
          onTap: () {
            showCountryPicker(
              context: context, 
              showPhoneCode: true,
              onSelect: (Country country) {
                setState(() {
                  countryCode = "+${country.phoneCode}";
                });
              },
              );
          },
          child: Container(
            padding: EdgeInsets.all(8),
            height: 50,
            width: 80,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(16)
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(countryCode),
                Icon(Icons.arrow_drop_down, color: Colors.blue, size: 30,),
              ],
            ),
          ),
        ),
    
    
        Expanded(
          child: CustomTextFormField(
            keyboardType: TextInputType.number,
            hintText: "Phone Number", 
            icon: Icons.phone, 
            controller: widget.phoneController, 
            validator: (value) => value!.isEmpty ? "Enter your phone number" : null),
        ),
      ],
    );
  }
}