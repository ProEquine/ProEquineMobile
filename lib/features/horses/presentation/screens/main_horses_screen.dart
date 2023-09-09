import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:proequine/core/constants/images/app_images.dart';
import 'package:proequine/features/horses/presentation/screens/add_horse_screen.dart';
import 'package:proequine/features/horses/presentation/screens/horse_profile_screen.dart';
import 'package:proequine/features/horses/presentation/widgets/horse_card-widget.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/constants/colors/app_colors.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/widgets/custom_header.dart';

class MainHorsesScreen extends StatefulWidget {
  const MainHorsesScreen({Key? key}) : super(key: key);

  @override
  State<MainHorsesScreen> createState() => _MainHorsesScreenState();
}

class _MainHorsesScreenState extends State<MainHorsesScreen> {
  List<String> names = [
    "Stormy",
    "Miss White",
    "Cando",
    "Stormy",
    "Miss White",
    "Cando"
  ];
  List<String> ages = [
    "14",
    "11",
    "9",
    "14",
    "11",
    "9",
  ];
  List<String> pics = [
    AppImages.stormy,
    AppImages.missWhite,
    AppImages.cando,
    AppImages.stormy,
    AppImages.missWhite,
    AppImages.cando
  ];
  List<String> status = [
    "Active",
    "Lame",
    "Break",
    "Active",
    "Lame",
    "Break",
  ];
  ScrollController _scrollController = ScrollController();
  bool isScrolled = false;

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.offset > 30) {
        if (!isScrolled) {
          setState(() {
            isScrolled = true;
          });
        }
      } else {
        if (isScrolled) {
          setState(() {
            isScrolled = false;
          });
        }
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MediaQuery(
        data: const MediaQueryData(
            viewInsets: EdgeInsets.only(top: 100, bottom: 0)),
        child: CupertinoPageScaffold(
          child: NestedScrollView(
            controller: _scrollController,
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                CupertinoSliverNavigationBar(
                  automaticallyImplyLeading: false,
                  border: Border(
                      bottom: BorderSide(
                          width: 1.0,
                          color: isScrolled
                              ? AppColors.borderColor
                              : Colors.transparent)),
                  trailing: TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddHorseScreen()));
                    },
                    child: const Text(
                      "Add Horse",
                      style: TextStyle(
                        color: Color(0xFFC48636),
                        fontSize: 14,
                        fontFamily: 'notosans',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  // trailing: GestureDetector(
                  //   onTap: (){
                  //     Navigator.push(
                  //                 context,
                  //                 MaterialPageRoute(
                  //                     builder: (context) => AddHorseScreen()));
                  //   },
                  //   child: Container(
                  //     padding: const EdgeInsets.all(5),
                  //     margin: const EdgeInsets.symmetric(horizontal: kPadding),
                  //     decoration: const BoxDecoration(
                  //       color: AppColors.gold,
                  //       shape: BoxShape.circle,
                  //     ),
                  //     child: const Icon(
                  //       Icons.add,
                  //       color: AppColors.backgroundColorLight,
                  //       size: 18,
                  //     ),
                  //   ),
                  // ),
                  alwaysShowMiddle: false,
                  padding: const EdgeInsetsDirectional.only(bottom: 1),
                  backgroundColor: AppColors.backgroundColorLight,
                  largeTitle: const Text(
                    'Horses',
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 30),
                  ),
                  middle: const Text(
                    'Horses',
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
                  ),
                ),
              ];
            },
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Column(
                  children: [
                    Column(
                      children: [
                        ListView.builder(
                            shrinkWrap: true,
                            primary: false,
                            itemCount: 6,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: kPadding, vertical: 10),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const HorseProfileScreen()));
                                  },
                                  child: HorseCardWidget(
                                    age: ages[index],
                                    gender: 'Mare',
                                    breed: "Selle",
                                    placeOfBirth: "Français",
                                    horseName: names[index],
                                    discipline: "Show jumping",
                                    horsePic: pics[index],
                                    isVerified: false,
                                    horseStable: "Malath",
                                    horseStatus: status[index],
                                  ),
                                ),
                              );
                            }),
                      ],
                    ),
                    const SizedBox(
                      height: 80,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
