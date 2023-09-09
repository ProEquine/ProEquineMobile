import 'package:flutter/material.dart';
import 'package:proequine/core/utils/extensions.dart';
import 'package:proequine/core/widgets/rebi_button.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/constants/colors/app_colors.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/constants/thems/app_styles.dart';
import '../../../../core/utils/Printer.dart';
import '../../../../core/utils/validator.dart';
import '../../../../core/widgets/custom_header.dart';
import '../../../../core/widgets/drop_down_menu_widget.dart';
import '../../../../core/widgets/rebi_input.dart';

class AddSecondaryDisciplineScreen extends StatefulWidget {
  const AddSecondaryDisciplineScreen({Key? key}) : super(key: key);

  @override
  State<AddSecondaryDisciplineScreen> createState() =>
      _AddSecondaryDisciplineScreenState();
}

class _AddSecondaryDisciplineScreenState
    extends State<AddSecondaryDisciplineScreen> {
  late final TextEditingController _feId;
  late final TextEditingController _nationalId;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  List<DropdownMenuItem<String>> discipline = [
    const DropdownMenuItem(
      value: "Show jumping",
      child: Text("Show jumping"),
    ),
    const DropdownMenuItem(
      value: "Dressage",
      child: Text("Dressage"),
    ),
    const DropdownMenuItem(
      value: "Racing",
      child: Text("Racing"),
    ),
    const DropdownMenuItem(
      value: "Endurance",
      child: Text("Endurance"),
    ),
  ];
  String? selectedDiscipline;

  @override
  void initState() {
    _feId = TextEditingController();
    _nationalId = TextEditingController();
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
            title: "Secondary discipline",
            isThereBackButton: true,
            isThereChangeWithNavigate: false,
            isThereThirdOption: false),
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
                                          'selected gender $selectedDiscipline');
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
}
