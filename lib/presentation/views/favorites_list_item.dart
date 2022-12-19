import 'package:flutter/material.dart';
import 'package:my_contacts_app/presentation/styles/colors.dart';
import 'package:my_contacts_app/presentation/widgets/default_text.dart';
import 'package:sizer/sizer.dart';

import '../../business_logic/app_cubit.dart';

class FavoritesListItem extends StatelessWidget {
  const FavoritesListItem({Key? key, required this.model}) : super(key: key);

  final Map model;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4.w),
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
    );
  }
}
