import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:proequine/core/constants/colors/app_colors.dart';
import 'package:proequine/core/constants/images/app_images.dart';

import 'package:sizer/sizer.dart';

class NotificationWidget extends StatelessWidget {
  String? statusImage;
  String? bookingTypeText;
  String? image;
  String? title;
  String? date;
  String? transport;
  bool review;

  NotificationWidget(
      {super.key,
      this.review = false,
      this.bookingTypeText,
      this.date,
      this.transport,
      this.title,
      this.image,
      this.statusImage});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
      decoration: BoxDecoration(
        color: AppColors.formsBackground,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SvgPicture.asset(statusImage!),
              const SizedBox(
                width: 5,
              ),

              Text(bookingTypeText!,
                  style: const TextStyle(
                      color: AppColors.textColor,
                      fontFamily: 'notosan',
                      fontSize: 12,
                      fontWeight: FontWeight.w700)),
              // Spacer(),
              // Text(bookingTypeText!,
              //     style: const TextStyle(
              //         color: AppColors.textColor,
              //         fontFamily: 'notosan',
              //         fontSize: 12,
              //         fontWeight: FontWeight.w700)),
            ],
          ),
         const  SizedBox(height: 8,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 9.0.h,
                width: 30.0.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    image: AssetImage(image!),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: 30.0.w,
                    child: Text(
                      title!,
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                          color: AppColors.titleColor,
                          fontSize: 14,
                          fontFamily: 'notosan',
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  const SizedBox(height: 3,),
                  Container(
                    width: 30.0.w,
                    child: Text(
                      transport!,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          color: AppColors.formsHintFont,
                          fontSize: 12,
                          fontFamily: 'notosan',
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  const SizedBox(height: 3,),
                  SizedBox(
                    width: 30.0.w,
                    child: Text(
                      transport!,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          color: AppColors.formsHintFont,
                          fontSize: 12,
                          fontFamily: 'notosan',
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ],
              ),
              Spacer(),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                 SizedBox(height: 50,),
                  Visibility(
                    visible: review,
                    child: Container(
                      height: 5.0.h,
                      width: 20.w,
                      decoration: BoxDecoration(
                        color: AppColors.notificationReview,
                        borderRadius: BorderRadius.circular(76),
                      ),
                      child: const Center(
                        child: Text(
                          "Review",
                          style: TextStyle(
                              color: AppColors.white,
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                              fontFamily: 'notosan'),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8,),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
