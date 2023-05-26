import 'package:flutter/material.dart';

import '../../../../core/constants/colors/app_colors.dart';

class ProfileListTileWidget extends StatefulWidget {
  bool notificationList = false;
  bool isThereNewNotification = false;
  bool isDeleteAccount = false;
  String? title;
  Function? onTap;

  ProfileListTileWidget(
      {super.key,
      this.notificationList = false,
      this.isThereNewNotification = true,
      this.isDeleteAccount = false,
      this.title,
      this.onTap});

  @override
  _ProfileListTileWidgetState createState() => _ProfileListTileWidgetState();
}

class _ProfileListTileWidgetState extends State<ProfileListTileWidget> {
  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(0.0,-20),
      child: Card(
        color: Color.fromRGBO(25, 25, 25, 1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 2),
          child: ListTile(
            dense: false,
            onTap: () {
              widget.onTap!();
            },
            leading: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title!,
                  textAlign: TextAlign.center,
                  style:  TextStyle(
                      color: widget.isDeleteAccount?AppColors.darkRed:AppColors.formsLabel,
                      fontFamily: 'notosan',
                      fontSize: 18),
                ),
                const SizedBox(
                  height: 4,
                ),
                // Text(
                //   style: const TextStyle(
                //       color: AppColors.grey, fontFamily: 'notosan', fontSize: 14),
                // ),
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
                  color: AppColors.formsLabel,
                  size: 18,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
