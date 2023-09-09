import 'package:flutter/material.dart';
import 'package:proequine/core/widgets/rebi_button.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/constants/thems/app_styles.dart';
import '../../../../core/global_functions/global_statics_drop_down.dart';
import '../../../../core/utils/Printer.dart';
import '../../../../core/widgets/custom_header.dart';
import '../../../../core/widgets/drop_down_menu_widget.dart';

class UpdateMainRole extends StatefulWidget {
  const UpdateMainRole({Key? key}) : super(key: key);

  @override
  State<UpdateMainRole> createState() => _UpdateMainRoleState();
}

class _UpdateMainRoleState extends State<UpdateMainRole> {



  String? selectedRole;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(20.h),
        child: CustomHeader(
            title: "Main Role",
            isThereBackButton: true,
            isThereChangeWithNavigate: false,
            isThereThirdOption: false),
      ),
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraint) {
            return SingleChildScrollView(
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
                            const SizedBox(height: 15,),
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Text("Main Role",
                                  style: AppStyles.profileBlackTitles),
                            ),
                            const SizedBox(height: 5,),
                            Padding(
                              padding:
                              const EdgeInsets.symmetric(vertical: 7),
                              child: DropDownWidget(
                                items: role,
                                selected: selectedRole,
                                onChanged: (role) {
                                  setState(() {
                                    selectedRole = role;
                                    Print(
                                        'selected Role $selectedRole');
                                  });
                                },
                                validator: (value) {
                                  // return Validator.requiredValidator(selectedNumber);
                                },
                                hint: 'Select',
                              ),
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
                      const SizedBox(height: 20,),
                    ],
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
