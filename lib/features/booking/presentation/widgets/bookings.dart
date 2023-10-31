import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:proequine/core/constants/images/app_images.dart';
import 'package:proequine/core/widgets/shimmer.dart';
import 'package:proequine/features/booking/presentation/screens/timeline.dart';
import 'package:proequine/features/booking/presentation/widgets/bookingitem.dart';
import 'package:proequine/features/booking/presentation/widgets/draft_list_item.dart';
import 'package:proequine/features/booking/presentation/widgets/empty_service_widget.dart';
import 'package:proequine/features/booking/presentation/widgets/peniding_booking_items.dart';
import 'package:proequine/features/home/domain/cubits/local_horse_cubit.dart';
import 'package:proequine/features/home/domain/repo/local_storage_repository.dart';
import '../../../../core/constants/colors/app_colors.dart';
import '../../../../core/constants/thems/app_styles.dart';
import '../../../../core/utils/Printer.dart';
import 'booking_item_widget.dart';

class Booking extends StatelessWidget {
  final String type;
  bool isLoading = false;

  Booking({super.key, required this.type, this.isLoading = false});

  @override
  Widget build(BuildContext context) {
    LocalHorseCubit localHorseCubit =
        LocalHorseCubit(localStorageRepository: LocalStorageRepository());
    String getGroupName(String groupByValue) {
      // Map numeric values to group names
      switch (groupByValue) {
        // case 'Unpaid':
        //   return 'Unpaid';
        case 'Ongoing':
          return 'Ongoing';
        case 'Requested':
          return 'Requested';
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
        'transport': 'Local',
        'transportType': 'DEC'
      },
      {
        'type': 'On the way to pick up',
        'group': 'Ongoing',
        'pending': false,
        'bookingId': "LT9665",
        'date': '15 - 18 Sep',
        'horseCount': 4,
        'transport': 'Hospital',
        'transportType': 'DEC'
      },
      {
        'type': 'Requested',
        'group': 'Requested',
        'pending': false,
        'bookingId': "LT9674",
        'date': '15 - 17 Sep',
        'horseCount': 2,
        'transport': 'Nat Show',
        'transportType': 'DEC'
      },
      {
        'type': 'Requested',
        'group': 'Requested',
        'pending': false,
        'bookingId': "LT9677",
        'date': '15 - 17 Sep',
        'horseCount': 2,
        'transport': 'Nat Show',
        'transportType': 'DEC'
      },
      {
        'type': 'Requested',
        'group': 'Requested',
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
            // type=='Shipping'?
            // GroupedListView<dynamic, String>(
            //   elements: elements,
            //   shrinkWrap: true,
            //   groupBy: (element) {
            //     // Group items based on their category
            //     if (element['group'] == 'Unpaid') {
            //       return 'Unpaid';
            //     } else if (element['group'] == 'Ongoing') {
            //       return 'Ongoing';
            //     } else if (element['group'] == 'Requested') {
            //       return 'Requested';
            //     } else {
            //       return 'Other';
            //     }
            //   },
            //   groupComparator: (value2, value3) => value2.compareTo(value2),
            //   groupSeparatorBuilder: (String value) => Padding(
            //     padding: const EdgeInsets.only(bottom: 11, top: 20),
            //     child: Align(
            //       alignment: Alignment.centerLeft,
            //       child: Text(
            //         getGroupName(value),
            //         style: const TextStyle(
            //           fontSize: 16,
            //           fontWeight: FontWeight.w500,
            //         ),
            //       ),
            //     ),
            //   ),
            //   itemBuilder: (c, element) {
            //     if (element['group'] == 'Ongoing') {
            //       return const BookingItemWidget(
            //         status: "Confirmed",
            //         date: '15 Sep • 04:30 pm',
            //         horsesCount: 2,
            //         from: "DEC",
            //         to: "DEH",
            //         transportType: "Shipping",
            //         bookingId: 'LT9677',
            //       );
            //     } else if (element['group'] == 'Unpaid') {
            //       return PendingBookingItem(
            //         type: element['type'],
            //         bookingId: element['bookingId'],
            //         date: element['date'],
            //         transport: element['transport'],
            //       );
            //     }
            //     return const BookingItemWidget(
            //       status: "Pending",
            //       date: '15 Sep • 04:30 pm',
            //       horsesCount: 4,
            //       from: "DEC",
            //       to: "DEH",
            //       transportType: "Shipping",
            //       bookingId: 'LT9677',
            //     );
            //   },
            // ):
            // GroupedListView<dynamic, String>(
            //   elements: elements,
            //   shrinkWrap: true,
            //   groupBy: (element) {
            //     // Group items based on their category
            //     if (element['group'] == 'Unpaid') {
            //       return 'Unpaid';
            //     } else if (element['group'] == 'Ongoing') {
            //       return 'Ongoing';
            //     } else if (element['group'] == 'Requested') {
            //       return 'Requested';
            //     } else {
            //       return 'Other';
            //     }
            //   },
            //   groupComparator: (value2, value3) => value2.compareTo(value2),
            //   groupSeparatorBuilder: (String value) => Padding(
            //     padding: const EdgeInsets.only(bottom: 11, top: 20),
            //     child: Align(
            //       alignment: Alignment.centerLeft,
            //       child: Text(
            //         getGroupName(value),
            //         style: const TextStyle(
            //           fontSize: 16,
            //           fontWeight: FontWeight.w500,
            //         ),
            //       ),
            //     ),
            //   ),
            //   itemBuilder: (c, element) {
            //     if (element['group'] == 'Ongoing') {
            //       return const BookingItemWidget(
            //         status: "Pending",
            //         date: '15 Sep • 04:30 pm',
            //         horsesCount: 4,
            //         from: "DEC",
            //         to: "DEH",
            //         transportType: "Local Transport",
            //         bookingId: 'LT9677',
            //       );
            //     } else if (element['group'] == 'Unpaid') {
            //       return PendingBookingItem(
            //         type: element['type'],
            //         bookingId: element['bookingId'],
            //         date: element['date'],
            //         transport: element['transport'],
            //       );
            //     }
            //     return const BookingItemWidget(
            //       status: "Confirmed",
            //       date: '15 Sep • 04:30 pm',
            //       horsesCount: 4,
            //       from: "DEC",
            //       to: "DEH",
            //       transportType: "Local Transport",
            //       bookingId: 'LT9677',
            //     );
            //   },
            // ),
            type == 'Shipping'
                ? Column(
                    children: [
                      BlocConsumer<LocalHorseCubit, LocalHorseState>(
                          bloc: localHorseCubit..getAllTrips(),
                          builder: (context, state) {
                            Print('state $state');

                            if (state is GetTripsSuccessfully) {
                              if (state.items.isEmpty) {
                                return const SizedBox();
                              }

                              return DraftListItem(items: state.items);
                            } else if (state is GetTripsLoading) {
                              // return const LoadingCircularWidget();
                            } else if (state is GetTripsError) {
                              return Container(
                                height: 50,
                                width: 50,
                                color: AppColors.gold,
                              );
                            }
                            return Container();
                          },
                          listener: (context, state) {
                            if (state is DeleteTripSuccessfully) {
                              localHorseCubit.getAllTrips();
                            }
                          }),
                      // SizedBox(
                      //   height:30,
                      // ),
                      ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: 5,
                          itemBuilder: (context, index) {
                            return isLoading
                                ? const Padding(
                                    padding: EdgeInsets.symmetric(vertical: 3),
                                    child: Shimmer(
                                      child: ShimmerLoading(
                                        isLoading: true,
                                        child: BookingItemWidget(
                                          status: "Pending",
                                          date: '15 Sep • 04:30 pm',
                                          horsesCount: 2,
                                          from: "DEC",
                                          to: "DEH",
                                          transportType: "Shipping Transport",
                                          bookingId: 'LT9677',
                                        ),
                                      ),
                                    ),
                                  )
                                : const Padding(
                                    padding: EdgeInsets.symmetric(vertical: 3),
                                    child: BookingItemWidget(
                                      status: "Pending",
                                      date: '15 Sep • 04:30 pm',
                                      horsesCount: 2,
                                      from: "DEC",
                                      to: "DEH",
                                      transportType: "Hospital Transport",
                                      bookingId: 'LT9677',
                                    ),
                                  );
                          })
                    ],
                  )
                : type == 'Transport'
                    ? ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return isLoading
                              ? const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 3),
                                  child: Shimmer(
                                    child: ShimmerLoading(
                                      isLoading: true,
                                      child: BookingItemWidget(
                                        status: "Pending",
                                        date: '15 Sep • 04:30 pm',
                                        horsesCount: 2,
                                        from: "DEC",
                                        to: "DEH",
                                        transportType: "Hospital Transport",
                                        bookingId: 'LT9677',
                                      ),
                                    ),
                                  ),
                                )
                              : const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 3),
                                  child: BookingItemWidget(
                                    status: "Pending",
                                    date: '15 Sep • 04:30 pm',
                                    horsesCount: 2,
                                    from: "DEC",
                                    to: "DEH",
                                    transportType: "Hospital Transport",
                                    bookingId: 'LT9677',
                                  ),
                                );
                        })
                    : EmptyServiceScreen(serviceType: type),
            const SizedBox(
              height: 60,
            ),
          ],
        ),
      ),
      // body: Column(
      //   children: const [
      //     SizedBox(height: 40,),
      //     NoBooking(),
      //   ],
      // ),
    );
  }
}
