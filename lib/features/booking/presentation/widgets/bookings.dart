import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:proequine/core/constants/images/app_images.dart';
import 'package:proequine/features/booking/presentation/screens/timeline.dart';
import 'package:proequine/features/booking/presentation/widgets/bookingitem.dart';
import 'package:proequine/features/booking/presentation/widgets/peniding_booking_items.dart';
import '../../../../core/constants/colors/app_colors.dart';
import 'confirmBookingitem.dart';

class Booking extends StatelessWidget {
  const Booking({super.key});

  @override
  Widget build(BuildContext context) {
    String getGroupName(String groupByValue) {
      // Map numeric values to group names
      switch (groupByValue) {
        // case 'Unpaid':
        //   return 'Unpaid';
        case 'Ongoing':
          return 'Ongoing';
        case 'Scheduled':
          return 'Scheduled';
        default:
          return 'Other';
      }
    }

    const List elements = [
      //TODO: That's for unPaid
      // {
      //   'type': 'Pending',
      //   // 'group': 'Unpaid',
      //   'pending': true,
      //   'bookingId': "LT9666",
      //   'date': '15 - 17 Sep',
      //   'horseCount': 2,
      //   'transport': 'Nat Show',
      //   'transportType': 'DEC'
      // },
      // {
      //   'type': 'Pending',
      //   // 'group': 'Unpaid',
      //   'pending': true,
      //   'bookingId': "LT9667",
      //   'date': '15 - 19 Sep',
      //   'horseCount': 2,
      //   'transport': 'Nat Show',
      //   'transportType': 'DEC'
      // },
      {
        'type': 'On the way to pick up',
        'group': 'Ongoing',
        'pending': false,
        'bookingId': "LT9664",
        'date': '15 - 17 Sep',
        'horseCount': 2,
        'transport': 'Nat Show',
        'transportType': 'DEC'
      },
      {
        'type': 'On the way to pick up',
        'group': 'Ongoing',
        'pending': false,
        'bookingId': "LT9665",
        'date': '15 - 18 Sep',
        'horseCount': 4,
        'transport': 'Nat Show',
        'transportType': 'DEC'
      },
      {
        'type': 'Scheduled',
        'group': 'Scheduled',
        'pending': false,
        'bookingId': "LT9674",
        'date': '15 - 17 Sep',
        'horseCount': 2,
        'transport': 'Nat Show',
        'transportType': 'DEC'
      },
      {
        'type': 'Scheduled',
        'group': 'Scheduled',
        'pending': false,
        'bookingId': "LT9677",
        'date': '15 - 17 Sep',
        'horseCount': 2,
        'transport': 'Nat Show',
        'transportType': 'DEC'
      },
      {
        'type': 'Scheduled',
        'group': 'Scheduled',
        'pending': false,
        'bookingId': "LT9664",
        'date': '15 - 17 Sep',
        'horseCount': 2,
        'transport': 'Nat Show',
        'transportType': 'DEC'
      },
    ];
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            GroupedListView<dynamic, String>(
              elements: elements,
              shrinkWrap: true,
              groupBy: (element) {
                // Group items based on their category
                if (element['group'] == 'Unpaid') {
                  return 'Unpaid';
                } else if (element['group'] == 'Ongoing') {
                  return 'Ongoing';
                } else if (element['group'] == 'Scheduled') {
                  return 'Scheduled';
                } else {
                  return 'Other';
                }
              },
              groupComparator: (value2, value3) => value2.compareTo(value2),
              groupSeparatorBuilder: (String value) => Padding(
                padding: const EdgeInsets.only(bottom: 11, top: 5),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    getGroupName(value),
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: AppColors.grey),
                  ),
                ),
              ),
              itemBuilder: (c, element) {
                if (element['group'] == 'Ongoing') {
                  return InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  BookingTrack(
                            image: AppImages.hospitalTransport,
                            type: element['type'],
                            bookingId: element['bookingId'],
                            date: element['date'],
                            horsesCount: element['horseCount'],
                            transport: element['transport'],
                            transportType: element['transportType'],
                          ),
                          transitionDuration: const Duration(milliseconds: 300),
                          // Set duration
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                            var begin =
                                const Offset(0.0, 1.0); // Set begin offset
                            var end = Offset.zero; // Set end offset
                            var curve = Curves.easeOut; // Set curve

                            var tween = Tween(begin: begin, end: end)
                                .chain(CurveTween(curve: curve));

                            return SlideTransition(
                              position: animation.drive(tween),
                              child: child,
                            );
                          },
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 3.0),
                      child: BookingItem(
                        type: element['type'],
                        pending: element['pending'],
                        bookingId: element['bookingId'],
                        date: element['date'],
                        horsesCount: element['horseCount'],
                        transport: element['transport'],
                        transportType: element['transportType'],
                      ),
                    ),
                  );
                } else if (element['group'] == 'Unpaid') {
                  return PendingBookingItem(
                    type: element['type'],
                    bookingId: element['bookingId'],
                    date: element['date'],
                    transport: element['transport'],
                  );
                }
                return const ConfirmBookingItem(
                  date: '15 Sep • 04:30 pm',
                  horsesCount: 4,
                  transport: "Nat Show",
                  bookingId: 'LT9677',
                );
              },
            ),
            const SizedBox(height: 60,),
          ],
        ),
      ),
    );
  }
}
