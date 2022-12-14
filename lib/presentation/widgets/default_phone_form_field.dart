import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:my_contacts_app/presentation/styles/colors.dart';

class DefaultPhoneFormField extends StatelessWidget {
  TextEditingController controller;
  String? Function(String?)? validator;
  Color? textColor;
  void Function(CountryCode)? onChange;
  InputBorder? border;
  String? hintText;
  String? labelText;
  Color? labelColor;

  DefaultPhoneFormField({
    Key? key,
    required this.controller,
    this.validator,
    this.textColor,
    this.onChange,
    this.border = const OutlineInputBorder(borderSide: BorderSide(width: 1),),
    this.hintText = 'Eg. 123456789',
    this.labelText,
    this.labelColor
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      keyboardType: TextInputType.phone,
      style: TextStyle(
        color: textColor,
      ),
      decoration: InputDecoration(
        prefixIcon: CountryCodePicker(
          onChanged: onChange,
          initialSelection: 'EG',
          favorite: const ['+20', 'EG'],
        ),
        isDense: true,
        border: border,
        hintText: hintText,
        hintStyle: const TextStyle(
          color: Colors.grey,
        ),
        iconColor: white,
        labelText: labelText,
        labelStyle: Theme.of(context).textTheme.caption!.copyWith(
          color: labelColor,
        ),
      ),
    );
  }
}
