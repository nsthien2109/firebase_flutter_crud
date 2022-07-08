// ignore_for_file: unnecessary_null_in_if_null_operators

import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {
  final String? helpText;
  final String? labelText;
  final IconData? icon;
  final String? errorText;
  String? initialValue;
  TextEditingController? controller;
  bool? obscureText;
  Function(String value) onChange;
  Function(String value) validate;
  TextInput({Key? key,
    this.helpText, 
    this.icon, 
    this.errorText, 
    this.initialValue,
    this.labelText, 
    this.controller,
    required this.validate, 
    required this.onChange,
    this.obscureText,
    }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: TextFormField(
        textInputAction: TextInputAction.done,
        obscureText: obscureText ?? false,
        controller: controller ?? null,
        initialValue: initialValue ?? null,
        validator: (val) => validate(val!),
        decoration: InputDecoration(
          helperText:  helpText ?? null,
          labelText: labelText ?? null,
          errorText: errorText ?? null,
          suffixIcon: Icon(icon ?? null),
          //border
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: Colors.orange[300]!
            )
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: Colors.orange[300]!
            )
          )
        ),
        onChanged: (value) => onChange,
      ),
    );
  }
}