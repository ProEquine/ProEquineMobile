import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proequine/core/utils/extensions.dart';
import 'package:proequine/core/utils/sharedpreferences/SharedPreferencesHelper.dart';
import 'package:proequine/core/widgets/loading_widget.dart';
import 'package:proequine/features/user/data/send_verification_request_model.dart';
import 'package:proequine/features/user/domain/user_cubit.dart';
import 'package:proequine/features/user/presentation/screens/interests_screen.dart';
import 'package:proequine/features/user/presentation/screens/verification_screen.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/constants/colors/app_colors.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/constants/thems/app_styles.dart';
import '../../../../core/utils/Printer.dart';
import '../../../../core/utils/rebi_message.dart';
import '../../../../core/utils/validator.dart';
import '../../../../core/widgets/custom_header.dart';
import '../../../../core/widgets/custom_logo_widget.dart';
import '../../../../core/widgets/rebi_button.dart';
import '../../../../core/widgets/rebi_input.dart';


class UpdateUserNameScreen extends StatefulWidget {
  UpdateUserNameScreen({
    super.key,
  });

  @override
  State<UpdateUserNameScreen> createState() => _UpdateUserNameScreenState();
}

class _UpdateUserNameScreenState extends State<UpdateUserNameScreen> {
  late final TextEditingController _userName;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final UserCubit cubit = UserCubit();

  @override
  void initState() {
    _userName = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _userName.dispose();
    cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(20.h),
        child: CustomHeader(
          title: "Username",
          isThereBackButton: true,
          isThereChangeWithNavigate: false,
          isThereThirdOption: true,
          thirdOptionTitle: 'check',
          onPressThirdOption: (){},
        ),
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraint) {
            return Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.disabled,
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
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text("Update username",
                                    style: AppStyles.mainTitle),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                    "remember keep it simple and unique ",
                                    style: AppStyles.descriptions),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding:
                                const EdgeInsets.symmetric(vertical: 10),
                                child: Row(
                                  children: [
                                    const Expanded(
                                        flex: 1,
                                        child: Text(
                                          "@",
                                          style: TextStyle(
                                              color: AppColors.blackLight,
                                              fontSize: 26,
                                              fontWeight: FontWeight.w700),
                                        )),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      flex: 15,
                                      child: RebiInput(
                                        hintText: 'Username'.tra,
                                        controller: _userName,
                                        keyboardType: TextInputType.name,
                                        textInputAction: TextInputAction.done,
                                        autoValidateMode:
                                        AutovalidateMode.onUserInteraction,
                                        isOptional: false,
                                        color: AppColors.formsLabel,
                                        readOnly: false,
                                        contentPadding:
                                        const EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 13),
                                        obscureText: false,
                                        validator: (value) {
                                          return Validator.requiredValidator(
                                              _userName.text);
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Padding(
                                  padding:
                                  const EdgeInsets.symmetric(vertical: 20),
                                  child: BlocConsumer<UserCubit, UserState>(
                                    bloc: cubit,
                                    builder: (context, state) {
                                      if (state is SendVerificationLoading) {
                                        return const LoadingCircularWidget();
                                      }
                                      return RebiButton(
                                          onPressed: () {
                                            if (_formKey.currentState!
                                                .validate()) {
                                              FocusManager.instance.primaryFocus
                                                  ?.unfocus();
                                              // Navigator.push(
                                              //     context,
                                              //     MaterialPageRoute(
                                              //         builder: (context) =>
                                              //         const EquineInfoScreen()));
                                            } else {}
                                          },
                                          child: const Text("Update"));
                                    },
                                    listener: (context, state) {},
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
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
