import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/constants/colors/app_colors.dart';

class NoBooking extends StatelessWidget {
  const NoBooking({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        // SizedBox(height: 40,),
        SizedBox(
          width: double.infinity,
          child: Image.asset(
            'assets/images/nobooking.png',
            fit: BoxFit.cover,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: Text(
            "Looks like you don’t have any bookings",
            style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.w500,
                color: const Color(0xffD0D3D6)),
          ),
        ),
      ],
    ));
  }
}
