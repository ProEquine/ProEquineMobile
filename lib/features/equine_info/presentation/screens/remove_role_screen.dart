import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proequine/core/utils/extensions.dart';
import 'package:proequine/core/widgets/rebi_button.dart';
import 'package:proequine/features/equine_info/domain/equine_info_cubit.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/constants/colors/app_colors.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/constants/routes/routes.dart';
import '../../../../core/constants/thems/app_styles.dart';
import '../../../../core/utils/rebi_message.dart';
import '../../../../core/widgets/custom_header.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../../../core/widgets/rebi_input.dart';
import '../../../manage_account/data/basic_account_management_route.dart';
import '../../data/add_new_role_request_model.dart';

class RemoveRoleScreen extends StatefulWidget {
  final String name;
  final int roleId;

  const RemoveRoleScreen({Key? key, required this.name, required this.roleId})
      : super(key: key);

  @override
  State<RemoveRoleScreen> createState() => _RemoveRoleScreenState();
}

class _RemoveRoleScreenState extends State<RemoveRoleScreen> {
  EquineInfoCubit cubit = EquineInfoCubit();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController reason = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(20.h),
        child: CustomHeader(
            title: widget.name,
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
                                child: Text("Remove Role",
                                    style: AppStyles.mainTitle),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                    'Submit this form to remove your role'.tra,
                                    style: AppStyles.descriptions),
                              ),
                              const SizedBox(
                                height: 5,
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
                              if (state is DeleteRoleSuccessful) {
                                Navigator.pushReplacementNamed(
                                    context, successScreen,
                                    arguments: BasicAccountManagementRoute(
                                        type: 'manageAccount',
                                        title:
                                            "Remove Role Request has sent Successfully"));
                              } else if (state is DeleteRoleError) {
                                RebiMessage.error(
                                    msg: state.message!, context: context);
                              }
                            },
                            builder: (context, state) {
                              if (state is DeleteRoleLoading) {
                                return const LoadingCircularWidget();
                              }
                              return RebiButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    _onPressSubmit();
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
    cubit.deleteRole(
        AddRoleRequestModel(role: widget.name, reason: reason.text));
  }
}
