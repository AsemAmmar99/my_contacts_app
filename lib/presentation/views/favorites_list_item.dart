import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_contacts_app/presentation/styles/colors.dart';
import 'package:my_contacts_app/presentation/widgets/default_text.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../business_logic/app_cubit.dart';
import 'edit_contact_dialog.dart';

class FavoritesListItem extends StatelessWidget {
  const FavoritesListItem({Key? key, required this.model}) : super(key: key);

  final Map model;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key('${model['id']}'),
      child: InkWell(
        onTap: (){
          Fluttertoast.showToast(
              msg: "Long touch for Contact editing, Swipe left or right to delete, and double touch for calling Contact.",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 3,
              backgroundColor: darkSkyBlue,
              textColor: white,
              fontSize: 14.sp
          );
        },
        onDoubleTap: () async{
          final Uri launchUri = Uri(
              scheme: 'tel',
              path: '${model['phoneNumber']}'
          );
          await launchUrl(launchUri);
        },
        onLongPress: (){
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) => EditContactDialog(model: model),
          );
        },
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 2.w),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.sp),
              gradient: const LinearGradient(
                begin: AlignmentDirectional.centerStart,
                end: AlignmentDirectional.centerEnd,
                colors: [
                  lightPurple,
                  black,
                  lightPurple,
                ],
              )
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.h),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: Padding(
                          padding: EdgeInsetsDirectional.only(start: 2.w),
                          child: DefaultText(
                            text: '${model['name']}',
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            color: white,
                          ),
                        ),
                      ),
                      Flexible(
                        child: DefaultText(
                          text: '${model['phoneNumber']}',
                          fontSize: 14.sp,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          color: white,
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () => AppCubit.get(context).addOrRemoveFavourite(
                    status: 'all',
                    id: model['id'],
                  ),
                  icon: const Icon(
                    Icons.favorite,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      onDismissed: (direction) async{
        await AppCubit.get(context).deleteContact(id: model['id']);
        Fluttertoast.showToast(
            msg: "Contact Deleted Successfully!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: darkBlue,
            fontSize: 14.sp
        );
      },
    );
  }
}
