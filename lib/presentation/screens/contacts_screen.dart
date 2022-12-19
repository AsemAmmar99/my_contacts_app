import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_contacts_app/business_logic/app_cubit.dart';

import '../views/contacts_list_builder.dart';

class ContactsScreen extends StatefulWidget {
  const ContactsScreen({Key? key}) : super(key: key);

  @override
  State<ContactsScreen> createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {

        var contactsList = AppCubit.get(context).contacts;

        return ContactsListBuilder(
          contacts: contactsList,
          noContactsText: 'No Inserted Contacts Yet..',
          contactType: 'all',
        );
      },
    );
  }
}