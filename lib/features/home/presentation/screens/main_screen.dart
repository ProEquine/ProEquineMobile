import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:proequine/core/constants/images/app_images.dart';
import 'package:proequine/features/home/presentation/screens/create_event_screen.dart';
import 'package:proequine/features/home/presentation/screens/create_trip_screen.dart';
import 'package:proequine/features/home/presentation/widgets/service_widget.dart';
import 'package:proequine/features/home/presentation/widgets/shipping_widget.dart';
import 'package:sizer/sizer.dart';

import '../../../profile/presentation/screens/user_profile.dart';
import '../widgets/home_cardfull.dart';
import '../widgets/homebottomcard.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(23.0.h),
        child: ClipRect(
          child: BackdropFilter(
            // blendMode: BlendMode.color,
            filter: ImageFilter.blur(
              sigmaX: 20.0,
              sigmaY: 20.0,
            ),
            child: Container(
              // color: AppColors.backgroundColor,
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 50, bottom: 20, left: 20, right: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 150,
                      child: Image.asset(AppImages.proEquine),
                    ),
                    GestureDetector(
                      child: SvgPicture.asset(AppIcons.userSquare,height: 40,width: 40,),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UserProfile(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const HomeCardFull(),
                  Padding(
                      padding: const EdgeInsets.only(top: 30.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ServiceWidget(
                            image: AppImages.local,
                            title: 'Local',
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CreateTripScreen(
                                        type: 'local',
                                      )));
                            },
                          ),
                          ServiceWidget(
                            image: AppImages.hospital,
                            title: 'Hospital',
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CreateTripScreen(
                                        type: 'hospital',
                                      )));
                            },
                          ),
                          ServiceWidget(
                            image: AppImages.event,
                            title: 'Event',
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CreateEventScreen()));
                            },
                          ),
                        ],
                      )),
                  const Padding(
                    padding: EdgeInsets.only(
                      top: 30,
                      bottom: 5,
                    ),
                    child: HomeBottomCard(),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 30, bottom: 10),
                    child: Text(
                      'Shipping',
                      textAlign: TextAlign.start,
                      style:
                      TextStyle(fontSize: 24.0, fontWeight: FontWeight.w500),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      ShippingWidget(
                        image: AppImages.import,
                        title: 'Import',
                        onTap: () {
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => CreateTripScreen(
                          //           type: 'hospital',
                          //         )));
                        },
                      ),
                     SizedBox(width: 26,),
                      ShippingWidget(
                        image: AppImages.export,
                        title: 'Export',
                        onTap: () {
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => CreateTripScreen(
                          //           type: 'local',
                          //         )));
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 60,),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}