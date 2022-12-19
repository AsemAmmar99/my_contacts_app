import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_contacts_app/presentation/screens/contacts_screen.dart';
import 'package:my_contacts_app/presentation/screens/favorites_screen.dart';
import 'package:sqflite/sqflite.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial());

  static AppCubit get(context) => BlocProvider.of<AppCubit>(context);

  int currentIndex = 0;
  IconData floatingActionButtonIcon = Icons.person_add;
  bool isBottomSheetShown = false;

  List<Widget> screens = [
    const ContactsScreen(),
    const FavoritesScreen(),
  ];

  List<String> appBarTitles = [
    'Contacts',
    'Favorites',
  ];

  List<Map> contacts = [];
  List<Map> favorites = [];

  void changeIndex(int index) {
    currentIndex = index;
    emit(AppChangeBottomNavBarState());
  }

  void changeBottomSheetState({
    required bool isShown,
    required IconData icon,
}){
    isBottomSheetShown = isShown;
    floatingActionButtonIcon = icon;
    emit(AppChangeBottomSheetState());
  }

  late Database database;

  void createDatabase() {
    openDatabase(
      'contacts.db',
      version: 1,
      onCreate: (database, version) {
        if (kDebugMode) {
          print('database created');
        }
        database.execute('CREATE TABLE contacts (id INTEGER PRIMARY KEY, name TEXT, phoneNumber TEXT, status TEXT)')
            .then((value) {
          if (kDebugMode) {
            print('table created');
          }
        }).catchError((error){
          if (kDebugMode) {
            print('Error while creating table $error');
          }
        });
      },
      onOpen: (database){
        getContacts(database);
        if (kDebugMode) {
          print('database opened');
        }
      }
    ).then((value) {
      database = value;
      emit(AppCreateDatabaseState());
    });
  }

  void getContacts(Database database) async {
    contacts = [];
    favorites = [];

    emit(AppGetDatabaseLoadingState());
    
    await database.rawQuery('SELECT * FROM contacts').then((value) {
      for (var element in value) {

        contacts.add(element);

        if(element['status'] == 'favorite'){
          favorites.add(element);
        }
      }
    });

    emit(AppGetDatabaseState());
  }

  insertToDatabase({
    required String name,
    required String phoneNumber,
  }) async{
    await database.transaction((txn) {
      return txn.rawInsert('INSERT INTO contacts(name, phoneNumber, status) VALUES("$name", "$phoneNumber", "all")')
      .then((value) {
        if (kDebugMode) {
          print('Contact $value successfully inserted!');
        }
        emit(AppInsertContactState());

        getContacts(database);
      }).catchError((error){
        if (kDebugMode) {
          print('Error while inserting Contact $error');
        }
      });
    });
  }

  void addOrRemoveFavourite({
    required String status,
    required int id,
}) {
    database.rawUpdate('UPDATE contacts SET status = ? WHERE id = ?',
    [status, id],
    ).then((value) {
      getContacts(database);
      emit(AppAddOrRemoveFavoriteState());
    });
}

  void editContact({
    required String name,
    required String phoneNumber,
    required int id,
  }) {
    database.rawUpdate('UPDATE contacts SET name = ?, phoneNumber = ? WHERE id = ?',
      [name, phoneNumber, id],
    ).then((value) {
      getContacts(database);
      emit(AppEditContactState());
    });
  }

  Future<void> deleteContact({
    required int id,
}) async{

    await database.rawDelete('DELETE FROM contacts WHERE id = ?',
    [id],
    ).then((value) {
      getContacts(database);
      emit(AppDeleteContactState());
    });

}

}
