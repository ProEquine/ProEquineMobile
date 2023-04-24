import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';


class NoBooking extends StatelessWidget {
  const NoBooking({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Container(
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
            style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    ));
  }
}
