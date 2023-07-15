import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:proequine/core/constants/constants.dart';
import 'package:proequine/core/constants/images/app_images.dart';
import 'package:proequine/features/home/presentation/screens/create_trip_screen.dart';
import 'package:proequine/features/home/presentation/widgets/service_widget.dart';
import 'package:proequine/features/home/presentation/widgets/shipping_widget.dart';
import '../../../../core/constants/colors/app_colors.dart';
import '../../../../core/utils/sharedpreferences/SharedPreferencesHelper.dart';
import '../widgets/home_cardfull.dart';
import '../widgets/homebottomcard.dart';
import 'create_event_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: NestedScrollView(
          floatHeaderSlivers: true,
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverLayoutBuilder(builder: (context, constraints) {
              final scrolled = constraints.scrollOffset > 10;
              return SliverAppBar(
                elevation: 0,
                automaticallyImplyLeading: false,
                backgroundColor:
                    AppSharedPreferences.getTheme == 'ThemeCubitMode.dark'
                        ? Colors.black
                        : AppColors.backgroundColorLight,
                expandedHeight: 60,
                collapsedHeight: 60,
                flexibleSpace: ClipRect(
                  child: FlexibleSpaceBar(
                    expandedTitleScale: 1,
                    // centerTitle:  scrolled?true:false ,
                    title: AnimatedAlign(
                      alignment:
                          scrolled ? Alignment.topCenter : Alignment.bottomLeft,
                      duration: const Duration(milliseconds: 200),
                      child: Padding(
                        padding: EdgeInsets.only(left: scrolled ? 0 : kPadding),
                        child: SizedBox(
                          width: 150,
                          child: SvgPicture.asset(
                            AppSharedPreferences.getTheme ==
                                    'ThemeCubitMode.dark'
                                ? AppIcons.proEquine
                                : AppIcons.proEquineLight,
                            height: 32,
                            width: 32,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                snap: false,
                floating: false,
                pinned: false,
              );
            }),
          ],
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: kPadding),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const HomeCardFull(),
                  const SizedBox(
                    height: 16,
                  ),
                  const Text(
                    'Transportation',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(top: 10.0),
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
                                      builder: (context) =>
                                          CreateTripScreen()));
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
                          // const EventComingSoon(),
                          ServiceWidget(
                            image: AppImages.event,
                            isItDisable: true,
                            title: 'Event',
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const CreateEventScreen()));
                            },
                          ),
                        ],
                      )),
                  const Padding(
                    padding: EdgeInsets.only(
                      top: 10,
                      bottom: 16,
                    ),
                    child: HomeBottomCard(),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    child: Text(
                      'Shipping',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      ShippingWidget(
                        image: AppImages.import,
                        title: 'Import',
                        onTap: () {},
                      ),
                      const SizedBox(
                        width: 26,
                      ),
                      ShippingWidget(
                        image: AppImages.export,
                        title: 'Export',
                        onTap: () {},
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 70,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
