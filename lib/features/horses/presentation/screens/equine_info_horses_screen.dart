import 'package:flutter/material.dart';

import 'package:proequine/core/constants/constants.dart';
import 'package:proequine/core/utils/extensions.dart';
import 'package:proequine/core/utils/rebi_message.dart';
import 'package:proequine/core/widgets/stables_widget.dart';

import 'package:sizer/sizer.dart';

import '../../../../core/constants/colors/app_colors.dart';
import '../../../../core/global_functions/global_statics_drop_down.dart';
import '../../../../core/utils/Printer.dart';
import '../../../../core/utils/validator.dart';
import '../../../../core/widgets/custom_header.dart';
import '../../../../core/widgets/drop_down_menu_widget.dart';
import '../../../../core/widgets/rebi_button.dart';
import '../../../../core/widgets/rebi_input.dart';

class EquineInfoHorsesScreen extends StatefulWidget {
  const EquineInfoHorsesScreen({super.key});

  @override
  State<EquineInfoHorsesScreen> createState() => _EquineInfoHorsesScreenState();
}

class _EquineInfoHorsesScreenState extends State<EquineInfoHorsesScreen> {
  TextEditingController stable = TextEditingController();
  TextEditingController stableName = TextEditingController();
  TextEditingController stableLocation = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? selectedDiscipline;
  String? selectedStable;
  String? selectedCondition;

  String? selectedEmirate;
  bool isChooseToAddStable = false;

  void changeToTrueValue() {
    setState(() {
      isChooseToAddStable = true;
    });
  }

  void changeToFalseValue() {
    setState(() {
      isChooseToAddStable = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    // final themeCubit = ThemeCubitProvider.of(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(20.0.h),
        child: CustomHeader(
          title: "Equine Info",
          isThereBackButton: true,
        ),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(kPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Horse Stable ",
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: AppColors.formsHintFontLight,
                  fontSize: 14,
                  fontFamily: 'notosan',
                  fontWeight: FontWeight.w500,
                ),
              ),
              SelectStableWidget(
                stable: stable,
                showingStablesList: stables,
                changeTrue: changeToTrueValue,
                changeFalse: changeToFalseValue,
              ),
              const SizedBox(
                height: 20,
              ),
              Visibility(
                visible: isChooseToAddStable,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 7),
                  child: RebiInput(
                    hintText: 'Stable Name'.tra,
                    controller: stableName,
                    scrollPadding: const EdgeInsets.only(bottom: 100),
                    keyboardType: TextInputType.name,
                    onChanged: (value) {
                      setState(() {});
                    },
                    textInputAction: TextInputAction.done,
                    autoValidateMode: AutovalidateMode.onUserInteraction,
                    isOptional: false,
                    color: AppColors.formsLabel,
                    readOnly: false,
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 13),
                    obscureText: false,
                    validator: (value) {
                      return Validator.requiredValidator(stableName.text);
                    },
                  ),
                ),
              ),
              Visibility(
                visible: isChooseToAddStable,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 7),
                  child: RebiInput(
                    hintText: 'Location'.tra,
                    controller: stableLocation,
                    scrollPadding: const EdgeInsets.only(bottom: 100),
                    keyboardType: TextInputType.url,
                    textInputAction: TextInputAction.done,
                    onChanged: (value) {
                      setState(() {});
                    },
                    autoValidateMode: AutovalidateMode.onUserInteraction,
                    isOptional: false,
                    color: AppColors.formsLabel,
                    readOnly: false,
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 13),
                    obscureText: false,
                    validator: (value) {
                      return Validator.requiredValidator(stableLocation.text);
                    },
                  ),
                ),
              ),
              Visibility(
                visible: isChooseToAddStable,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 7),
                  child: DropDownWidget(
                    items: emirate,
                    selected: selectedEmirate,
                    onChanged: (selectedEmi) {
                      setState(() {
                        selectedEmirate = selectedEmi;
                        Print('selected Emirate $selectedEmirate');
                      });
                    },
                    validator: (value) {
                      // return Validator.requiredValidator(selectedNumber);
                    },
                    hint: 'Emirate',
                  ),
                ),
              ),
              const Text(
                "Horse condition",
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: AppColors.formsHintFontLight,
                  fontSize: 14,
                  fontFamily: 'notosan',
                  fontWeight: FontWeight.w500,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 7),
                child: DropDownWidget(
                  items: conditions,
                  selected: selectedCondition,
                  onChanged: (condition) {
                    setState(() {
                      selectedCondition = condition;
                    });
                  },
                  validator: (value) {
                    return Validator.requiredValidator(selectedCondition);
                  },
                  hint: 'Condition',
                ),
              ),
              const Text(
                "Horse Discipline ",
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: AppColors.formsHintFontLight,
                  fontSize: 14,
                  fontFamily: 'notosan',
                  fontWeight: FontWeight.w500,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 7),
                child: DropDownWidget(
                  items: discipline,
                  selected: selectedDiscipline,
                  onChanged: (disc) {
                    setState(() {
                      selectedDiscipline = disc;
                    });
                  },
                  validator: (value) {
                    return Validator.requiredValidator(selectedDiscipline);
                  },
                  hint: 'Discipline',
                ),
              ),
              const Spacer(),
              Align(
                alignment: Alignment.bottomCenter,
                child: RebiButton(
                  onPressed: () {
                    Print(selectedStable);
                    Print(selectedEmirate);
                    Print(selectedDiscipline);
                    Print(selectedCondition);
                    Print(selectedStable);
                    if ((stable.text.isNotEmpty &&
                        stable.text != 'Add Your Stable') ||
                        (selectedEmirate != null &&
                                stableName.text.isNotEmpty &&
                                stableLocation.text.isNotEmpty) &&
                            selectedCondition != null &&
                            selectedDiscipline != null) {

                      Navigator.pop(context);
                    } else {
                      RebiMessage.error(
                          msg: "Please fill all of the fields",
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
    );
  }
}
