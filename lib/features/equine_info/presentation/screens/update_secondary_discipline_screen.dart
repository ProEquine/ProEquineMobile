import 'package:flutter/material.dart';
import 'package:proequine/core/utils/extensions.dart';
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

class UpdateSecondaryDisciplineScreen extends StatefulWidget {
  final String secondaryDiscipline;
  final String? secondaryUserFeId;
  final String? secondaryUserNationalId;

  const UpdateSecondaryDisciplineScreen(
      {Key? key,
      required this.secondaryDiscipline,
      this.secondaryUserFeId,
      this.secondaryUserNationalId})
      : super(key: key);

  @override
  State<UpdateSecondaryDisciplineScreen> createState() =>
      _UpdateSecondaryDisciplineScreenState();
}

class _UpdateSecondaryDisciplineScreenState
    extends State<UpdateSecondaryDisciplineScreen> {
  late final TextEditingController _feId;
  late final TextEditingController _nationalId;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? selectedDiscipline;

  @override
  void initState() {
    _feId = TextEditingController();
    _nationalId = TextEditingController();
    selectedDiscipline = widget.secondaryDiscipline;
    if (widget.secondaryUserFeId != null &&
        widget.secondaryUserNationalId != null) {
      _feId.text = widget.secondaryUserFeId!;
      _nationalId.text = widget.secondaryUserNationalId!;
    }

    super.initState();
  }

  @override
  void dispose() {
    _feId.dispose();
    _nationalId.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(20.h),
        child: CustomHeader(
          title: "Secondary Discipline",
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
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text("Update Discipline",
                                    style: AppStyles.mainTitle),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                    "in order to update your main discipline - you need to submit this form and wait for the request approval",
                                    style: AppStyles.descriptions),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              const Align(
                                alignment: Alignment.centerLeft,
                                child: Text("Discipline",
                                    style: AppStyles.profileBlackTitles),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 7),
                                child: DropDownWidget(
                                  items: discipline,
                                  selected: selectedDiscipline,
                                  onChanged: (disc) {
                                    setState(() {
                                      selectedDiscipline = disc;
                                      Print(
                                          'selected disc $selectedDiscipline');
                                    });
                                  },
                                  validator: (value) {
                                    // return Validator.requiredValidator(selectedNumber);
                                  },
                                  hint: 'Select',
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 7),
                                child: RebiInput(
                                  hintText: 'National ID'.tra,
                                  controller: _nationalId,
                                  keyboardType: TextInputType.name,
                                  textInputAction: TextInputAction.done,
                                  isOptional: false,
                                  color: AppColors.formsLabel,
                                  readOnly: false,
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 13),
                                  obscureText: false,
                                  validator: (value) {
                                    return Validator.requiredValidator(
                                        _nationalId.text);
                                  },
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 7),
                                child: RebiInput(
                                  hintText: 'FEI ID'.tra,
                                  controller: _feId,
                                  keyboardType: TextInputType.name,
                                  textInputAction: TextInputAction.done,
                                  isOptional: false,
                                  color: AppColors.formsLabel,
                                  readOnly: false,
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 13),
                                  obscureText: false,
                                  validator: (value) {
                                    return Validator.requiredValidator(
                                        _feId.text);
                                  },
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        ),
                        const Spacer(),
                        Padding(
                          padding:
                              const EdgeInsets.symmetric(horizontal: kPadding),
                          child: RebiButton(
                            onPressed: () {},
                            child: Text(
                              "Submit",
                              style: AppStyles.buttonTitle,
                            ),
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
