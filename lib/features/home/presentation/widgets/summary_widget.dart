import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:proequine/core/constants/colors/app_colors.dart';
import 'package:proequine/core/constants/images/app_images.dart';
import 'package:proequine/core/constants/thems/app_styles.dart';
import 'package:proequine/core/widgets/rebi_button.dart';

import '../../data/form_Data_Model.dart';

class SummaryBoxWidget extends StatelessWidget {
  final FromDataModel? formData;
  SummaryBoxWidget({required this.formData});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xff191919),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
        child: Column(
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
            const SizedBox(
              height: 15,
            ),
            const Text(
              "Date & Time",
              style: AppStyles.summaryTitleStyle,
            ),
            const SizedBox(
              height: 5,
            ),
            const Text(
              "15 Sep • 04:30 pm",
              style: AppStyles.summaryDesStyle,
            ),
            const SizedBox(
              height: 15,
            ),
            const Text(
              "Location",
              style: AppStyles.summaryTitleStyle,
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                SvgPicture.asset(AppIcons.arrows),
                const SizedBox(
                  width: 2,
                ),
                const Text(
                  "DEC",
                  style: AppStyles.summaryDesStyle,
                ),
                const SizedBox(
                  width: 2,
                ),
                SvgPicture.asset(AppIcons.location2),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
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
            const SizedBox(
              height: 15,
            ),
            const Text(
              "Contact Person",
              style: AppStyles.summaryTitleStyle,
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              '${formData!.contact}',
              style: AppStyles.summaryDesStyle,
            ),
            const SizedBox(
              height: 15,
            ),
            const Text(
              "Comments",
              style: AppStyles.summaryTitleStyle,
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              '${formData!.comment}',
              style: AppStyles.summaryDesStyle,
            ),
            const SizedBox(
              height: 17,
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
