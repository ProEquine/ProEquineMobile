import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:proequine/core/constants/colors/app_colors.dart';

import '../../../../core/constants/images/app_images.dart';
import 'horse_card_status_widget.dart';

class HorseCardWidget extends StatelessWidget {
  String horsePic;
  String horseName;
  String age;
  String gender;
  String breed;
  String placeOfBirth;
  String horseStatus;
  String horseStable;
  String discipline;
  bool isVerified = false;

  HorseCardWidget(
      {super.key,
      required this.discipline,
      required this.gender,
      required this.age,
      required this.breed,
      required this.horseName,
      required this.horsePic,
      required this.horseStable,
      required this.horseStatus,
      this.isVerified = false,
      required this.placeOfBirth});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 0.8, color: Color(0xFFDFD9C9)),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Column(
        children: [
          Image.asset(horsePic),
          Column(
            children: [
              const SizedBox(
                height: 7,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      horseName,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: AppColors.blackLight,
                        fontSize: 14,
                        fontFamily: 'notosan',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    isVerified
                        ? SvgPicture.asset(
                      AppIcons.verifiedHorse,
                    )
                        : HorseCardStatusWidget(
                            title: "Not Verified",
                            type: 'verify',
                          ),
                  ],
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '$age yrs $gender $breed $placeOfBirth',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Color(0xFF6B7280),
                        fontSize: 10,
                        fontFamily: 'notosan',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    HorseCardStatusWidget(
                      title: horseStatus,
                      type: 'status',
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '$horseStable Stable',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Color(0xFF6B7280),
                        fontSize: 10,
                        fontFamily: 'notosan',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    HorseCardStatusWidget(
                      title: discipline,
                      type: 'discipline',
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 14,
              ),
            ],
          ),
        ],
      ),
    );
  }
}