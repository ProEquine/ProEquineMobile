import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proequine/core/utils/extensions.dart';
import 'package:proequine/core/utils/rebi_message.dart';
import 'package:proequine/core/utils/sharedpreferences/SharedPreferencesHelper.dart';
import 'package:proequine/core/widgets/loading_widget.dart';
import 'package:proequine/features/profile/data/change_password_request_model.dart';
import 'package:proequine/features/profile/domain/profile_cubit.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/constants/colors/app_colors.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/utils/validator.dart';
import '../../../../core/widgets/custom_header.dart';
import '../../../../core/widgets/header_text.dart';
import '../../../../core/widgets/rebi_button.dart';
import '../../../../core/widgets/rebi_input.dart';
import '../../../../core/widgets/success_state_widget.dart';

class ChangePasswordScreen extends StatelessWidget {
  ChangePasswordScreen({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _oldPassword = TextEditingController();
  final TextEditingController _newPassword = TextEditingController();
  final TextEditingController _confirmNewPassword = TextEditingController();
  ProfileCubit cubit = ProfileCubit();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(20.0.h),
        child: CustomHeader(
          title: "Reset password",
          isThereBackButton: true,
        ),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20,),

              Padding(
                padding: const EdgeInsets.only(
                    left: kPadding,right: kPadding,bottom: 10),
                child: RebiInput(
                  labelText: 'Old password'.tra,
                  controller: _oldPassword,
                  keyboardType: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.done,
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                  isOptional: false,
                  color: AppColors.formsLabel,
                  readOnly: false,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
                  obscureText: true,
                  validator: (value) {
                    return Validator.passwordValidator(_oldPassword.text);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 10, horizontal: kPadding),
                child: RebiInput(
                  labelText: 'New password'.tra,
                  controller: _newPassword,
                  keyboardType: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.done,
                  isOptional: false,
                  color: AppColors.formsLabel,
                  readOnly: false,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
                  obscureText: true,
                  validator: (value) {
                    return Validator.passwordValidator(_newPassword.text);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 10, horizontal: kPadding),
                child: RebiInput(
                  labelText: 'Confirm new password'.tra,
                  controller: _confirmNewPassword,
                  keyboardType: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.done,
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                  isOptional: false,
                  color: AppColors.formsLabel,
                  readOnly: false,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
                  obscureText: true,
                  validator: (value) {
                    if (value != null && value.isEmpty) {
                      return "Please confirm your password".tra;
                    } else if (value != _newPassword.text) {
                      return "password does not match".tra;
                    } else {
                      return null;
                    }
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Spacer(),
              BlocConsumer<ProfileCubit, ProfileState>(
                bloc: cubit,
                listener: (context, state) {
                  if (state is ChangePasswordSuccessful) {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SuccessStateScreen(
                                  title: "Password Updated Successfully",
                              isThereButton: false,
                              isItVerifyPhone: false,

                                )));
                  } else if (state is ChangePasswordError) {
                    RebiMessage.error(msg: state.message!,context: context);
                  }
                },
                builder: (context, state) {
                  if (state is ChangePasswordLoading) {
                    return LoadingCircularWidget();
                  }
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: kPadding),
                    child: RebiButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          FocusManager.instance.primaryFocus?.unfocus();
                          onPressChange();
                        } else {}
                      },
                      backgroundColor: AppColors.white,
                      child: const Text("Update"),
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
  onPressChange(){
    return cubit.changePassword(ChangePasswordRequestModel(
      phoneNumber: AppSharedPreferences.userPhoneNumber,
      oldPassword: _oldPassword.text,
      password: _newPassword.text,
      confirmPassword: _confirmNewPassword.text,
    ));
  }
}
