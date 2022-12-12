import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_contacts_app/presentation/screens/contacts_screen.dart';
import 'package:my_contacts_app/presentation/screens/favorites_screen.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial());

  static AppCubit get(context) => BlocProvider.of<AppCubit>(context);

  int currentIndex = 0;
  IconData floatingActionButtonIcon = Icons.person_add;

  List<Widget> screens = [
    const ContactsScreen(),
    const FavoritesScreen(),
  ];

  List<String> appBarTitles = [
    'Contacts',
    'Favorites',
  ];

  void changeIndex(int index) {
    currentIndex = index;
    emit(AppChangeBottomNavBarState());
  }
}
