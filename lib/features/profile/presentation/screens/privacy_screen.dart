import 'package:flutter/material.dart';
import 'package:proequine/core/constants/colors/app_colors.dart';
import 'package:proequine/core/constants/constants.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/widgets/custom_header.dart';

class PrivacyScreen extends StatelessWidget {
  const PrivacyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(20.0.h),
        child: CustomHeader(
          title: "Privacy policy & Legal",
          isThereBackButton: true,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kPadding,vertical: kPadding),
        child: SingleChildScrollView(child:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              "Privacy",
              style: TextStyle(
                  color: AppColors.white,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'notosan',
                  fontSize: 18),
            ),
            SizedBox(height: 20,),
            Text(
              '• At ProEquine, we are committed to protecting your privacy. This privacy policy applies to the information we collect through our website and horse transportation services. \n• We may collect personal information from you, such as your name, address, email address, and telephone number. We may also collect information about your horse, such as its name, breed, age, and any medical information that is relevant to its transport.  \n• We will not share your personal information with any third party except as necessary to complete your booking or as required by law. \n• We take reasonable precautions to protect your personal information from unauthorized access or use. However, please be aware that no method of internet transmission is completely secure. \n• Our website may contain links to third-party websites. We are not responsible for the privacy practices or content of these websites. ',
              style: TextStyle(
                  color: AppColors.white,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'notosan',
                  fontSize: 14),
            ),
          ],
        ),
      ),
      )
    );
  }
}
