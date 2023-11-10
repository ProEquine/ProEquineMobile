import 'package:flutter/material.dart';

import 'package:proequine/core/constants/constants.dart';
import 'package:proequine/core/constants/thems/app_styles.dart';
import 'package:proequine/features/horses/data/get_user_horses_response_model.dart';

import 'package:proequine/features/horses/presentation/screens/edit_horse_screen.dart';
import 'package:proequine/features/horses/presentation/screens/horse_document_screen.dart';
import 'package:proequine/features/horses/presentation/screens/horse_verification_screen.dart';

import 'package:sizer/sizer.dart';

import '../../../../core/widgets/custom_header.dart';
import '../../../../core/widgets/rebi_button.dart';
import '../../../../core/widgets/profile_list_tile_widget.dart';
import '../widgets/horse_card-widget.dart';
import 'equine_info_horses_screen.dart';

class HorseProfileScreen extends StatefulWidget {
  final UserHorseList response;

  const HorseProfileScreen({super.key, required this.response});

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
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => EditHorseScreen(
                          selectedColor: widget.response.horseColor,
                          selectedGender: widget.response.horseGender,
                          selectedBreed: widget.response.breed,
                          selectedBloodLine: widget.response.bloodline,
                          selectedYear: widget.response.horseAge,
                          horseId: widget.response.horseId,
                          birthOfDate: widget.response.horseDOB,
                          horseName: widget.response.horseName,
                          placeOfBirth: widget.response.horseCOB,
                          image: widget.response.horseImage??'',
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
                  age: widget.response.horseAge.toString(),
                  gender: widget.response.horseGender!,
                  breed: widget.response.breed!,
                  placeOfBirth: widget.response.horseCOB,
                  horseName: widget.response.horseName!,
                  discipline:
                      widget.response.disciplineDetails!.disciplineTitle!,
                  horsePic: widget.response.horseImage??'',
                  isVerified: widget.response.horseIsVerified!,
                  horseStable: widget.response.stableDetails!.stableName!,
                  horseStatus: widget.response.horseCondition!,
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
                          builder: (context) => EquineInfoHorsesScreen(
                                stableId:
                                    widget.response.stableDetails!.stableId,
                                stableName:
                                    widget.response.stableDetails!.stableName,
                                horseCondition: widget.response.horseCondition,
                                disciplineId: widget
                                    .response.disciplineDetails!.disciplineId,
                                disciplineTitle: widget.response
                                    .disciplineDetails!.disciplineTitle,
                                horseId: widget.response.horseId,
                              )));
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
                          builder: (context) => HorseDocumentScreen(
                                horseId: widget.response.horseId.toString(),
                                horseList: widget.response,
                              )));
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
                            builder: (context) => HorseVerificationScreen(
                                  horseId: widget.response.horseId!,
                                )));
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
