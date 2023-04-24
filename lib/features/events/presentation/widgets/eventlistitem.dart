import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:proequine/core/constants/images/app_images.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/constants/icons/icons.dart';

class EventListItem extends StatelessWidget {
  final String? imageUrl;
  final String? description;
  final String? eventTitle;
  final String? date;

  EventListItem({this.imageUrl, this.description, this.eventTitle, this.date});

  @override
  Widget build(BuildContext context) {
    return Container(
      /// this height calculated by figma
      height: 13.0.h,

      child: Row(children: [
        Expanded(
          flex: 6,
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                    image: NetworkImage(imageUrl!), fit: BoxFit.fill)),
          ),
        ),
        const Spacer(
          flex: 1,
        ),
        Expanded(
          flex: 14,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  eventTitle!,
                  textAlign: TextAlign.left,
                  style:const  TextStyle(
                    fontSize: 18,
                    fontFamily: "notosan",
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Spacer(flex: 1,),
                Row(
                  children: [
                    SvgPicture.asset(
                      AppIcons.calendar,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      date!,
                      style: const TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              Spacer(flex: 1,),
                Row(
                  children: [
                    SvgPicture.asset(
                      AppIcons.calendar,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    const Text(
                      "04:30 PM",
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ],
            ),
          ),
      ]),
    );
  }
}
