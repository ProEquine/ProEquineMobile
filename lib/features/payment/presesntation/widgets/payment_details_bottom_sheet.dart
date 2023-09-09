import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/colors/app_colors.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/constants/thems/app_styles.dart';
import '../../../../core/utils/sharedpreferences/SharedPreferencesHelper.dart';
import '../../../../core/widgets/divider.dart';

void paymentDetailsBottomSheet({
  required BuildContext context,
  required String title,
  required String pickUpDate,
  required String pickUpTime,
  required String tripType ,
  required String pickupLocation,
  required String pickupContactNumber,
  required String pickupContactName,
  required String dropLocation,
  required String dropContactName,
  required String dropContactNumber,
  required String horsesNumber,
}) {
  showModalBottomSheet(
    isScrollControlled: true,
    backgroundColor: AppSharedPreferences.getTheme == 'ThemeCubitMode.dark'
        ? AppColors.formsBackground
        : AppColors.backgroundColorLight,
    useSafeArea: false,
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
    ),
    builder: (BuildContext context) {
      return Wrap(children: [
        Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: SizedBox(
            child: Padding(
              padding:  const EdgeInsets.only(
                  top: kPadding, left: kPadding, right: kPadding),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(
                          width: 20,
                        ),
                        Center(
                          child: Text(title,
                              style: TextStyle(
                                  fontSize: 17,
                                  fontFamily: "notosan",
                                  fontWeight: FontWeight.w600,
                                  color: AppSharedPreferences.getTheme ==
                                          'ThemeCubitMode.dark'
                                      ? Colors.white
                                      : AppColors.blackLight)),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.close,
                            size: 18,
                            color: AppColors.yellow,
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: kPadding,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 19),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Service",
                                style: AppStyles.summaryTitleStyle,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                "$pickUpDate • $pickUpTime",
                                style: AppStyles.summaryDesStyle,
                              ),
                              Text(
                                tripType,
                                style: AppStyles.summaryDesStyle,
                              ),
                            ],
                          ),
                          const CustomDivider(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Pick up",
                                style: AppStyles.summaryTitleStyle,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                pickupLocation,
                                style: AppStyles.summaryDesStyle,
                              ),
                              Text(
                                "$pickupContactName • $pickupContactNumber",
                                style: AppStyles.summaryDesStyle,
                              ),
                            ],
                          ),
                          const CustomDivider(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Drop off",
                                style: AppStyles.summaryTitleStyle,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                dropLocation,
                                style: AppStyles.summaryDesStyle,
                              ),
                              Text(
                                "$dropContactName • $dropContactNumber",
                                style: AppStyles.summaryDesStyle,
                              ),
                            ],
                          ),
                          const CustomDivider(),
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
                                horsesNumber,
                                style: AppStyles.summaryDesStyle,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ]);
    },
  );
}
