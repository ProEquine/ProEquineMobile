import 'package:flutter/material.dart';
import 'package:proequine/core/constants/constants.dart';
import 'package:proequine/core/constants/images/app_images.dart';
import 'package:proequine/core/widgets/rebi_button.dart';
import 'package:proequine/core/widgets/success_state_widget.dart';
import 'package:proequine/features/home/presentation/widgets/summary_widget.dart';
import 'package:proequine/features/nav_bar/presentation/screens/bottomnavigation.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/widgets/custom_header.dart';

class LocalSummary extends StatelessWidget {
  LocalSummary({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(20.0.h),
        child: CustomHeader(
          title: "Summary",
          isThereBackButton: true,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kPadding, vertical: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: const DecorationImage(
                      image: AssetImage(AppImages.summary),
                    )),
                child: Image.asset(AppImages.summary),
              ),
              const SizedBox(
                height: 14,
              ),
              SummaryBoxWidget(),
              const SizedBox(
                height: 14,
              ),
              RebiButton(
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
                                                BottomNavigation(
                                                  selectedIndex: 1,
                                                )),);
                                  },
                                  isThereButton: true,
                                  buttonText: "View my booking",
                              isItVerifyPhone: false,
                                )));
                  },
                  child: const Text("Confirm")),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
