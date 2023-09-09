import 'package:flutter/material.dart';
import 'package:proequine/core/utils/extensions.dart';
import 'package:proequine/core/utils/sharedpreferences/SharedPreferencesHelper.dart';
import 'package:proequine/core/widgets/divider.dart';
import 'package:proequine/core/widgets/rebi_button.dart';
import 'package:proequine/features/home/data/join_show_request_model.dart';
import 'package:proequine/features/home/presentation/screens/local_summary.dart';
import 'package:proequine/features/home/presentation/screens/show_summary_screen.dart';

import 'package:sizer/sizer.dart';
import '../../../../core/constants/colors/app_colors.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/constants/thems/app_styles.dart';
import '../../../../core/utils/Printer.dart';
import '../../../../core/utils/validator.dart';
import '../../../../core/widgets/custom_header.dart';
import '../../../../core/widgets/rebi_input.dart';
import '../../../user/presentation/widgets/selectable_type_container.dart';
import '../widgets/add_new_horse_content.dart';
import '../widgets/horses_bottom_sheet.dart';

class ChoseShowsHorseScreen extends StatefulWidget {
  JoinShowTransportRequestModel? joinShowTransportRequestModel;

  ChoseShowsHorseScreen({Key? key, this.joinShowTransportRequestModel})
      : super(key: key);

  @override
  State<ChoseShowsHorseScreen> createState() => _ChoseShowsHorseScreenState();
}

