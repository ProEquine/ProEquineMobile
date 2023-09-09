import 'package:flutter/material.dart';

import 'package:proequine/core/constants/constants.dart';
import 'package:proequine/core/constants/thems/app_styles.dart';
import 'package:proequine/features/equine_info/presentation/screens/add_secondary_discipline_screen.dart';
import 'package:proequine/features/equine_info/presentation/screens/update_discipline_screen.dart';
import 'package:proequine/features/equine_info/presentation/screens/update_secondary_discipline_screen.dart';
import 'package:proequine/features/manage_account/domain/manage_account_cubit.dart';

import 'package:proequine/features/manage_account/presentation/screens/update_username_screen.dart';

import 'package:sizer/sizer.dart';

import '../../../../core/constants/colors/app_colors.dart';
import '../../../../core/constants/routes/routes.dart';
import '../../../../core/global_functions/global_statics_drop_down.dart';
import '../../../../core/utils/validator.dart';
import '../../../../core/widgets/custom_header.dart';
import '../../../../core/widgets/drop_down_menu_widget.dart';
import '../../../../core/widgets/profile_two_lines_list_tile.dart';
import '../../../../core/widgets/rebi_button.dart';

class EquineInfoHorsesScreen extends StatefulWidget {
  const EquineInfoHorsesScreen({super.key});

  @override
  State<EquineInfoHorsesScreen> createState() => _EquineInfoHorsesScreenState();
}

class _EquineInfoHorsesScreenState extends State<EquineInfoHorsesScreen> {
  String? selectedDiscipline;
  String? selectedStable;
  String? selectedCondition;


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
      body: Padding(
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
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 7),
              child: DropDownWidget(
                items: stables,
                selected: selectedStable,
                onChanged: (stable) {
                  setState(() {
                    selectedStable = stable;
                  });
                },
                validator: (value) {
                  return Validator.requiredValidator(selectedStable);
                },
                hint: 'Stable',
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
            Spacer(),
            Align(
              alignment: Alignment.bottomCenter,
              child: RebiButton(
                onPressed: () {

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
    );
  }
}
