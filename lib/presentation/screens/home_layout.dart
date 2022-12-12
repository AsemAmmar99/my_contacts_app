import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_contacts_app/business_logic/app_cubit.dart';
import 'package:sizer/sizer.dart';

import '../styles/colors.dart';
import '../widgets/default_text.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({Key? key}) : super(key: key);

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  late AppCubit cubit;
  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    cubit = AppCubit.get(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
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
              onPressed: (){},
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
