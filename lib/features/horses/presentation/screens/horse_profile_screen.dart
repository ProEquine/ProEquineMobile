import 'package:flutter/material.dart';

import 'package:proequine/core/constants/constants.dart';
import 'package:proequine/core/constants/thems/app_styles.dart';

import 'package:proequine/features/horses/presentation/screens/edit_horse_screen.dart';
import 'package:proequine/features/horses/presentation/screens/horse_document_screen.dart';
import 'package:proequine/features/horses/presentation/screens/horse_verification_screen.dart';

import 'package:sizer/sizer.dart';

import '../../../../core/constants/images/app_images.dart';
import '../../../../core/widgets/custom_header.dart';
import '../../../../core/widgets/rebi_button.dart';
import '../../../history/presentation/screens/history_screen.dart';
import '../../../../core/widgets/profile_list_tile_widget.dart';
import '../widgets/horse_card-widget.dart';
import 'equine_info_horses_screen.dart';

class HorseProfileScreen extends StatefulWidget {
  const HorseProfileScreen({super.key});

  @override
  State<HorseProfileScreen> createState() => _HorseProfileScreenState();
}

class _HorseProfileScreenState extends State<HorseProfileScreen> {
  @override
  Widget build(BuildContext context) {
    // final themeCubit = ThemeCubitProvider.of(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(20.h),
        child: CustomHeader(
          title: "Horse Profile",
          isThereBackButton: true,
          isThereChangeWithNavigate: false,
          isThereThirdOption: true,
          thirdOptionTitle: 'Edit',
          onPressThirdOption: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => EditHorseScreen(
                  selectedColor: "Black",
                  selectedGender: "Mare",
                  selectedBreed: "Arabian",
                  selectedBloodLine: "Bold Ruler",
                  selectedYear: 2000,
                  birthOfDate: "13 Jan 2000",
                  horseName: "Stormy",
                  placeOfBirth: "France",
                  image: AppImages.stormy,
                )));
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: kPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: HorseCardWidget(
                  age: '14',
                  gender: 'Mare',
                  breed: "Selle",
                  placeOfBirth: "Français",
                  horseName: 'Stormy',
                  discipline: "Show jumping",
                  horsePic: AppImages.stormy,
                  isVerified: false,
                  horseStable: "Malath",
                  horseStatus: "Lame",
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  "Horse Services",
                  style: AppStyles.profileTitles,
                  textAlign: TextAlign.start,
                ),
              ),

              ProfileListTileWidget(
                title: "Equine Info",
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const EquineInfoHorsesScreen()));
                },
                notificationList: false,
                isThereNewNotification: false,
              ),
              ProfileListTileWidget(
                title: "Horse Document",
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HorseDocumentScreen()));
                },
                notificationList: false,
                isThereNewNotification: false,
              ),
              // ProfileDivider(),
              // ProfileListTileWidget(
              //   title: "Media Gallery",
              //   onTap: () {
              //     Navigator.push(
              //         context,
              //         MaterialPageRoute(
              //             builder: (context) => const HistoryScreen()));
              //   },
              //   notificationList: false,
              //   isThereNewNotification: false,
              // ),
              // ProfileListTileWidget(
              //   title: "Shipping",
              //   onTap: () {
              //     Navigator.push(
              //         context,
              //         MaterialPageRoute(
              //             builder: (context) => const HistoryScreen()));
              //   },
              //   notificationList: false,
              //   isThereNewNotification: false,
              // ),
              // ProfileListTileWidget(
              //   title: "Transport",
              //   onTap: () {
              //     Navigator.push(
              //         context,
              //         MaterialPageRoute(
              //             builder: (context) => const HistoryScreen()));
              //   },
              //   notificationList: false,
              //   isThereNewNotification: false,
              // ),

              const SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: RebiButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HorseVerificationScreen()));
                  },
                  child: const Text("Get your horse verified"),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
