import 'package:flutter/material.dart';
import 'package:proequine/core/utils/rebi_message.dart';
import 'package:proequine/core/utils/sharedpreferences/SharedPreferencesHelper.dart';
import 'package:proequine/core/widgets/divider.dart';
import 'package:proequine/core/widgets/rebi_button.dart';
import 'package:proequine/features/home/presentation/screens/local_summary.dart';

import 'package:sizer/sizer.dart';

import '../../../../core/constants/colors/app_colors.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/global_functions/validate_horse_functions.dart';
import '../../../../core/utils/Printer.dart';
import '../../../../core/widgets/custom_header.dart';
import '../../data/trip_service_data_model.dart';
import '../widgets/add_new_horse_content.dart';

class ChoseTripHorseScreen extends StatefulWidget {
  TripServiceDataModel tripServiceDataModel;

  ChoseTripHorseScreen({Key? key, required this.tripServiceDataModel})
      : super(key: key);

  @override
  State<ChoseTripHorseScreen> createState() => _ChoseTripHorseScreenState();
}

class _ChoseTripHorseScreenState extends State<ChoseTripHorseScreen> {
  List<TextEditingController> newHorsesControllers = [];

  List<String> genders = [];
  List<String> selectedHorse = [];

  List<TextEditingController> horsesControllers = [];
  Map<String, String> horses = {};

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  List<bool> isChooseNewHorse = [];
  int? horsesNumbers;

  @override
  void initState() {
    var controllersTexts = List<String>.generate(
        int.parse(widget.tripServiceDataModel.horsesNumber),
        (counter) => "Select a horse");
    for (var str in controllersTexts) {
      var textEditingController = TextEditingController(text: str);
      horsesControllers.add(textEditingController);
    }

    var gendersAA = List<String>.generate(
        int.parse(widget.tripServiceDataModel.horsesNumber),
        (counter) => "Select a Gender");
    for (var str in gendersAA) {
      String st = '';
      genders.add(st);
    }

    var horsesSS = List<String>.generate(
        int.parse(widget.tripServiceDataModel.horsesNumber),
        (counter) => "Select a horse");
    for (var str in horsesSS) {
      String st = '';
      selectedHorse.add(st);
    }

    var newHorsesText = List<String>.generate(
        int.parse(widget.tripServiceDataModel.horsesNumber), (counter) => "");
    for (var str in newHorsesText) {
      var textEditingController = TextEditingController(text: str);
      newHorsesControllers.add(textEditingController);
    }

    var chosenList = List<bool>.generate(
        int.parse(widget.tripServiceDataModel.horsesNumber),
        (counter) => false);
    for (var str in chosenList) {
      var boolStatus = false;
      isChooseNewHorse.add(boolStatus);
    }
    AppSharedPreferences.firstTime = true;
    Print('AppSharedPreferences.getEnvType${AppSharedPreferences.getEnvType}');

    super.initState();

    horsesNumbers = int.parse(widget.tripServiceDataModel.horsesNumber);
    isChooseNewHorse.length =
        int.parse(widget.tripServiceDataModel.horsesNumber);
    Print(" Horses Numbers is $horsesNumbers");
  }

  List<String> horsesNames = [
    'Koki',
    'Metha',
    'Saqr',
    'Al-Naama',
    'Al-Moshahar',
    'Add New Horse'
  ];


  bool isGenderSelectedEqualHorses(
      List<TextEditingController> selectedHorse, List<String> genders) {
    int addNewHorseCount = 0;
    int genderSelectedCount = 0;

    for (int i = 0; i < selectedHorse.length; i++) {
      if (selectedHorse[i].text == 'Add New Horse') {
        addNewHorseCount++;
      } else if (genders[i].isNotEmpty && genders[i] != '') {
        genderSelectedCount++;
      }
    }

    return addNewHorseCount == genderSelectedCount;
  }

