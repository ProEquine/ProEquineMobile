import 'package:flutter/material.dart';
import 'package:proequine/core/constants/images/app_images.dart';
import 'package:proequine/core/widgets/custom_back_button.dart';
import 'package:sizer/sizer.dart';

class ThanksWidget extends StatelessWidget {
  const ThanksWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                height: 43.0.h,
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Color(0xff000000),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(AppImages.supportThanks),
                  ),
                ),
              ),
              const Positioned(
                  top: 20,
                  left: 30,
                  child: CustomBackButton(
                    size: 40,
                  ))
            ],
          ),
          const Padding(
            padding: EdgeInsets.only(left: 16.0, right: 16, top: 16),
            child: Text(
              "Thank you for reaching out to us! \n",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 16.0, right: 16),
            child: Text(
              "We have received your request and one of our support team members will get back to you as soon as possible.\n\n Your request is important to us and we will do our best to resolve your issue in a timely manner. \n\n Thank you for using ProEquine App, and we look forward to assisting you further.\n\n Best regards, \n ProEquine Support Team",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          )
        ],
      ),
    );
  }
}
