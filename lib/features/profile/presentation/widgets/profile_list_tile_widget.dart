import 'package:flutter/material.dart';

import '../../../../core/constants/colors/app_colors.dart';

class ProfileListTileWidget extends StatefulWidget {
  bool notificationList = false;
  bool isThereNewNotification = false;
  String? title;
  String? subTitle;
  Function? onTap;

  ProfileListTileWidget(
      {super.key,
      this.notificationList = false,
      this.isThereNewNotification = true,
      this.subTitle,
      this.title,
      this.onTap});

  @override
  _ProfileListTileWidgetState createState() => _ProfileListTileWidgetState();
}

class _ProfileListTileWidgetState extends State<ProfileListTileWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        dense: false,
        onTap: () {
          widget.onTap!();
        },
        leading: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.title!,
              style: const TextStyle(
                  color: AppColors.white, fontFamily: 'notosan', fontSize: 18),
            ),
            const SizedBox(height: 4,),
            Text(
              widget.subTitle!,
              style: const TextStyle(
                  color: AppColors.grey, fontFamily: 'notosan', fontSize: 14),
            ),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            widget.notificationList && widget.isThereNewNotification
                ? Container(
                    height: 6,
                    width: 6,
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                  )
                : const SizedBox(
                    height: 6,
                    width: 6,
                  ), // icon-1
            const Icon(
              Icons.arrow_forward_ios_rounded,
              color: AppColors.white,
            ),
          ],
        ),
      ),
    );
  }
}
