import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:proequine/core/constants/constants.dart';
import 'package:proequine/features/profile/presentation/widgets/ellipses_widget.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/constants/colors/app_colors.dart';
import '../../../../core/constants/images/app_images.dart';

class HistoryWidget extends StatelessWidget {
  String? statusImg;
  String? transport;
  String? refnumber;
  String? title;
  String? horsesCount;

  HistoryWidget({
    super.key,
    this.title,
    this.refnumber,
    this.statusImg,
    this.transport,
    this.horsesCount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Color.fromRGBO(25, 25, 25, 1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(left: 10, right: 10, top: 10),
            child: Row(
              children: [
                SvgPicture.asset(statusImg!),
                const SizedBox(
                  width: 5,
                ),
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
                Text(
                  refnumber!,
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                      color: AppColors.titleColor,
                      fontSize: 14,
                      fontFamily: 'notosan',
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
          Container(
            padding:
                const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
            child: Row(children: [
              Expanded(
                flex: 14,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: [
                        Image.asset(
                          AppImages.transport,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Flexible(
                          child: Container(
                            child: Text(
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
                    SizedBox(
                      height: 10,
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
        ],
      ),
    );
  }
}
