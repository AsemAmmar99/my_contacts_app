import 'package:country_code_picker/country_code.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_contacts_app/business_logic/app_cubit.dart';
import 'package:my_contacts_app/presentation/styles/colors.dart';
import 'package:my_contacts_app/presentation/widgets/default_text.dart';
import 'package:my_contacts_app/presentation/widgets/default_text_button.dart';
import 'package:sizer/sizer.dart';
import '../widgets/default_form_field.dart';
import '../widgets/default_phone_form_field.dart';

class EditContactDialog extends StatelessWidget {
  EditContactDialog({Key? key, required this.model}) : super(key: key);

  final Map model;
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var phoneNumberController = TextEditingController();
  var myCountryCode = CountryCode(name: 'EG', dialCode: '+20');

  @override
  Widget build(BuildContext context) {

    nameController = TextEditingController(text: '${model['name']}');
    phoneNumberController = TextEditingController(text: '${model['phoneNumber']}'.substring(3));

    return Dialog(
      backgroundColor: darkSkyBlue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(23.sp),
        ),
        child: Form(
          key: formKey,
          child: Padding(
            padding: EdgeInsets.all(15.sp),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 1.h),
                  child: DefaultFormField(
                    controller: nameController,
                    keyboardType: TextInputType.name,
                    validator: (value){
                      if(value!.isEmpty){
                        return "Name can't be empty";
                      }
                      return null;
                    },
                    textColor: white,
                    prefixIcon: const Icon(
                      Icons.title_outlined,
                    ),
                    hintText: 'Contact Name',
                  ),
                ),
                DefaultPhoneFormField(
                  controller: phoneNumberController,
                  validator: (value){
                    if(value!.isEmpty){
                      return "Phone Number can't be empty";
                    }
                    return null;
                  },
                  labelText: 'Contact Phone Number',
                  labelColor: white,
                  textColor: white,
                  onChange: (countryCode){
                    myCountryCode = countryCode;
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                        child: DefaultTextButton(
                          onPressed: () {
                            if(formKey.currentState!.validate()){
                               AppCubit.get(context).editContact(
                                  name: nameController.text,
                                  phoneNumber: '${myCountryCode.dialCode}${phoneNumberController.text}',
                                  id: model['id'],
                              );
                               Fluttertoast.showToast(
                                   msg: "Contact Edited Successfully!",
                                   toastLength: Toast.LENGTH_SHORT,
                                   gravity: ToastGravity.BOTTOM,
                                   timeInSecForIosWeb: 1,
                                   backgroundColor: Colors.green,
                                   textColor: darkBlue,
                                   fontSize: 14.sp
                               );
                               Navigator.pop(context);
                            }

                          },
                          child: DefaultText(
                              text: 'Save',
                              color: lightBlue,
                              fontWeight: FontWeight.bold,
                              fontSize: 14.sp,
                          ),
                        ),
                    ),
                    Flexible(
                        child: DefaultTextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: DefaultText(
                              text: 'Cancel',
                              color: lightBlue,
                              fontWeight: FontWeight.bold,
                              fontSize: 14.sp,
                          ),
                        ),
                    ),
                  ],
                )
              ],
            ),
          ),
        )
    );
  }
}
