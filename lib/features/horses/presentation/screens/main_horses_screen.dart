import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proequine/core/widgets/custom_error_widget.dart';
import 'package:proequine/features/horses/domain/horse_cubit.dart';
import 'package:proequine/features/horses/presentation/screens/add_horse_screen.dart';
import 'package:proequine/features/horses/presentation/screens/horse_profile_screen.dart';
import 'package:proequine/features/horses/presentation/widgets/empty_horses_widget.dart';
import 'package:proequine/features/horses/presentation/widgets/horse_card-widget.dart';
import 'package:proequine/features/horses/presentation/widgets/main_horses_loading_widget.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/constants/colors/app_colors.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/constants/routes/routes.dart';
import '../../../../core/utils/sharedpreferences/SharedPreferencesHelper.dart';
import '../../../../core/widgets/verify_dialog.dart';
import '../../../manage_account/data/verify_email_route.dart';

class MainHorsesScreen extends StatefulWidget {
  const MainHorsesScreen({Key? key}) : super(key: key);

  @override
  State<MainHorsesScreen> createState() => _MainHorsesScreenState();
}

class _MainHorsesScreenState extends State<MainHorsesScreen> {
  ScrollController scrollController = ScrollController();
  bool isScrolled = false;

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
    checkVerificationStatus().then((verified) {
      if (!verified) {
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
    scrollController.addListener(() {
      if (scrollController.offset > 30) {
        if (!isScrolled) {
          isScrolled = true;
        }
      } else {
        if (isScrolled) {
          isScrolled = false;
        }
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  HorseCubit cubit = HorseCubit();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
            child:MediaQuery(
      data: const MediaQueryData(
          viewInsets: EdgeInsets.only(top: 100, bottom: 0)),
      child: CupertinoPageScaffold(
        child: NestedScrollView(
          controller: scrollController,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
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
                            builder: (context) => const AddHorseScreen()));
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
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
                ),
              ),
            ];
          },
          body: BlocProvider(
            create: (context) => cubit..getAllHorses(),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: BlocBuilder<HorseCubit, HorseState>(
                  // bloc: cubit,
                  builder: (context, state) {
                    if (state is GetUserHorsesSuccessfully) {
                      if (state
                          .getAllHorsesResponseModel.userHorseList!.isEmpty) {
                        return Container(
                            height: 100.0.h,
                            width: 200,
                            child: const EmptyHorsesWidget());
                      } else {
                        return Column(
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
                                                    HorseProfileScreen(
                                                      response: state
                                                          .getAllHorsesResponseModel
                                                          .userHorseList![index],
                                                    )));
                                      },
                                      child: HorseCardWidget(
                                        age: state.getAllHorsesResponseModel
                                            .userHorseList![index].horseAge.toString()??"NA",
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
                                                .horseImage ??
                                            '',
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
                                                .horseCondition ??
                                            '',
                                      ),
                                    ),
                                  );
                                }),
                            const SizedBox(
                              height: 80,
                            ),
                          ],
                        );
                      }
                    }
                    if (state is GetUserHorsesError) {
                      return CustomErrorWidget(onRetry: () {
                        cubit.getAllHorses();
                      });
                    } else if (state is GetUserHorsesLoading) {
                      return const MainHorsesLoadingWidget();
                    }
                    return Container();
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    ));
  }
}
