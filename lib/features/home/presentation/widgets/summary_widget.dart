import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:proequine/core/constants/colors/app_colors.dart';
import 'package:proequine/core/constants/images/app_images.dart';
import 'package:proequine/core/constants/thems/app_styles.dart';
import 'package:proequine/core/utils/printer.dart';
import 'package:proequine/core/widgets/rebi_button.dart';

import '../../../../core/widgets/divider.dart';
import '../../data/form_data_model.dart';

class SummaryBoxWidget extends StatelessWidget {
  final FromDataModel? formData;
  SummaryBoxWidget({required this.formData});
  String returnDate() {
    if (formData!.tripType == "Other day return" &&
        formData!.expectedTime!.isNotEmpty) {
      return "Returning: ${formData!.expectedDate} • ${formData!.expectedTime}";
    } else if (formData!.tripType == "Same day return" &&
        formData!.expectedTime!.isNotEmpty) {
      return "Returning:  ${formData!.date} • ${formData!.expectedTime}";
    } else {
      return "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        // color: const Color(0xff191919),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 11),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SvgPicture.asset(AppIcons.returntype),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Service & Return type",
                      style: AppStyles.summaryTitleStyle,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      '${formData!.tripType}',
                      style: AppStyles.summaryDesStyle,
                    ),
                  ],
                )
              ],
            ),
            const CustomDivider(),

            Row(
              children: [
                SvgPicture.asset(AppIcons.datetime),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Date & Time",
                      style: AppStyles.summaryTitleStyle,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Going: ${formData!.date} • ${formData!.time}",
                      style: AppStyles.summaryDesStyle,
                    ),
                    Text(
                      returnDate(),
                      style: AppStyles.summaryDesStyle,
                    ),
                  ],
                )
              ],
            ),

            const CustomDivider(),

            Row(
              children: [
                SvgPicture.asset(AppIcons.locations),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Location",
                      style: AppStyles.summaryTitleStyle,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Origin: ${formData!.origin}",
                      style: AppStyles.summaryDesStyle,
                    ),
                    Text(
                      "Destination: ${formData!.destination}",
                      style: AppStyles.summaryDesStyle,
                    ),
                  ],
                )
              ],
            ),

            const CustomDivider(),

            Row(
              children: [
                SvgPicture.asset(AppIcons.horses),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Horses",
                      style: AppStyles.summaryTitleStyle,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      '${formData!.numberOfHorses}',
                      style: AppStyles.summaryDesStyle,
                    ),
                  ],
                )
              ],
            ),

            const CustomDivider(),
            Row(
              children: [
                SvgPicture.asset(AppIcons.contact),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Contact Person",
                      style: AppStyles.summaryTitleStyle,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      formData!.contact,
                      style: AppStyles.summaryDesStyle,
                    ),
                  ],
                )
              ],
            ),
            formData!.comment!.isNotEmpty
                ? const CustomDivider()
                : const SizedBox(
                    height: 1,
                  ),
            formData!.comment!.isNotEmpty
                ? Row(
                    children: [
                      SvgPicture.asset(AppIcons.note),
                      const SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Note",
                            style: AppStyles.summaryTitleStyle,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            '${formData!.comment}',
                            style: AppStyles.summaryDesStyle,
                          ),
                        ],
                      )
                    ],
                  )
                : const SizedBox(),

            const SizedBox(
              height: 50,
            ),

            RebiButton(
              height: 40,
              onPressed: () {
                Navigator.pop(context);
              },
              backgroundColor: const Color(0xff303030),
              child: const Text(
                "Edit",
                style: TextStyle(
                    color: AppColors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    fontFamily: 'notosan'),
              ),
            ),
            // SizedBox(height: 12,)
          ],
        ),
      ),
    );
  }
}
