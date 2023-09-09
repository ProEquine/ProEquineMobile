import 'package:flutter/material.dart';
import 'package:proequine/core/constants/colors/app_colors.dart';

import 'package:proequine/core/constants/thems/app_styles.dart';

import '../../../../core/utils/sharedpreferences/SharedPreferencesHelper.dart';
import '../../../../core/widgets/divider.dart';
import '../../data/trip_service_data_model.dart';

class SummaryBoxWidget extends StatelessWidget {
  final TripServiceDataModel? tripServiceDataModel;

  const SummaryBoxWidget({super.key, required this.tripServiceDataModel});

  String returnDate() {
    if (tripServiceDataModel!.tripType == "Other day return" &&
        tripServiceDataModel!.expectedTime!.isNotEmpty) {
      return "Returning: ${tripServiceDataModel!.expectedDate} • ${tripServiceDataModel!.expectedTime}";
    } else if (tripServiceDataModel!.tripType == "Same day return" &&
        tripServiceDataModel!.expectedTime!.isNotEmpty) {
      return "Returning:  ${tripServiceDataModel!.pickupDate} • ${tripServiceDataModel!.expectedTime}";
    } else {
      return "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 0.50, color: Color(0xFFDFD9C9)),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Padding(
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
                  "${tripServiceDataModel!.pickupDate} • ${tripServiceDataModel!.pickupTime}",
                  style: AppStyles.summaryDesStyle,
                ),
                Text(
                  tripServiceDataModel!.tripType,
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
                  tripServiceDataModel!.pickupLocation,
                  style: AppStyles.summaryDesStyle,
                ),
                Text(
                  "${tripServiceDataModel!.pickupContactName} • ${tripServiceDataModel!.pickupContactNumber}",
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
                  tripServiceDataModel?.dropLocation ??
                      tripServiceDataModel?.hospitalName ??
                      'non',
                  style: AppStyles.summaryDesStyle,
                ),
                Text(
                  "${tripServiceDataModel!.dropContactName} • ${tripServiceDataModel!.dropContactNumber}",
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
                  tripServiceDataModel!.horsesNumber,
                  style: AppStyles.summaryDesStyle,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
