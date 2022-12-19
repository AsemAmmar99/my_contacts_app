import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../business_logic/app_cubit.dart';
import '../views/contacts_list_builder.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {

        var contactsList = AppCubit.get(context).favorites;

        return ContactsListBuilder(
          contacts: contactsList,
          noContactsText: 'No Favorite Contacts..',
          contactType: 'favorite',
        );
      },
    );
  }
}
