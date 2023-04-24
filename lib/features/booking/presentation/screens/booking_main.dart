import 'package:flutter/material.dart';

import '../widgets/bookings.dart';


class BookingMain extends StatelessWidget {
  const BookingMain({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
          child: Padding(
        padding:  EdgeInsets.all(20.0),
        child: Booking(),
      )),
    );
  }
}
