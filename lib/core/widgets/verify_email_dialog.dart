import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:proequine/core/constants/images/app_images.dart';
import 'package:proequine/core/widgets/rebi_button.dart';

import '../constants/colors/app_colors.dart';

class VErifyEmailDialog extends StatefulWidget {
  Function? onPressVerify;
  bool isThereNavigationBar = false;

  VErifyEmailDialog({this.onPressVerify, this.isThereNavigationBar = false});

  @override
  State<VErifyEmailDialog> createState() => _VErifyEmailDialogState();
}

class _VErifyEmailDialogState extends State<VErifyEmailDialog> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: Dialog(
        insetPadding: EdgeInsets.all(20),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(12.5),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(21.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SvgPicture.asset(AppIcons.email),
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.close,
                        color: AppColors.yellow,
                      ))
                ],
              ),
              const SizedBox(height: 21),
              const Text(
                "Verify your email address To access all features",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 19),
              widget.isThereNavigationBar
                  ? RebiButton(
                      onPressed: () {
                        widget.onPressVerify!();
                      },
                      backgroundColor: AppColors.yellow,
                      child: const Text(
                        "Verify",
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        OutlinedButton(
                          onPressed: () {
                            widget.onPressVerify!();
                          },
                          style: OutlinedButton.styleFrom(
                            minimumSize: const Size(100, 33),
                            side: const BorderSide(
                              color: Colors.white,
                              width: 1,
                            ),
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(6.5),
                              ),
                            ),
                          ),
                          child: const Text(
                            "Verify",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(100, 33),
                            backgroundColor: AppColors.yellow,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(6.5),
                              ),
                            ),
                          ),
                          child: const Text('Close'),
                        )
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
