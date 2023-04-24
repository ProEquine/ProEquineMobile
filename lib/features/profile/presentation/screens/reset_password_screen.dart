import 'dart:async';

import 'package:flutter/material.dart';
import 'package:proequine/core/utils/extensions.dart';
import 'package:proequine/core/utils/rebi_message.dart';
import 'package:proequine/core/widgets/confirm_screen.dart';
import 'package:proequine/core/widgets/registration_header.dart';
import 'package:proequine/features/user/presentation/screens/verification_screen.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/constants/colors/app_colors.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/constants/thems/app_styles.dart';
import '../../../../core/utils/validator.dart';
import '../../../../core/widgets/custom_logo_widget.dart';
import '../../../../core/widgets/rebi_button.dart';
import '../../../../core/widgets/rebi_input.dart';

class ResetPasswordScreen extends StatelessWidget {


   ResetPasswordScreen({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _oldPassword = TextEditingController();
  final TextEditingController _newPassword = TextEditingController();
  final TextEditingController _confirmNewPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const RegistrationHeader(),
                const Center(child: CustomLogoWidget(),),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: kPadding),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Reset password",
                            style: AppStyles.registrationTitle),
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      Text(
                        "Create a new password for your account",
                        style: AppStyles.descriptions,
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: RebiInput(
                          labelText: 'Old password'.tra,
                          controller: _oldPassword,
                          keyboardType: TextInputType.visiblePassword,
                          textInputAction: TextInputAction.done,
                          autoValidateMode:
                          AutovalidateMode.onUserInteraction,
                          isOptional: false,
                          color: AppColors.formsLabel,
                          readOnly: false,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 13),
                          obscureText: true,
                          validator: (value) {
                            return Validator.passwordValidator(
                                _oldPassword.text);
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: RebiInput(
                          labelText: 'New password'.tra,
                          controller: _newPassword,
                          keyboardType: TextInputType.visiblePassword,
                          textInputAction: TextInputAction.done,
                          autoValidateMode:
                          AutovalidateMode.onUserInteraction,
                          isOptional: false,
                          color: AppColors.formsLabel,
                          readOnly: false,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 13),
                          obscureText: true,
                          validator: (value) {
                            return Validator.passwordValidator(
                                _newPassword.text);
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: RebiInput(
                          labelText: 'Confirm new password'.tra,
                          controller: _confirmNewPassword,
                          keyboardType: TextInputType.visiblePassword,
                          textInputAction: TextInputAction.done,
                          autoValidateMode:
                          AutovalidateMode.onUserInteraction,
                          isOptional: false,
                          color: AppColors.formsLabel,
                          readOnly: false,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 13),
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
                      RebiButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                           RebiMessage.success(msg: "Password updated successfully".tra);
                           Timer(const Duration(seconds: 2), (){
                             Navigator.pop(context);
                           });
                          } else {}
                        },
                        backgroundColor: AppColors.white,
                        child: Text("Send"),
                      ),
                      const SizedBox(height: 30,),
                      RebiButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        backgroundColor: AppColors.backgroundColor,
                        isBackButton: true,
                        child: Text("Back to login"),
                      ),
                      const SizedBox(height: 30,),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
