import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:proequine/core/widgets/registration_header.dart';
import 'package:sizer/sizer.dart';
import 'dart:ui' as ui;

import '../../../../core/constants/colors/app_colors.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/constants/thems/app_styles.dart';
import '../../../../core/constants/thems/pin_put_theme.dart';
import '../../../../core/widgets/custom_logo_widget.dart';
import '../../../../core/widgets/rebi_button.dart';
import '../../../nav_bar/presentation/screens/bottomnavigation.dart';

class VerificationScreen extends StatelessWidget {
  final String? email;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _pinPutController = TextEditingController();
  final FocusNode _pinPutFocusNode = FocusNode();

  VerificationScreen({super.key,this.email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const RegistrationHeader(),
                const Center(child:CustomLogoWidget()),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: kPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Check your Email",
                            style: AppStyles.registrationTitle),

                      SizedBox(
                        height: 1.h,
                      ),
                      Text(
                        "we have sent an email with 4 digit code to $email",
                        style: AppStyles.descriptions,
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                     Center(child: Directionality(
                            textDirection: ui.TextDirection.ltr,
                              child: Pinput(
                                androidSmsAutofillMethod:  AndroidSmsAutofillMethod.smsUserConsentApi,
                                length: 4,
                                closeKeyboardWhenCompleted: true,

                                focusNode: _pinPutFocusNode,
                                controller: _pinPutController,
                                defaultPinTheme: PinThemeConst.defaultPinTheme,
                                focusedPinTheme: PinThemeConst.focusedPinTheme,
                                submittedPinTheme:
                                PinThemeConst.submittedPinTheme,
                                pinAnimationType: PinAnimationType.rotation,
                                pinputAutovalidateMode:
                                PinputAutovalidateMode.onSubmit,
                                forceErrorState: true,
                                validator: (value) {
                                  if (value!.isEmpty || value.length < 3) {
                                    return 'please enter your code';
                                  } else {
                                    return null;
                                  }
                                },
                              ),
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
                                    builder: (context) =>
                                        const BottomNavigation()));
                          } else {}
                        },
                        backgroundColor: AppColors.white,
                        child: const Text("Send"),
                      ),
                    const  SizedBox(
                        height: 20,
                      ),
                      RebiButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        backgroundColor: AppColors.backgroundColor,
                        isBackButton: true,
                        child: const Text("Back to login"),
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
