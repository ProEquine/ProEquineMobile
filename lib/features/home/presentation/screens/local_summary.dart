import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:proequine/core/constants/colors/app_colors.dart';
import 'package:proequine/core/constants/constants.dart';
import 'package:proequine/core/constants/images/app_images.dart';
import 'package:proequine/core/constants/thems/app_styles.dart';
import 'package:proequine/core/widgets/rebi_button.dart';
import 'package:proequine/core/widgets/success_state_widget.dart';
import 'package:proequine/features/home/data/form_data_model.dart';
import 'package:proequine/features/home/presentation/widgets/summary_widget.dart';
import 'package:proequine/features/nav_bar/presentation/screens/bottomnavigation.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/utils/sharedpreferences/SharedPreferencesHelper.dart';
import '../../../../core/widgets/custom_header.dart';

class LocalSummary extends StatelessWidget {
  final FromDataModel? formData;

  const LocalSummary({super.key, required this.formData});

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
              formData: formData,
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    AppSharedPreferences.getTheme == 'ThemeCubitMode.dark'
                        ? AppColors.backgroundColor
                        : AppColors.backgroundColorLight,
                side: BorderSide(
                  width: 2, // the thickness
                  color: AppSharedPreferences.getTheme == 'ThemeCubitMode.dark'
                      ? AppColors.white
                      : AppColors.backgroundColor,
                ),
                minimumSize: const Size(double.infinity, 50),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
              ),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(AppIcons.edit),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      "Edit",
                      style: AppStyles.buttonTitle,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 14,
            ),
            RebiButton(
                backgroundColor:
                    AppSharedPreferences.getTheme == 'ThemeCubitMode.dark'
                        ? Colors.white
                        : AppColors.backgroundColor,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SuccessStateScreen(
                                title:
                                    "Your Request has been Submitted successfully",
                                onButtonPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const BottomNavigation(
                                              selectedIndex: 1,
                                            )),
                                  );
                                },
                                isThereButton: true,
                                buttonText: "View my booking",
                                isItVerifyPhone: false,
                              )));
                },
                child: const Text("Confirm")),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
