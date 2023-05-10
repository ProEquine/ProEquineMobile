import 'dart:async';

import 'package:flutter/material.dart';
import 'package:proequine/core/utils/extensions.dart';
import 'package:proequine/core/utils/rebi_message.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/constants/colors/app_colors.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/constants/thems/app_styles.dart';
import '../../../../core/utils/validator.dart';
import '../../../../core/widgets/custom_header.dart';
import '../../../../core/widgets/custom_logo_widget.dart';
import '../../../../core/widgets/headerText.dart';
import '../../../../core/widgets/rebi_button.dart';
import '../../../../core/widgets/rebi_input.dart';
import '../../../../core/widgets/success_state_widget.dart';
import '../../../user/presentation/widgets/register_header.dart';

class ChangePasswordScreen extends StatelessWidget {
  ChangePasswordScreen({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _oldPassword = TextEditingController();
  final TextEditingController _newPassword = TextEditingController();
  final TextEditingController _confirmNewPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(20.0.h),
        child: CustomHeader(
          title: "",
          isThereBackButton: true,
        ),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HeaderText("Reset Password", "", false),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10,horizontal: kPadding),
                child: RebiInput(
                  labelText: 'Old password'.tra,
                  controller: _oldPassword,
                  keyboardType: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.done,
                  autoValidateMode: AutovalidateMode.onUserInteraction,
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
                padding: const EdgeInsets.symmetric(vertical: 10,horizontal: kPadding),
                child: RebiInput(
                  labelText: 'New password'.tra,
                  controller: _newPassword,
                  keyboardType: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.done,
                  autoValidateMode: AutovalidateMode.onUserInteraction,
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
                padding: const EdgeInsets.symmetric(vertical: 10,horizontal: kPadding),
                child: RebiInput(
                  labelText: 'Confirm new password'.tra,
                  controller: _confirmNewPassword,
                  keyboardType: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.done,
                  autoValidateMode: AutovalidateMode.onUserInteraction,
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
              const Spacer(),
              RebiButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                SuccessStateScreen(title: "Password Updated Successfully",)));
                  } else {}
                },
                backgroundColor: AppColors.white,
                child: const Text("Update"),
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
}
