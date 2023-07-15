import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/constants/colors/app_colors.dart';
import '../../../../core/constants/images/app_images.dart';
import '../../../../core/utils/sharedpreferences/SharedPreferencesHelper.dart';

class ConfirmBookingItem extends StatelessWidget {
  final String? bookingId;
  final String? date;
  final String? transport;
  final int? horsesCount;

  const ConfirmBookingItem(
      {super.key, this.bookingId, this.transport, this.date, this.horsesCount});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      color: AppSharedPreferences.getTheme == 'ThemeCubitMode.dark'
          ? const Color.fromRGBO(12, 12, 12, 1)
          : Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  flex: 8,
                  child: Container(
                    height: 14.h,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          bottomLeft: Radius.circular(15)),
                      image: DecorationImage(
                          image: AssetImage(AppImages.hospital),
                          fit: BoxFit.fill),
                    ),
                  ),
                ),
                const Spacer(
                  flex: 1,
                ),
                Expanded(
                  flex: 14,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Container(
                            height: 14,
                            width: 14,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle, color: Colors.grey),
                          ),
                          const SizedBox(
                            width: 6,
                          ),
                          Text(
                            'Pending',
                            style: TextStyle(
                              fontSize: 14,
                              color: AppSharedPreferences.getTheme ==
                                      'ThemeCubitMode.dark'
                                  ? AppColors.white
                                  : AppColors.backgroundColor,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            bookingId!,
                            style: const TextStyle(
                              color: AppColors.grey,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Transform.translate(
                        offset: const Offset(-5, 0.0),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: SizedBox(
                                height: 20,
                                width: 20,
                                child: SvgPicture.asset(
                                  AppIcons.date,
                                  color: AppColors.grey,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 14,
                              child: Text(
                                date!,
                                style: const TextStyle(
                                    color: AppColors.grey),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: SvgPicture.asset(
                              AppIcons.greyTransportIcon,

                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                              flex: 12,
                              child: Text(transport!,
                                  style: const TextStyle(
                                    color: AppColors.grey,

                                  )))
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: SvgPicture.asset(
                              AppIcons.horse,
                              color: AppColors.grey,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            flex: 5,
                            child: Text(
                              horsesCount.toString(),
                              style: const TextStyle(
                                color: AppColors.grey),
                            ),
                          ),
                          const Spacer(),
                          TextButton(
                            style: TextButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                            ),
                            onPressed: () {},
                            child: Text(
                              "Modify",
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: AppSharedPreferences.getTheme ==
                                        'ThemeCubitMode.dark'
                                    ? AppColors.gold
                                    : AppColors.gold,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
