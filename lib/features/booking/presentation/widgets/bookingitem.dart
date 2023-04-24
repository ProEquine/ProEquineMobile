import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:proequine/core/constants/colors/app_colors.dart';

import '../../../../core/constants/images/app_images.dart';

class BookingItem extends StatelessWidget {
  bool pending = false;
  String? type;
  final String? bookingId;
  String? date;
  String? transport;
  String? transportType;
  int? horsesCount;

  BookingItem({
    super.key,
    this.pending = false,
    this.type,
    this.bookingId,
    this.date,
    this.horsesCount,
    this.transport,
    this.transportType,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: const Color(0xff000000),
              image: DecorationImage(
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.2), BlendMode.dstATop),
                image: const AssetImage(
                  AppImages.hospital,
                ),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        height: 14,
                        width: 14,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: pending ? Colors.red : Colors.green),
                      ),
                      const SizedBox(
                        width: 6,
                      ),
                      Text(
                        type!,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Spacer(),
                      Text(bookingId!),
                    ],
                  ),

                  const SizedBox(
                    height: 7,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 14,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: SizedBox(
                                    child: SvgPicture.asset(
                                      AppIcons.date,
                                      color: AppColors.eventText,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                 Expanded(
                                  flex: 13,
                                  child: Text(
                                    date!,
                                    style:const TextStyle(
                                        fontSize: 12,
                                        color: AppColors.eventText),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 11.5,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    child:  Image.asset(
                                      AppImages.greyTrans,

                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                 Expanded(
                                    flex: 13,
                                    child: Text(transport!,
                                        style: const TextStyle(
                                          color: AppColors.eventText,
                                            fontSize: 12,
                                            )))
                              ],
                            ),
                            const SizedBox(
                              height: 11.5,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    child: SvgPicture.asset(
                                      AppIcons.horse,
                                      color: AppColors.eventText,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                 Expanded(
                                  flex: 14,
                                  child: Text(
                                    horsesCount.toString(),
                                    style: const TextStyle(
                                        fontSize: 12,
                                        color: AppColors.eventText),
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 11.5,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    child: SvgPicture.asset(
                                      AppIcons.transportType,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                 Expanded(
                                    flex: 13,
                                    child: Text(transportType!,
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: AppColors.eventText)))
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),

                  // location

                  // buttons
                  const SizedBox(
                    height: 8,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
