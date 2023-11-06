import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proequine/core/constants/images/app_images.dart';
import 'package:proequine/core/widgets/custom_error_widget.dart';
import 'package:proequine/features/horses/domain/horse_cubit.dart';
import 'package:proequine/features/horses/presentation/screens/add_horse_screen.dart';
import 'package:proequine/features/horses/presentation/screens/horse_profile_screen.dart';
import 'package:proequine/features/horses/presentation/widgets/empty_horses_widget.dart';
import 'package:proequine/features/horses/presentation/widgets/horse_card-widget.dart';

import '../../../../core/constants/colors/app_colors.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/constants/routes/routes.dart';
import '../../../../core/utils/sharedpreferences/SharedPreferencesHelper.dart';
import '../../../../core/widgets/verify_dialog.dart';
import '../../../manage_account/data/verify_email_route.dart';
import '../widgets/cards_loading_widget.dart';

class MainHorsesScreen extends StatefulWidget {
  const MainHorsesScreen({Key? key}) : super(key: key);

  @override
  State<MainHorsesScreen> createState() => _MainHorsesScreenState();
}

class _MainHorsesScreenState extends State<MainHorsesScreen> {
  bool isLoading = true;
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
  late Timer timer;

  Future<bool> checkVerificationStatus() async {
    if (AppSharedPreferences.getEmailVerified!) {
      return true;
    } else {
      await Future.delayed(
          const Duration(milliseconds: 50)); // Simulating an asynchronous call
      return false;
    }
  }

  @override
  void initState() {
    super.initState();
    cubit.getAllHorses();
    checkVerificationStatus().then((verified) {
      if (!verified) {
        // If the account is not verified, show a dialog after a delay.
        Future.delayed(const Duration(milliseconds: 50), () {
          showUnverifiedAccountDialog(
            context: context,
            isThereNavigationBar: true,
            onPressVerify: () {
              Navigator.pushNamed(context, verifyEmail,
                      arguments: VerifyEmailRoute(
                          type: 'Horses',
                          email: AppSharedPreferences.userEmailAddress))
                  .then((value) {});
            },
          );
        });
      }
    });
    // Set a timer for 3 seconds
    timer = Timer(const Duration(seconds: 5), () {
      setState(() {
        isLoading = false;
      });
    });

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
    timer.cancel();
    super.dispose();
  }

  HorseCubit cubit = HorseCubit();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child:
          // isLoading
          //     ? CardLoadingWidget(
          //         title: "Horses",
          //         isSmallCard: false,
          //       )
          //     :
          BlocBuilder<HorseCubit, HorseState>(
        bloc: cubit,
        builder: (context, state) {
          if (state is GetUserHorsesSuccessfully) {
            if (state.getAllHorsesResponseModel.userHorseList!.isEmpty) {
              return  MediaQuery(
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
                                alwaysShowMiddle: false,
                                padding: const EdgeInsetsDirectional.only(bottom: 1),
                                backgroundColor: AppColors.backgroundColorLight,
                                largeTitle: const Text(
                                  'Horses',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 30,
                                      fontFamily: 'notosan'),
                                ),
                                middle: const Text(
                                  'Horses',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700, fontSize: 18),
                                ),
                              ),
                            ];
                          },
                          body:const EmptyHorsesWidget())));
            } else {
              return MediaQuery(
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
                          alwaysShowMiddle: false,
                          padding: const EdgeInsetsDirectional.only(bottom: 1),
                          backgroundColor: AppColors.backgroundColorLight,
                          largeTitle: const Text(
                            'Horses',
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 30,
                                fontFamily: 'notosan'),
                          ),
                          middle: const Text(
                            'Horses',
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 18),
                          ),
                        ),
                      ];
                    },
                    body: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Column(
                          children: [
                            ListView.builder(
                                shrinkWrap: true,
                                primary: false,
                                itemCount: state.getAllHorsesResponseModel
                                    .userHorseList!.length,
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
                                        age: state.getAllHorsesResponseModel
                                            .userHorseList![index].horseAge
                                            .toString(),
                                        gender: state.getAllHorsesResponseModel
                                            .userHorseList![index].horseGender!,
                                        breed: state.getAllHorsesResponseModel
                                            .userHorseList![index].breed!,
                                        // placeOfBirth: state.getAllHorsesResponseModel.userHorseList![index].,
                                        horseName: state
                                            .getAllHorsesResponseModel
                                            .userHorseList![index]
                                            .horseName!,
                                        discipline: state
                                            .getAllHorsesResponseModel
                                            .userHorseList![index]
                                            .disciplineDetails!
                                            .disciplineTitle!,
                                        horsePic: state
                                            .getAllHorsesResponseModel
                                            .userHorseList![index]
                                            .horseImage!,
                                        isVerified: state
                                            .getAllHorsesResponseModel
                                            .userHorseList![index]
                                            .horseIsVerified!,
                                        horseStable: state
                                            .getAllHorsesResponseModel
                                            .userHorseList![index]
                                            .stableDetails!
                                            .stableName!,
                                        horseStatus: state
                                            .getAllHorsesResponseModel
                                            .userHorseList![index]
                                            .horseCondition!,
                                      ),
                                    ),
                                  );
                                }),
                            const SizedBox(
                              height: 80,
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
          if (state is GetUserHorsesError) {
            return CustomErrorWidget(onRetry: () {
              cubit.getAllHorses();
            });
          } else if (state is GetUserHorsesLoading) {
            return CardLoadingWidget(
              title: "Horses",
              isSmallCard: false,
            );
          }
          return Container();
        },
      ),
    );
  }
}
