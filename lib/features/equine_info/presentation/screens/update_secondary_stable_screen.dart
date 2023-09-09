import 'package:flutter/material.dart';
import 'package:proequine/core/utils/extensions.dart';
import 'package:proequine/core/utils/rebi_message.dart';
import 'package:proequine/core/utils/sharedpreferences/SharedPreferencesHelper.dart';
import 'package:proequine/core/widgets/rebi_button.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/constants/colors/app_colors.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/constants/thems/app_styles.dart';
import '../../../../core/global_functions/global_statics_drop_down.dart';
import '../../../../core/utils/Printer.dart';
import '../../../../core/utils/validator.dart';
import '../../../../core/widgets/custom_header.dart';
import '../../../../core/widgets/rebi_input.dart';
import '../../../../core/widgets/drop_down_menu_widget.dart';

class UpdateSecondaryStableScreen extends StatefulWidget {
   String secondaryStable;
   UpdateSecondaryStableScreen({Key? key,required this.secondaryStable}) : super(key: key);

  @override
  State<UpdateSecondaryStableScreen> createState() =>
      _UpdateSecondaryStableScreenState();
}

class _UpdateSecondaryStableScreenState
    extends State<UpdateSecondaryStableScreen> {
  // final UserCubit cubit = UserCubit();

  List<DropdownMenuItem<String>> secondaryStable = [
    const DropdownMenuItem(
      value: "Sharjah Stable",
      child: Text("Sharjah"),
    ),
    const DropdownMenuItem(
      value: "Malath",
      child: Text("Malath"),
    ),
    const DropdownMenuItem(
      value: "Malalth Paradise",
      child: Text("Malalth Paradise"),
    ),
    const DropdownMenuItem(
      value: "Malath3",
      child: Text("Malath3"),
    ),
    const DropdownMenuItem(
      value: "Add Your Stable",
      child: Text("Add Your Stable"),
    ),
  ];

  String? selectedSecondaryStable;
  String? selectedEmirate;
  late final TextEditingController _secondaryStableName;
  late final TextEditingController _secondaryStableLocation;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool isChooseToAddStable = false;

  @override
  void initState() {
    AppSharedPreferences.firstTime = true;
    Print('AppSharedPreferences.getEnvType${AppSharedPreferences.getEnvType}');
    _secondaryStableName = TextEditingController();
    _secondaryStableLocation = TextEditingController();
    selectedSecondaryStable=widget.secondaryStable;
    super.initState();
  }

  @override
  void dispose() {
    _secondaryStableLocation.dispose();
    _secondaryStableName.dispose();
    // cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(20.h),
        child: CustomHeader(
          title: "Secondary Stable",
          isThereBackButton: true,
          isThereChangeWithNavigate: false,
          isThereThirdOption: true,
          thirdOptionTitle: 'Remove',
          isThereThirdOptionDelete: true,
          onPressThirdOption: () {
            // Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //         builder: (context) => const AddSecondaryStableScreen()));
          },
        ),
      ),
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraint) {
            return Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraint.maxHeight),
                  child: IntrinsicHeight(
                    child: Column(
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.symmetric(horizontal: kPadding),
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 15,
                              ),
                              const Align(
                                alignment: Alignment.centerLeft,
                                child: Text("Stable",
                                    style: AppStyles.profileBlackTitles),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 7),
                                child: DropDownWidget(
                                  items: secondaryStable,
                                  selected: selectedSecondaryStable,
                                  onChanged: (secondaryStable) {
                                    setState(() {
                                      selectedSecondaryStable = secondaryStable;
                                      if (selectedSecondaryStable ==
                                          'Add Your Stable') {
                                        isChooseToAddStable = true;
                                      } else {
                                        isChooseToAddStable = false;
                                      }
                                      Print(
                                          'selected secondary stable $selectedSecondaryStable');
                                    });
                                  },
                                  validator: (value) {
                                    // return Validator.requiredValidator(selectedNumber);
                                  },
                                  hint: 'Choose Secondary Stable',
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Visibility(
                                visible: isChooseToAddStable,
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text("Add Your Stable ",
                                      style: AppStyles.mainTitle2),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Visibility(
                                visible: isChooseToAddStable,
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                      "in order to update your secondary stable - you need to submit this form and wait for the request approval",
                                      style: AppStyles.descriptions),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Visibility(
                                visible: isChooseToAddStable,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 7),
                                  child: RebiInput(
                                    hintText: 'Stable Name'.tra,
                                    controller: _secondaryStableName,
                                    scrollPadding:
                                        const EdgeInsets.only(bottom: 100),
                                    keyboardType: TextInputType.name,
                                    textInputAction: TextInputAction.done,
                                    autoValidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    isOptional: false,
                                    onChanged: (value) {
                                      setState(() {});
                                    },
                                    color: AppColors.formsLabel,
                                    readOnly: false,
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 13),
                                    obscureText: false,
                                    validator: (value) {
                                      return Validator.requiredValidator(
                                          _secondaryStableName.text);
                                    },
                                  ),
                                ),
                              ),
                              Visibility(
                                visible: isChooseToAddStable,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 7),
                                  child: RebiInput(
                                    hintText: 'Location'.tra,
                                    controller: _secondaryStableLocation,
                                    onChanged: (value) {
                                      setState(() {});
                                    },
                                    scrollPadding:
                                        const EdgeInsets.only(bottom: 100),
                                    keyboardType: TextInputType.url,
                                    textInputAction: TextInputAction.done,
                                    autoValidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    isOptional: false,
                                    color: AppColors.formsLabel,
                                    readOnly: false,
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 13),
                                    obscureText: false,
                                    validator: (value) {
                                      return Validator.requiredValidator(
                                          _secondaryStableLocation.text);
                                    },
                                  ),
                                ),
                              ),
                              Visibility(
                                visible: isChooseToAddStable,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 7),
                                  child: DropDownWidget(
                                    items: emirate,
                                    selected: selectedEmirate,
                                    onChanged: (selectedEmi) {
                                      setState(() {
                                        selectedEmirate = selectedEmi;
                                        Print(
                                            'selected Emirate $selectedEmirate');
                                      });
                                    },
                                    validator: (value) {
                                      // return Validator.requiredValidator(selectedNumber);
                                    },
                                    hint: 'Emirate',
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                          ),
                          child: RebiButton(
                            backgroundColor: (selectedSecondaryStable != null &&
                                        selectedSecondaryStable !=
                                            'Add Your Stable') ||
                                    (selectedEmirate != null &&
                                        _secondaryStableName.text.isNotEmpty &&
                                        _secondaryStableLocation
                                            .text.isNotEmpty)
                                ? AppColors.yellow
                                : AppColors.formsLabel,
                            onPressed: () {
                              if ((selectedSecondaryStable != null &&
                                      selectedSecondaryStable !=
                                          'Add Your Stable') ||
                                  (selectedEmirate != null &&
                                      _secondaryStableLocation
                                          .text.isNotEmpty &&
                                      _secondaryStableName.text.isNotEmpty)) {
                              } else {
                                RebiMessage.error(
                                    msg: 'Please select your secondary stable',
                                    context: context);
                              }
                            },
                            child: const Text("Save"),
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
            );
          },
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
//                 selectedMainStable != 'Add Your Stable') ||
//                 (selectedEmirate != null &&
//                     _mainStableName.text.isNotEmpty &&
//                     _mainStableLocation.text.isNotEmpty)
//                 ? AppColors.yellow
//                 : AppColors.formsLabel,
//             onPressed: () {
//               if ((selectedMainStable != null&&
//                   selectedMainStable != 'Add Your Stable') ||
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
//   Navigator.push(
//       context,
//       MaterialPageRoute(
//           builder: (context) => const BottomNavigation()));
//   // return cubit
//   //   ..interests(InterestsRequestModel(
//   //     phoneNumber: AppSharedPreferences.userPhoneNumber,
//   //     interest: 'interest',
//   //     type: 'userType',
//   //   ));
// }
}