  @override
  void dispose() {
    for (var controller in horsesControllers) {
      controller.dispose();
    }
    for (var newController in newHorsesControllers) {
      newController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(20.0.h),
        child: CustomHeader(
          title: widget.tripServiceDataModel.trip == 'hospital'
              ? "Hospital Transport"
              : "Local Transport",
          isThereBackButton: true,
        ),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SizedBox(
            height: horsesNumbers! > 2 ? 120.h : 85.0.h,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  ListView.separated(
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      separatorBuilder: (context, index) {
                        return const CustomDivider();
                      },
                      itemCount: horsesNumbers!,
                      itemBuilder: (context, index) {
                        return AddHorseContentWidget(
                          selectedGender: genders[index],
                          selectedGenders: genders,
                          currentIndex: index,
                          selectedHorses: selectedHorse,
                          selectedHorse: selectedHorse[index],
                          horsesController: horsesControllers[index],
                          newHorsesController: newHorsesControllers[index],
                          isChoseNewHorse: isChooseNewHorse[index],
                        );
                      }),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: kPadding,
                    ),
                    child: RebiButton(
                      backgroundColor: AppColors.yellow,
                      onPressed: () {
                        Print("Selected horses $selectedHorse");
                        Print("Selected genders $genders");
                        Print("Selected isChosen $isChooseNewHorse");

                        final theMap =
                            Map.fromIterables(selectedHorse, genders);
                        Print(theMap);
                        Print(isListNotEmpty(genders));

                        if (_formKey.currentState!.validate() &&
                            validateHorses(horsesControllers) && isListNotEmpty(genders)) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LocalSummary(
                                      tripServiceDataModel:
                                          widget.tripServiceDataModel)));
                        } else {
                          RebiMessage.error(
                              msg: "Please select a horse for each field.",
                              context: context);
                        }
                      },
                      child: const Text("Next"),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

// _buildChooseStableConsumer() {
//   return BlocConsumer<UserCubit, UserState>(
//       bloc: cubit,
//       builder: (context, state) {
//         if (state is SelectInterestsLoading) {
//           return const LoadingCircularWidget();
//         } else if (state is SelectInterestsError) {
//           RebiMessage.error(msg: state.message!, context: context);
//         }
//         {
//           return RebiButton(
//             backgroundColor: (selectedMainStable != null &&
//                         selectedMainStable != 'Add Your Stable') ||
//                     (selectedEmirate != null &&
//                         _mainStableName.text.isNotEmpty &&
//                         _mainStableLocation.text.isNotEmpty)
//                 ? AppColors.yellow
//                 : AppColors.formsLabel,
//             onPressed: () {
//               if ((selectedMainStable != null &&
//                       selectedMainStable != 'Add Your Stable') ||
//                   (selectedEmirate != null &&
//                       _mainStableName.text.isNotEmpty &&
//                       _mainStableLocation.text.isNotEmpty)) {
//                 _onPressConfirm();
//               } else {
//                 RebiMessage.error(
//                     msg: 'Please select your main stable', context: context);
//               }
//             },
//             child: const Text("Next"),
//           );
//         }
//       },
//       listener: (context, state) {
//         // if (state is SelectInterestsSuccessful) {
//         //   AppSharedPreferences.typeSelected = true;
//         //   Navigator.push(
//         //       context,
//         //       MaterialPageRoute(
//         //           builder: (context) => const BottomNavigation()));
//         // } else if (state is SelectInterestsError) {
//         //   RebiMessage.error(msg: state.message!, context: context);
//         // }
//       });
// }
//
// _onPressConfirm() {
//   Print("selected location ${_mainStableLocation.text}");
//   Print("selected main stable ${_mainStableName.text}");
//   Print("selected emirate $selectedEmirate");
//   Print("selected main $selectedMainStable");
//   Navigator.push(context,
//       MaterialPageRoute(builder: (context) => const BottomNavigation()));
//   // return cubit
//   //   ..interests(InterestsRequestModel(
//   //     phoneNumber: AppSharedPreferences.userPhoneNumber,
//   //     interest: 'interest',
//   //     type: 'userType',
//   //   ));
// }
}
