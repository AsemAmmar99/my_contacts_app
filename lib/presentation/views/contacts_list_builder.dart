import 'package:flutter/material.dart';
import 'package:my_contacts_app/presentation/styles/colors.dart';
import 'package:sizer/sizer.dart';

import '../widgets/default_text.dart';
import 'contacts_list_item.dart';
import 'favorites_list_item.dart';

class ContactsListBuilder extends StatelessWidget {
  const ContactsListBuilder({
    Key? key,
    required this.contacts,
    required this.noContactsText,
    required this.contactType,
  }) : super(key: key);

  final List<Map> contacts;
  final String noContactsText;
  final String contactType;

  @override
  Widget build(BuildContext context) {
    return Visibility(
        visible: contacts.isNotEmpty,
        replacement: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                  Icons.no_accounts,
                  size: 75.sp,
                  color: white,
              ),
              DefaultText(
                text: noContactsText,
                fontWeight: FontWeight.bold,
                fontSize: 14.sp,
                color: white,
              ),
            ],
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 2.h),
          child: ListView.separated(
              itemBuilder: (context, index){
                if(contactType == 'favorite'){
                  return FavoritesListItem(model: contacts[index],);
                }else{
                  return ContactsListItem(model: contacts[index],);
                }
              },
              separatorBuilder: (context, index) => Row(
                children: [
                  Expanded(
                    child: Divider(
                      height: 1.h,
                      color: Colors.transparent,
                    ),
                  )
                ],
              ),
              itemCount: contacts.length,
          ),
        ),
    );
  }
}
