import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:proequine/core/constants/constants.dart';
import 'package:proequine/features/profile/presentation/widgets/ellipses_widget.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/constants/colors/app_colors.dart';
import '../../../../core/constants/images/app_images.dart';

class HistoryWidget extends StatelessWidget {
  String? imageUrl;
  String? transport;
  String? title;
  String? date;
  String? horsesCount;
  String? from;
  String? to;

  HistoryWidget(
      {super.key,
      this.title,
      this.date,
      this.imageUrl,
      this.transport,
      this.horsesCount,
      this.from,
      this.to});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 25.0.h,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.formsBackground,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(left: 10,right: 10,top: 10),
            height: 15.0.h,
            child: Row(children: [
              Expanded(
                flex: 6,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                          // TODO : Change this asset to network image
                          image: AssetImage(imageUrl!),
                          fit: BoxFit.fill)),
                ),
              ),
              const Spacer(
                flex: 1,
              ),
              Expanded(
                flex: 14,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      title!,
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                          color: AppColors.titleColor,
                          fontSize: 14,
                          fontFamily: 'notosan',
                          fontWeight: FontWeight.w500),
                    ),
                    Spacer(
                      flex: 1,
                    ),
                    Row(
                      children: [
                        Image.asset(
                          AppImages.transport,

                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Flexible(child:Container(child: Text(
                          transport!,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              color: AppColors.textColor,
                              fontSize: 12,
                              fontFamily: 'notosan',
                              fontWeight: FontWeight.w400),
                        ),
                       ),
                        ),
                      ],
                    ),
                    Spacer(
                      flex: 1,
                    ),
                    Row(
                      children: [
                        SvgPicture.asset(
                          AppIcons.date,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          date!,
                          style: const TextStyle(
                              color: AppColors.textColor,
                              fontSize: 12,
                              fontFamily: 'notosan',
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                    Spacer(
                      flex: 1,
                    ),
                    Row(
                      children: [
                        SvgPicture.asset(
                          AppIcons.horse,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          horsesCount!,
                          style: const TextStyle(
                              color: AppColors.textColor,
                              fontSize: 12,
                              fontFamily: 'notosan',
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ]),
          ),
          SizedBox(
            height: 10.0.h,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset(AppIcons.location2),
                      EllipsesWidget(),
                      const SizedBox(width: 5,),
                      Text(
                        from!,
                        style: const TextStyle(
                            color: AppColors.textColor,
                            fontSize: 12,
                            fontFamily: 'notosan',
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      EllipsesWidget(),
                      SvgPicture.asset(AppIcons.location2),
                      const SizedBox(width: 5,),
                      Text(
                        to!,
                        style: const TextStyle(
                            color: AppColors.textColor,
                            fontSize: 12,
                            fontFamily: 'notosan',
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
