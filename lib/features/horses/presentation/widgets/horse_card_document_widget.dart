import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:proequine/core/constants/colors/app_colors.dart';
import 'package:proequine/core/constants/images/app_images.dart';

class HorseCardDocumentWidget extends StatelessWidget {
  String horseName;
  String age;
  String gender;
  String breed;
  String placeOfBirth;
  String horseStatus;
  String horseStable;
  String discipline;
  bool isVerified = false;

  HorseCardDocumentWidget(
      {super.key,
      required this.discipline,
      required this.gender,
      required this.age,
      required this.breed,
      required this.horseName,
      required this.horseStable,
      required this.horseStatus,
      this.isVerified = false,
      required this.placeOfBirth});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ShapeDecoration(
        color: AppColors.white,
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 0.8, color: Color(0xFFDFD9C9)),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Column(
        children: [
          Column(
            children: [
              const SizedBox(
                height: 7,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Row(
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
                    const SizedBox(
                      width: 10,
                    ),
                    isVerified
                        ? SvgPicture.asset(
                            AppIcons.verifiedHorse,
                            height: 12,
                          )
                        : SvgPicture.asset(
                            height: 12,
                            AppIcons.unverifiedHorse,
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
                      '$age yrs, $breed',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Color(0xFF6B7280),
                        fontSize: 12,
                        fontFamily: 'notosan',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    // HorseCardStatusWidget(
                    //   title: horseStatus,
                    //   type: 'status',
                    // ),
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
                        fontSize: 12,
                        fontFamily: 'notosan',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    InkWell(
                        onTap: () {},
                        child: const Text(
                          'View details',
                          style: TextStyle(
                            color: Color(0xFFC48636),
                            fontSize: 12,
                            fontFamily: 'notosan',
                            fontWeight: FontWeight.w700,
                            height: 0.10,
                          ),
                        ))
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
