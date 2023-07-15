
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:proequine/core/constants/colors/app_colors.dart';
import 'package:proequine/core/constants/images/app_images.dart';
import 'package:proequine/core/constants/thems/app_styles.dart';

import '../../../../core/utils/sharedpreferences/SharedPreferencesHelper.dart';
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
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: AppSharedPreferences.getTheme == 'ThemeCubitMode.dark'
            ? AppColors.formsBackground
            : AppColors.white,
        // color: const Color(0xff191919),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 19),
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
                    Text(
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
                    Text(
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
                    Text(
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
                    Text(
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
                    Text(
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
                    height: 10,
                  ),
            formData!.comment!.isNotEmpty
                ? Row(
                    children: [
                      Transform.translate(
                          offset: const Offset(0.0, -17),
                          child: SvgPicture.asset(AppIcons.note)),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: 1,
                            itemBuilder: (context, index) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Note",
                                    style: AppStyles.summaryTitleStyle,
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    '${formData!.comment}',
                                    maxLines: 5,
                                    overflow: TextOverflow.ellipsis,
                                    style: AppStyles.summaryDesStyle,
                                  ),
                                ],
                              );
                            }),
                      ),
                    ],
                  )
                : const SizedBox(),

            // SizedBox(height: 12,)
          ],
        ),
      ),
    );
  }
}
