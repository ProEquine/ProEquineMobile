import 'package:flutter/material.dart';
import 'package:proequine/core/constants/constants.dart';
import 'package:proequine/core/utils/extensions.dart';
import 'package:proequine/core/widgets/rebi_button.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/constants/colors/app_colors.dart';
import '../../../../core/constants/thems/app_styles.dart';
import '../../../../core/utils/Printer.dart';
import '../../../../core/utils/validator.dart';
import '../../../../core/widgets/custom_header.dart';
import '../../../../core/widgets/rebi_input.dart';

class AccountInfoScreen extends StatelessWidget {
  final TextEditingController _currentPassword = TextEditingController();
  final TextEditingController _newPassword = TextEditingController();
  final TextEditingController _confirmNewPassword = TextEditingController();
  final TextEditingController name = TextEditingController(text: "Bahaa Soubh");
  final TextEditingController email =
      TextEditingController(text: "bahaa.s@input.ae");
  final TextEditingController phone =
      TextEditingController(text: "+97132492490");
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(20.0.h),
        child: CustomHeader(
          title: "Account information",
          isThereBackButton: true,
        ),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: kPadding, vertical: kPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: RebiInput(
                  labelText: 'Full Name'.tra,
                  controller: name,
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.done,
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                  isOptional: false,
                  color: AppColors.formsLabel,
                  readOnly: true,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
                  obscureText: false,
                  validator: (value) {
                    // return Validator.requiredValidator(name.text);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: RebiInput(
                  labelText: 'Email'.tra,
                  controller: email,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.done,
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                  isOptional: false,
                  color: AppColors.formsLabel,
                  readOnly: true,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
                  obscureText: false,
                  validator: (value) {
                    // return Validator.emailValidator(email.text);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: RebiInput(
                  labelText: 'Phone'.tra,
                  controller: phone,
                  keyboardType: TextInputType.phone,
                  textInputAction: TextInputAction.done,
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                  isOptional: false,
                  color: AppColors.formsLabel,
                  readOnly: true,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
                  obscureText: false,
                  validator: (value) {
                    // return Validator.phoneValidator(phone.text);
                  },
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Update password",
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 20.0,
                  fontFamily: 'notosan',
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: RebiInput(
                  labelText: 'Current password'.tra,
                  controller: _currentPassword,
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
                    return Validator.passwordValidator(_currentPassword.text);
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
                  autoValidateMode: AutovalidateMode.onUserInteraction,
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
                padding: const EdgeInsets.symmetric(vertical: 10),
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
              Spacer(),
              RebiButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Print("Updated");
                    } else {}
                  },
                  child: Text("Update Password")),
              const SizedBox(
                height: 10,
              )
            ],
          ),
        ),
      ),
    );
  }
}
