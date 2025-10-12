import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:super_market/features/Auth/presentation/view/widgets/custom_text_form_filed.dart';

class EnterPhoneNumber extends StatefulWidget {
  const EnterPhoneNumber({
    super.key,
    required this.phoneController, required this.countryCodeController, required this.validator,
  });


  final TextEditingController phoneController;
  final TextEditingController countryCodeController;
  final FormFieldValidator<String> validator;

  @override
  State<EnterPhoneNumber> createState() => _EnterPhoneNumberState();
}

class _EnterPhoneNumberState extends State<EnterPhoneNumber> {
  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 8,
      children: [

        SizedBox(
          width: 110,
          child: TextFormField(

            validator: widget.validator,
            controller: widget.countryCodeController,
            cursorColor: Colors.blue,

            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12)
              ),

              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(color: Colors.transparent)
              ),

              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(
                  color: Colors.blue,
                  width: 2,
                  ),
              ),

              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(
                  color: Colors.red,
                  width: 2,
                  ),
              ),

              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(
                  color: Colors.red,
                  width: 2,
                  ),
              ),

              fillColor: Colors.grey[200],
              filled: true,
              hintText: "+20" ,
              hintStyle: TextStyle(
                color: Colors.grey,
                fontSize: 16,
                ),
            
              suffixIcon: IconButton(
                onPressed: (){

                  showCountryPicker(
                    context: context, 
                    showPhoneCode: true,
                    onSelect: (Country country) {
                      setState(() {
                        widget.countryCodeController.text = "+${country.phoneCode}";
                      });
                    },
                    );
                }, 
                icon: Icon(Icons.arrow_drop_down, color: Colors.blue,)),
              ),

              onChanged: (value) {
                Form.of(context).validate();
            },
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