class _ChoseShowsHorseScreenState extends State<ChoseShowsHorseScreen> {
  List<TextEditingController> horsesControllers = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController()
  ];

  List<TextEditingController> classesControllers = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController()
  ];
  List<TextEditingController> newHorsesControllers = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController()
  ];
  List<String> selectedHorse = ['', '', '', ''];
  List<String> selectedClass = ['', '', '', ''];
  List<String> selectedGender = ['', '', '', ''];
  final GlobalKey<FormState> checkBoxKey = GlobalKey<FormState>();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  List<bool> isChooseNewHorse = [false, false, false, false];
  int? horsesNumbers;

  @override
  void initState() {
    AppSharedPreferences.firstTime = true;
    Print('AppSharedPreferences.getEnvType${AppSharedPreferences.getEnvType}');
    super.initState();

    horsesNumbers =
        int.parse(widget.joinShowTransportRequestModel!.horsesNumber);
    isChooseNewHorse.length =
        int.parse(widget.joinShowTransportRequestModel!.horsesNumber);
    Print(" Horses Numbers is $horsesNumbers");
  }

  List<String> horsesNames = [
    'Koki',
    'Metha',
    'Saqr',
    'Al-Naama',
    'Al-Moshahar',
    // 'Add New Horse'
  ];
  List<String> classes = [
    'A',
    'B',
    'C',
    'D',
  ];
  final List<bool> _isGenderSelected = [false, false, false];

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

  bool choseMedia = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(20.0.h),
        child: CustomHeader(
          title: "Show Transport",
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      ListView.separated(
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
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 7, right: 4, left: 4),
                                          child: RebiInput(
                                            hintText: 'Select Your Horse',
                                            controller:
                                                horsesControllers[currentIndex],
                                            keyboardType: TextInputType.name,
                                            textInputAction:
                                                TextInputAction.done,
                                            autoValidateMode: AutovalidateMode
                                                .onUserInteraction,
                                            isOptional: false,
                                            color: AppColors.formsLabel,
                                            onTap: () {
                                              showHorsesBottomSheet(
                                                context: context,
                                                title: "Select Your horse",
                                                content: ListView.separated(
                                                  shrinkWrap: true,
                                                  itemCount: horsesNames.length,
                                                  separatorBuilder:
                                                      (context, index) {
                                                    return const CustomDivider();
                                                  },
                                                  itemBuilder:
                                                      (context, index) {
                                                    return GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          selectedHorse[
                                                                  currentIndex] =
                                                              horsesNames[
                                                                  index];
                                                          horsesControllers[
                                                                      currentIndex]
                                                                  .text =
                                                              selectedHorse[
                                                                  currentIndex];

                                                          Navigator.pop(
                                                              context);
                                                          Print(
                                                              "Selected horse ${selectedHorse[currentIndex]}");
                                                          Print(
                                                              "Horse Name ${horsesNames[index]}");
                                                        });
                                                        if (selectedHorse[
                                                                currentIndex] ==
                                                            'Add New Horse') {
                                                          setState(() {
                                                            isChooseNewHorse[
                                                                    currentIndex] =
                                                                true;
                                                            Print("true");
                                                          });
                                                        } else {
                                                          setState(() {
                                                            isChooseNewHorse[
                                                                    currentIndex] =
                                                                false;
                                                            Print("false");
                                                            // selectedHorse[index] =
                                                            //     horsesControllers[currentIndex]
                                                            //         .text;
                                                          });
                                                        }
                                                      },
                                                      child: ListTile(
                                                        title: Text(
                                                            horsesNames[index]),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              );
                                            },
                                            readOnly: true,
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                    horizontal: 20,
                                                    vertical: 13),
                                            obscureText: false,
                                            validator: (value) {
                                              return Validator
                                                  .requiredValidator(
                                                      horsesControllers[
                                                              currentIndex]
                                                          .text);
                                            },
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 7, right: 4, left: 4),
                                          child: RebiInput(
                                            hintText: 'Class',
                                            controller: classesControllers[
                                                currentIndex],
                                            keyboardType: TextInputType.name,
                                            textInputAction:
                                                TextInputAction.done,
                                            autoValidateMode: AutovalidateMode
                                                .onUserInteraction,
                                            isOptional: false,
                                            color: AppColors.formsLabel,
                                            onTap: () {
                                              showHorsesBottomSheet(
                                                context: context,
                                                title: "Select The Class",
                                                content: ListView.separated(
                                                  shrinkWrap: true,
                                                  itemCount: classes.length,
                                                  separatorBuilder:
                                                      (context, index) {
                                                    return const CustomDivider();
                                                  },
                                                  itemBuilder:
                                                      (context, index) {
                                                    return GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          selectedClass[
                                                                  currentIndex] =
                                                              classes[index];
                                                          classesControllers[
                                                                      currentIndex]
                                                                  .text =
                                                              classes[index];

                                                          Navigator.pop(
                                                              context);
                                                          Print(
                                                              "Selected horse ${selectedHorse[currentIndex]}");
                                                          Print(
                                                              "Horse Name ${horsesNames[index]}");
                                                        });
                                                      },
                                                      child: ListTile(
                                                        title: Text(
                                                            classes[index]),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              );
                                            },
                                            readOnly: true,
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                    horizontal: 20,
                                                    vertical: 13),
                                            obscureText: false,
                                            validator: (value) {
                                              return Validator
                                                  .requiredValidator(
                                                      classesControllers[
                                                              currentIndex]
                                                          .text);
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Visibility(
                                    visible: isChooseNewHorse[currentIndex],
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 7),
                                      child: RebiInput(
                                        hintText: 'Horse Name'.tra,
                                        controller:
                                            newHorsesControllers[currentIndex],
                                        scrollPadding:
                                            const EdgeInsets.only(bottom: 100),
                                        keyboardType: TextInputType.name,
                                        textInputAction: TextInputAction.done,
                                        onFieldSubmitted: (submited) {
                                          selectedHorse[currentIndex] =
                                              'New horse : ${newHorsesControllers[currentIndex].text}';
                                        },
                                        autoValidateMode:
                                            AutovalidateMode.onUserInteraction,
                                        isOptional: false,
                                        onChanged: (value) {
                                          setState(() {});
                                        },
                                        color: AppColors.formsLabel,
                                        readOnly: false,
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 20, vertical: 13),
                                        obscureText: false,
                                        validator: (value) {
                                          return Validator.requiredValidator(
                                              newHorsesControllers[currentIndex]
                                                  .text);
                                        },
                                      ),
                                    ),
                                  ),
                                  Visibility(
                                    visible: isChooseNewHorse[currentIndex],
                                    child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 7.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const SizedBox(
                                              height: 7,
                                            ),
                                            const Text(
                                              "Gender",
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                color: AppColors
                                                    .formsHintFontLight,
                                                fontSize: 14,
                                                fontFamily: 'notosan',
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                SelectableTypeContainer(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 35,
                                                      vertical: 10),
                                                  label: 'Mare',
                                                  index: 0,
                                                  isSelected:
                                                      _isGenderSelected[0],
                                                  onSelected: (bool value) {
                                                    _handleSelected(0, value,
                                                        _isGenderSelected);
                                                    selectedGender[
                                                        currentIndex] = 'Mare';

                                                    selectedHorse[
                                                            currentIndex] =
                                                        'New horse : ${newHorsesControllers[currentIndex]}';
                                                  },
                                                ),
                                                SelectableTypeContainer(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 35,
                                                      vertical: 10),
                                                  label: 'Gelding',
                                                  index: 1,
                                                  isSelected:
                                                      _isGenderSelected[1],
                                                  onSelected: (bool value) {
                                                    _handleSelected(1, value,
                                                        _isGenderSelected);
                                                    selectedGender[
                                                            currentIndex] =
                                                        'Gelding';
                                                    selectedHorse[
                                                            currentIndex] =
                                                        'New horse : ${newHorsesControllers[currentIndex]}';
                                                  },
                                                ),
                                                SelectableTypeContainer(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 35,
                                                      vertical: 10),
                                                  label: 'Stallion',
                                                  index: 2,
                                                  isSelected:
                                                      _isGenderSelected[2],
                                                  onSelected: (bool value) {
                                                    _handleSelected(2, value,
                                                        _isGenderSelected);
                                                    selectedGender[
                                                            currentIndex] =
                                                        'Stallion';
                                                    selectedHorse[
                                                            currentIndex] =
                                                        'New horse : ${newHorsesControllers[currentIndex]}';
                                                  },
                                                ),
                                              ],
                                            ),
                                          ],
                                        )),
                                  ),
                                ],
                              ),
                            );
                          }),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                  const CustomDivider(),
                  const SizedBox(
                    height: 10,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: kPadding),
                    child: Text(
                      "Include media service",
                      style: AppStyles.profileTitles,
                      textAlign: TextAlign.start,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 0, vertical: 10),
                    child: Row(
                      children: [
                        Theme(
                          data: Theme.of(context).copyWith(
                            unselectedWidgetColor: AppColors.formsBackground,
                            primaryColor: AppColors.formsBackground,
                          ),
                          child: Transform.scale(
                            scale: 1,
                            child: Checkbox(
                              key: checkBoxKey,
                              checkColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              activeColor: AppColors.yellow,
                              value: choseMedia,
                              onChanged: (bool? val) {
                                setState(() {
                                  choseMedia = val!;
                                });
                              },
                            ),
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            text: 'Photos and videos'.tra,
                            style: TextStyle(
                              fontSize: 12.5.sp,
                              color: AppColors.blackLight,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: kPadding,
                    ),
                    child: RebiButton(
                      backgroundColor: AppColors.yellow,
                      onPressed: () {
                        Print("Selected horses $selectedHorse");
                        Print("Selected genders $selectedGender");
                        Print("Selected isChosen $isChooseNewHorse");
                        final theMap =
                            Map.fromIterables(selectedHorse, selectedGender);
                        Print(theMap);

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ShowSummaryScreen(
                                    joinShowTransportRequestModel:
                                        widget.joinShowTransportRequestModel)));
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
  void _handleSelected(int index, bool value, var _isSelected) {
    setState(() {
      for (int i = 0; i < _isSelected.length; i++) {
        _isSelected[i] = false;
      }
      _isSelected[index] = value;
    });
  }
}
