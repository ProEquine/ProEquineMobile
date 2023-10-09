import 'package:flutter/material.dart';
import 'package:proequine/core/constants/thems/app_styles.dart';
import 'package:proequine/features/home/presentation/widgets/dashes_line_widget.dart';

import '../../../../core/constants/colors/app_colors.dart';
import '../../../../core/utils/sharedpreferences/SharedPreferencesHelper.dart';

class ShippingWidgetItem extends StatelessWidget {
  final String? title;
  final String status;
  final String? type;
  final String? date;
  final String? from;
  final String? to;
  final String? shipmentNumber;
  final Function? onTap;

  const ShippingWidgetItem(
      {super.key,
      this.title,
      this.type,
      this.date,
      this.shipmentNumber,
      this.from,
      this.to,
      required this.status,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    int returnedColor() {
      if (status == 'Available') {
        return 0xFF34C759;
      } else if (status == 'Closed') {
        return 0x996B7280;
      }
      return 0xFFCC0000;
    }

    return GestureDetector(
      onTap: () {
        onTap!();
      },
      child: Card(
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
              Expanded(
                child: Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Date: $date',
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
                          'Shipment number $shipmentNumber',
                          style: AppStyles.bookingContent,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(width: 10,),
                        Center(
                            child: DashedLineWithCircles(
                          from: from!,
                          to: to!,
                          type: type!,
                        )),
                        SizedBox(width: 10,),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
