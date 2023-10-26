import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proequine/core/utils/extensions.dart';
import 'package:proequine/core/widgets/rebi_button.dart';
import 'package:proequine/features/equine_info/data/add_new_role_request_model.dart';
import 'package:proequine/features/equine_info/domain/equine_info_cubit.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/constants/colors/app_colors.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/constants/routes/routes.dart';
import '../../../../core/constants/thems/app_styles.dart';
import '../../../../core/global_functions/global_statics_drop_down.dart';
import '../../../../core/utils/Printer.dart';
import '../../../../core/utils/rebi_message.dart';
import '../../../../core/widgets/custom_header.dart';
import '../../../../core/widgets/drop_down_menu_widget.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../../../core/widgets/rebi_input.dart';
import '../../../manage_account/data/basic_account_management_route.dart';

class AddNewRoleScreen extends StatefulWidget {
  const AddNewRoleScreen({Key? key}) : super(key: key);

  @override
  State<AddNewRoleScreen> createState() => _AddNewRoleScreenState();
}

class _AddNewRoleScreenState extends State<AddNewRoleScreen> {
  EquineInfoCubit cubit = EquineInfoCubit();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController reason = TextEditingController();
  AddRoleRequestModel model = AddRoleRequestModel();

  String? selectedRole;
  String inputString = 'true'; // Replace with your input string

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(20.h),
        child: CustomHeader(
            title: "Role",
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
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text("Add Role",
                                    style: AppStyles.mainTitle),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                    "in order to add a new role - you need to submit this form and wait for the request approval",
                                    style: AppStyles.descriptions),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              const Align(
                                alignment: Alignment.centerLeft,
                                child: Text("Role",
                                    style: AppStyles.profileBlackTitles),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 7),
                                child: DropDownWidget(
                                  items: role,
                                  selected: selectedRole,
                                  onChanged: (disc) {
                                    setState(() {
                                      selectedRole = disc;
                                      Print('selected role $selectedRole');
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
                                  hintText: 'Reason'.tra,
                                  controller: reason,
                                  maxLines: 5,
                                  keyboardType: TextInputType.name,
                                  textInputAction: TextInputAction.done,
                                  isOptional: false,
                                  color: AppColors.formsLabel,
                                  readOnly: false,
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 13),
                                  obscureText: false,
                                  validator: (value) {},
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Spacer(),
                        Padding(
                          padding:
                              const EdgeInsets.symmetric(horizontal: kPadding),
                          child: BlocConsumer<EquineInfoCubit, EquineInfoState>(
                            bloc: cubit,
                            listener: (context, state) {
                              if (state is AddSecondaryRoleSuccessful) {
                                Navigator.pushReplacementNamed(
                                    context, successScreen,
                                    arguments: BasicAccountManagementRoute(
                                        type: 'manageAccount',
                                        title:
                                            "New Role Request has sent Successfully"));
                              } else if (state is AddSecondaryRoleError) {
                                RebiMessage.error(
                                    msg: state.message!, context: context);
                              }
                            },
                            builder: (context, state) {
                              if (state is AddSecondaryRoleLoading) {
                                return const LoadingCircularWidget();
                              }
                              return RebiButton(
                                onPressed: () {
                                  if(_formKey.currentState!.validate()){
                                    _onPressSubmit();
                                  }else{

                                  }

                                },
                                child: Text(
                                  "Submit",
                                  style: AppStyles.buttonTitle,
                                ),
                              );
                            },
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

  _onPressSubmit() {
    cubit.addRole(AddRoleRequestModel(role: selectedRole, reason: reason.text));
  }
}
