import 'package:flutter/material.dart';
import 'package:proequine/core/utils/sharedpreferences/SharedPreferencesHelper.dart';
import 'package:proequine/core/widgets/divider.dart';
import 'package:proequine/core/widgets/rebi_button.dart';
import 'package:proequine/features/home/data/shipping_service_model.dart';
import 'package:proequine/features/home/domain/cubits/local_horse_cubit.dart';

import 'package:sizer/sizer.dart';
import '../../../../core/constants/colors/app_colors.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/utils/Printer.dart';
import '../../../../core/utils/validator.dart';
import '../../../../core/widgets/custom_header.dart';
import '../../../../core/widgets/rebi_input.dart';
import '../../domain/repo/local_storage_repository.dart';
import '../widgets/horses_bottom_sheet.dart';
import 'confirm_horses_screen.dart';

class ChoseShippingHorseScreen extends StatefulWidget {
  ShippingServiceModel? serviceModel;

  ChoseShippingHorseScreen({Key? key, this.serviceModel}) : super(key: key);

  @override
  State<ChoseShippingHorseScreen> createState() =>
      _ChoseShippingHorseScreenState();
}

class _ChoseShippingHorseScreenState extends State<ChoseShippingHorseScreen> {
  List<TextEditingController> newHorsesControllers = [];

  List<TextEditingController> horsesControllers = [];
  Map<String, String> horses = {};
  LocalHorseCubit localHorseCubit =
      LocalHorseCubit(localStorageRepository: LocalStorageRepository());

  @override
  void initState() {
    super.initState();
    var controllersTexts = List<String>.generate(
        int.parse(widget.serviceModel!.horsesNumber),
        (counter) => "Select a horse");
    for (var str in controllersTexts) {
      var textEditingController = TextEditingController(text: str);
      horsesControllers.add(textEditingController);
    }

    var newHorsesText = List<String>.generate(
        int.parse(widget.serviceModel!.horsesNumber), (counter) => "");
    for (var str in newHorsesText) {
      var textEditingController = TextEditingController(text: str);
      newHorsesControllers.add(textEditingController);
    }
    AppSharedPreferences.firstTime = true;
    Print('AppSharedPreferences.getEnvType${AppSharedPreferences.getEnvType}');
    super.initState();

    horsesNumbers = int.parse(widget.serviceModel!.horsesNumber);
    Print(" Horses Numbers is $horsesNumbers");
  }

  @override
  void dispose() {
    super.dispose();
    // dispose textEditingControllers to prevent memory leaks
    for (TextEditingController textEditingController in horsesControllers) {
      textEditingController.dispose();
    }
    for (TextEditingController textEditingController in newHorsesControllers) {
      textEditingController.dispose();
    }
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  int? horsesNumbers;
  List<String> horsesNames = [
    'Koki',
    'Metha',
    'Saqr',
    'Al-Naama',
    'Al-Moshahar',
    'Add New Horse'
  ];

  @override
  Widget build(BuildContext context) {
    // var uuid = const Uuid();
    // var v1 = uuid.v1(options: {
    //   'node': [0x01, 0x23, 0x45, 0x67, 0x89, 0xab],
    //   'clockSeq': 0x1234,
    //   'mSecs': DateTime.now().millisecondsSinceEpoch,
    //   'nSecs': 5678
    // });
    List<bool> isChoseNewHorse = List<bool>.generate(
        int.parse(widget.serviceModel!.horsesNumber), (counter) => false);
    List<String> selectedHorse = List<String>.generate(
        int.parse(widget.serviceModel!.horsesNumber),
        (counter) => "Controller $counter");
    List<String> selectedGender = List<String>.generate(
        int.parse(widget.serviceModel!.horsesNumber),
        (counter) => "Controller $counter");
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(20.0.h),
        child: CustomHeader(
          title: "Shipping",
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
                  StatefulBuilder(builder: (context, setState) {
                    return ListView.separated(
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        separatorBuilder: (context, index) {
                          return const CustomDivider();
                        },
                        itemCount: horsesNumbers!,
                        itemBuilder: (context, currentIndex) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: kPadding),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 7),
                                  child: RebiInput(
                                    hintText: 'Select Your Horse',
                                    controller: horsesControllers[currentIndex],
                                    keyboardType: TextInputType.name,
                                    textInputAction: TextInputAction.done,
                                    autoValidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    isOptional: false,
                                    color: AppColors.formsLabel,
                                    onTap: () {
                                      showHorsesBottomSheet(
                                        context: context,
                                        title: "Select Your horse",
                                        content: ListView.separated(
                                          shrinkWrap: true,
                                          itemCount: horsesNames.length,
                                          separatorBuilder: (context, index) {
                                            return const CustomDivider();
                                          },
                                          itemBuilder: (context, index) {
                                            return GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  selectedHorse[currentIndex] =
                                                      horsesNames[index];
                                                  horsesControllers[
                                                              currentIndex]
                                                          .text =
                                                      selectedHorse[
                                                          currentIndex];

                                                  Navigator.pop(context);
                                                  Print(
                                                      "Selected horse ${selectedHorse[currentIndex]}");
                                                  Print(
                                                      "Horse Name ${horsesNames[index]}");
                                                });
                                                if (selectedHorse[
                                                        currentIndex] ==
                                                    'Add New Horse') {
                                                  setState(() {
                                                    isChoseNewHorse[
                                                        currentIndex] = true;
                                                    Print("true");
                                                  });
                                                } else {
                                                  setState(() {
                                                    isChoseNewHorse[
                                                        currentIndex] = false;
                                                    Print("false");
                                                    // selectedHorse[index] =
                                                    //     horsesControllers[currentIndex]
                                                    //         .text;
                                                  });
                                                }
                                              },
                                              child: ListTile(
                                                title: Text(horsesNames[index]),
                                              ),
                                            );
                                          },
                                        ),
                                      );
                                    },
                                    readOnly: true,
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 13),
                                    obscureText: false,
                                    validator: (value) {
                                      return Validator.requiredValidator(
                                          horsesControllers[currentIndex].text);
                                    },
                                  ),
                                ),
                              ],
                            ),
                          );
                        });
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
                        Print("Selected isChosen $isChoseNewHorse");
                        final theMap =
                            Map.fromIterables(selectedHorse, selectedGender);
                        Print(theMap);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ConfirmHorsesScreen(
                                      serviceModel: widget.serviceModel,
                                      horsesNames: selectedHorse,
                                      isNewHorses: isChoseNewHorse,
                                    )));
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
