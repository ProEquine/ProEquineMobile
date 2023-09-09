import 'package:flutter/material.dart';
import 'package:proequine/core/constants/colors/app_colors.dart';
import 'package:proequine/core/constants/constants.dart';
import 'package:proequine/core/widgets/rebi_button.dart';
import 'package:proequine/core/widgets/success_state_widget.dart';
import 'package:proequine/features/home/data/join_show_request_model.dart';
import 'package:proequine/features/home/data/trip_service_data_model.dart';
import 'package:proequine/features/home/presentation/widgets/summary_widget.dart';
import 'package:proequine/features/nav_bar/presentation/screens/bottomnavigation.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/utils/sharedpreferences/SharedPreferencesHelper.dart';
import '../../../../core/widgets/custom_header.dart';

class LocalSummary extends StatelessWidget {
  final TripServiceDataModel? tripServiceDataModel;
  final JoinShowTransportRequestModel? joinShowTransportRequestModel;

  const LocalSummary({super.key, this.tripServiceDataModel, this.joinShowTransportRequestModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(20.0.h),
        child: CustomHeader(
          title: "Summary",
          isThereBackButton: false,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kPadding, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 14,
            ),
            SummaryBoxWidget(
              tripServiceDataModel: tripServiceDataModel,
            ),
            const Spacer(),
            RebiButton(
                //
                onPressed: () {

                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const BottomNavigation(
                                              selectedIndex: 1,
                                            )),
                                  );
                },
                child: const Text("Close")),
            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}
