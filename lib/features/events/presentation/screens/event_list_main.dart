import 'package:flutter/material.dart';
import 'package:proequine/core/constants/images/app_images.dart';
import 'package:proequine/features/events/presentation/widgets/all_events_list.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/widgets/titlebar.dart';
import '../widgets/eventitem.dart';

class EventListMain extends StatelessWidget {
  const EventListMain({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      // child: EventList(),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: 10.0, top: 20, bottom: 20, right: 10),
                child: TitleBar('Upcoming Event'),
              ),
              SizedBox(
                height: 65.h,
                width: double.infinity,
                // TODO : when getting api remove the const then put Api data
                child: const EventItem(
                  imgUrl: AppImages.upComingEvent,
                  national: "UAE LONGINES",
                  team: 'TEAM MASTER',
                  date: '12-13 Oct',
                  location: 'EEC',
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 10.0, top: 20, right: 10),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "All Events",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                      fontFamily: "notosan",
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 50.0.h,
                child: const AllEventsScreen(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
