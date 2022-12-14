import 'package:flutter/material.dart';
import 'package:my_contacts_app/presentation/styles/colors.dart';

class DefaultFormField extends StatelessWidget {
  AlignmentGeometry? containerAlignment;
  double? height;
  double? width;
  double horizontalPadding;
  Color? fieldBackgroundColor;
  int? maxLength;
  Color? cursorColor;
  bool? obscureText;
  TextEditingController controller;
  int? maxLines;
  double? radius;
  String? Function(String?)? validator;
  TextInputType keyboardType;
  Color? textColor;
  InputBorder? inputBorder;
  InputBorder? inputEnabledBorder;
  InputBorder? errorEnabledBorder;
  String? hintText;
  Icon? prefixIcon;
  Icon? suffixIcon;

  DefaultFormField({
    Key? key,
    this.containerAlignment,
    this.height,
    this.width,
    this.horizontalPadding = 0,
    this.maxLength,
    this.fieldBackgroundColor,
    this.cursorColor,
    this.obscureText = false,
    required this.controller,
    this.maxLines,
    this.radius = 30.0,
    this.validator,
    required this.keyboardType,
    this.textColor,
    this.errorEnabledBorder,
    this.inputEnabledBorder,
    this.inputBorder = const OutlineInputBorder(borderSide: BorderSide(color: white, width: 2.0),),
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: containerAlignment,
      height: height,
      width: width,
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      decoration: BoxDecoration(
        color: fieldBackgroundColor,
        borderRadius: BorderRadius.circular(radius!),
      ),
      child: TextFormField(
        maxLength: maxLength,
        cursorColor: cursorColor,
        obscureText: obscureText!,
        maxLines: obscureText == true ? 1 : maxLines,
        controller: controller,
        validator: validator,
        keyboardType: keyboardType,
        style: TextStyle(
          color: textColor,
        ),
        decoration: InputDecoration(
          border: inputBorder,
          enabledBorder: inputEnabledBorder,
          errorBorder: errorEnabledBorder,
          hintText: hintText,
          hintStyle: const TextStyle(
            color: Colors.grey,
          ),
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
        ),
      ),
    );
  }
}
