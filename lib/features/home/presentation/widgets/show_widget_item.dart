import 'package:flutter/material.dart';
import 'package:proequine/core/constants/thems/app_styles.dart';

import '../../../../core/constants/colors/app_colors.dart';
import '../../../../core/utils/sharedpreferences/SharedPreferencesHelper.dart';

class ShowWidgetItem extends StatelessWidget {
  final String? title;
  final String status;
  final String? type;
  final String? from;
  final String? to;
  // final String? image;
  final Function? onTap;

  const ShowWidgetItem(
      {super.key,
      this.title,
      this.type,
      this.from,
      this.to,
      // this.image,
      required this.status,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    int returnedColor() {
      if (status == 'Available') {
        return 0xFF34C759;
      } else if (status == 'Fully Booked') {
        return 0x996B7280;
      }
      return 0xFFCC0000;
    }

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      color: AppSharedPreferences.getTheme == 'ThemeCubitMode.dark'
          ? const Color.fromRGBO(12, 12, 12, 1)
          : Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          children: [
            // Container(
            //   height: 75,
            //   width: 75,
            //   decoration: BoxDecoration(
            //     borderRadius: BorderRadius.circular(8),
            //   ),
            // //   child: Image.asset(
            // //     image!,
            // //     fit: BoxFit.contain,
            // //   ),
            // // ),
            // // const SizedBox(
            // //   width: 6,
            // // ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        title!,
                        style: TextStyle(
                          fontSize: 12,
                          color: AppSharedPreferences.getTheme ==
                                  'ThemeCubitMode.dark'
                              ? AppColors.white
                              : AppColors.backgroundColor,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      // const SizedBox(
                      //   width: 10,
                      // ),
                      const Spacer(),
                      Row(
                        children: [
                          Container(
                            height: 10,
                            width: 10,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(returnedColor())),
                          ),
                          const SizedBox(
                            width: 3,
                          ),
                          Text(
                            status,
                            style: const TextStyle(
                              fontSize: 12,
                              color: AppColors.formsHintFontLight,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    type!,
                    style: AppStyles.bookingContent,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            '$from - ',
                            style: AppStyles.bookingContent,
                          ),
                          Text(
                            to!,
                            style: AppStyles.bookingContent,
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          onTap!();
                        },
                        child: status == 'Available'
                            ? Row(
                                children: [
                                  const Text(
                                    'Book Now',
                                    style: TextStyle(
                                      color: AppColors.yellow,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 3,
                                  ),
                                  Transform.translate(
                                    offset: const Offset(0.0, 2),
                                    child: const Icon(
                                      Icons.arrow_right_alt_outlined,
                                      size: 25,
                                      color: AppColors.yellow,
                                    ),
                                  ),
                                ],
                              )
                            : const Text('Fully Booked',
                                style: TextStyle(
                                  color: AppColors.formsHintFontLight,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                )),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
