import 'package:country_code_picker/country_code.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_contacts_app/business_logic/app_cubit.dart';
import 'package:my_contacts_app/presentation/widgets/default_form_field.dart';
import 'package:sizer/sizer.dart';

import '../styles/colors.dart';
import '../widgets/default_phone_form_field.dart';
import '../widgets/default_text.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({Key? key}) : super(key: key);

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  late AppCubit cubit;
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var phoneNumberController = TextEditingController();
  var myCountryCode = CountryCode(name: 'EG', dialCode: '+20');

  @override
  void initState() {
    cubit = AppCubit.get(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {
        if(state is AppInsertContactState){
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        return Scaffold(
          key: scaffoldKey,
          extendBody: true,
          appBar: AppBar(
            backgroundColor: darkSkyBlue,
            centerTitle: true,
            elevation: 8,
            title: DefaultText(
              text: cubit.appBarTitles[cubit.currentIndex],
              color: lightBlue,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
              fontSize: 22.sp,
            ),
          ),
          body: Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: AlignmentDirectional.topStart,
                    end: AlignmentDirectional.bottomEnd,
                    colors: [
                      skyBlue,
                      lightSkyBlue,
                      skyBlue,
                    ],
                  ),
                ),
              ),
              cubit.screens[cubit.currentIndex],
            ],
          ),
          floatingActionButton: Visibility(
            visible: cubit.currentIndex == 0,
            child: FloatingActionButton(
              onPressed: () async {
                if(cubit.isBottomSheetShown){
                  if(formKey.currentState!.validate()) {
                    await cubit.insertToDatabase(
                        name: nameController.text,
                        phoneNumber: '${myCountryCode.dialCode}${phoneNumberController.text}',
                    );
                    nameController.text = '';
                    phoneNumberController.text = '';
                  }
                }else{
                  scaffoldKey.currentState!.showBottomSheet((context) =>
                  Wrap(
                    children: [
                      Container(
                        color: darkSkyBlue,
                        padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 3.w),
                        child: Form(
                          key: formKey,
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
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  ).closed.then((value) {
                    cubit.changeBottomSheetState(isShown: false, icon: Icons.person_add);
                  });
                  cubit.changeBottomSheetState(isShown: true, icon: Icons.add);
                }
              },
              backgroundColor: darkSkyBlue,
              elevation: 20,
              child: Icon(cubit.floatingActionButtonIcon, color: lightBlue,),
            ),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: BottomAppBar(
            color: darkSkyBlue,
            elevation: 0,
            shape: const CircularNotchedRectangle(),
            notchMargin: 12,
            child: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                backgroundColor: Colors.transparent,
                selectedItemColor: lightSkyBlue,
                unselectedItemColor: lightBlue,
                elevation: 0,
                currentIndex: cubit.currentIndex,
                onTap: (index) => cubit.changeIndex(index),
                items: const [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.contacts_outlined,),
                      label: 'Contacts',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.favorite,),
                    label: 'Favorites',
                  ),
                ],
            ),
          ),
        );
      },
    );
  }
}
