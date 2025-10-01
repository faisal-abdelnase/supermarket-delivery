import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField({
    super.key, required this.hintText, required this.icon, required this.controller, required this.validator,
  });

  final String hintText;
  final IconData icon;
  final TextEditingController controller;
  final FormFieldValidator<String> validator;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: widget.validator,
      controller: widget.controller,
      cursorColor: Colors.blue,
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: TextStyle(
          color: Colors.grey,
          fontSize: 16,
          ),
        fillColor: Colors.grey[200],
        filled: true,
        suffixIcon: Icon(widget.icon),
        suffixIconColor: Colors.blue,
        
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
      ),


      onChanged: (value) {
          Form.of(context).validate();
      },

    );
  }
}

