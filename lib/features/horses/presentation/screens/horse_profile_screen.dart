import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:proequine/core/constants/constants.dart';
import 'package:proequine/core/constants/thems/app_styles.dart';
import 'package:proequine/core/utils/Printer.dart';
import 'package:proequine/features/horses/data/get_user_horses_response_model.dart';
import 'package:proequine/features/horses/domain/horse_cubit.dart';

import 'package:proequine/features/horses/presentation/screens/edit_horse_screen.dart';
import 'package:proequine/features/horses/presentation/screens/horse_document_screen.dart';
import 'package:proequine/features/horses/presentation/screens/horse_verification_screen.dart';
import 'package:proequine/features/horses/presentation/widgets/horse_card_document_widget.dart';

import 'package:sizer/sizer.dart';

import '../../../../core/utils/secure_storage/secure_storage_helper.dart';
import '../../../../core/widgets/custom_header.dart';
import '../../../../core/widgets/rebi_button.dart';
import '../../../../core/widgets/profile_list_tile_widget.dart';
import '../../../associations/presentation/screens/horse_request_association_screen.dart';
import '../widgets/horse_card-widget.dart';
import 'equine_info_horses_screen.dart';

class HorseProfileScreen extends StatefulWidget {
  final Horse response;

  const HorseProfileScreen({super.key, required this.response});

  @override
  State<HorseProfileScreen> createState() => _HorseProfileScreenState();
}

class _HorseProfileScreenState extends State<HorseProfileScreen> {
  int calculateAge(DateTime dob) {
    DateTime currentDate = DateTime.now();
    int age = currentDate.year - dob.year;
    int month1 = currentDate.month;
    int month2 = dob.month;
    if (month2 > month1) {
      age--;
    } else if (month1 == month2) {
      int day1 = currentDate.day;
      int day2 = dob.day;
      if (day2 > day1) {
        age--;
      }
    }
    return age;
  }

  @override
  Widget build(BuildContext context) {
    // final themeCubit = ThemeCubitProvider.of(context);
    var myCubit = context.watch<HorseCubit>();
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(20.h),
        child: CustomHeader(
          title: "Horse Profile",
          isThereBackButton: true,
          isThereChangeWithNavigate: true,
          isThereThirdOption: false,
          onPressBack: () {
            myCubit.getAllHorses(limit: 100);
            Navigator.pop(context);
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
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EditHorseScreen(
                                  selectedColor: widget.response.color,
                                  disciplineId: widget.response.disciplineId,
                                  stableId: widget.response.stableId,
                                  selectedGender: widget.response.gender,
                                  selectedBreed: widget.response.breed,
                                  selectedBloodLine: widget.response.bloodLine,
                                  //Todo: handling age depending on birth of date
                                  selectedYear: 1,
                                  horseId: widget.response.id,
                                  birthOfDate: widget.response.dateOfBirth,
                                  horseName: widget.response.name,
                                  placeOfBirth: widget.response.placeOfBirth,
                                  image: widget.response.image ?? '',
                                )));
                  },
                  child: HorseCardDocumentWidget(
                    placeOfBirth: widget.response.placeOfBirth!,
                    age: widget.response.age.toString(),
                    gender: widget.response.gender!,
                    breed: widget.response.breed!,
                    horseName: widget.response.name!,
                    discipline: widget.response.discipline!.title!,
                    isVerified:
                        widget.response.status == 'verified' ? true : false,
                    horseStable: widget.response.stable!.name!,
                    horseStatus: widget.response.status!,
                  ),
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
                onTap: () async {
                  String? userId = await SecureStorage().getUserId();
                  Print(widget.response.discipline!.title);
                  if (context.mounted) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EquineInfoHorsesScreen(
                                  horse: widget.response,
                                  userId: int.parse(userId!),
                                  stableId: widget.response.stable!.id,
                                  stableName: widget.response.stable!.name,
                                  horseCondition: widget.response.status,
                                  disciplineId: widget.response.discipline!.id,
                                  disciplineTitle:
                                      widget.response.discipline!.title,
                                  horseId: widget.response.id,
                                )));
                  }
                },
                notificationList: false,
                isThereNewNotification: false,
              ),
              ProfileListTileWidget(
                title: "Horse Association",
                onTap: () async {
                  String? userId = await SecureStorage().getUserId();
                  Print(widget.response.discipline!.title);
                  if (context.mounted) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HorseInvitesAssociations(
                                  horseId: widget.response.id.toString(),
                                  horseList: widget.response,
                                )));
                  }
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
                                horseId: widget.response.id.toString(),
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
                                  horseId: widget.response.id!,
                                )));
                  },
                  child:  Text("Get your horse verified", style: AppStyles.buttonStyle,),
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
