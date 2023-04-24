import 'package:flutter/material.dart';
import 'package:proequine/core/utils/extensions.dart';
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

class ForgotPasswordScreen extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();

  ForgotPasswordScreen({super.key});

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
                const Center(child:CustomLogoWidget()),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: kPadding),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Forgot password",
                            style: AppStyles.registrationTitle),
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      Text(
                        "Enter your email to send otp please",
                        style: AppStyles.descriptions,
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: RebiInput(
                          labelText: 'Email'.tra,
                          controller: _email,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.done,
                          autoValidateMode: AutovalidateMode.onUserInteraction,
                          isOptional: false,
                          color: AppColors.formsLabel,
                          readOnly: false,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 13),
                          obscureText: false,
                          validator: (value) {
                            return Validator.emailValidator(_email.text);
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      RebiButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => VerificationScreen(
                                          email: _email.text,
                                        )));
                          } else {}
                        },
                        backgroundColor: AppColors.white,
                        child: Text("Send"),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      RebiButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        backgroundColor: AppColors.backgroundColor,
                        isBackButton: true,
                        child: Text("Back to login"),
                      ),
                      const SizedBox(
                        height: 30,
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
  }
}
