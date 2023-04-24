import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:proequine/core/constants/constants.dart';
import 'package:proequine/core/constants/thems/app_styles.dart';
import 'package:proequine/core/utils/extensions.dart';
import 'package:proequine/core/utils/rebi_message.dart';
import 'package:proequine/core/widgets/marketing_checkbox.dart';
import 'package:proequine/features/user/presentation/screens/verification_screen.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/constants/colors/app_colors.dart';
import '../../../../core/constants/routes/routes.dart';
import '../../../../core/utils/validator.dart';
import '../../../../core/widgets/custom_logo_widget.dart';
import '../../../../core/widgets/rebi_button.dart';
import '../../../../core/widgets/rebi_input.dart';
import '../../../../core/widgets/registration_header.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen

  ({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late final TextEditingController _name;
  late final TextEditingController _phone;
  late final TextEditingController _email;
  late final TextEditingController _password;
  late final TextEditingController _confirmPassword;
  bool privacyValue = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _name = TextEditingController();
    _phone = TextEditingController(text: "+971");
    _email = TextEditingController();
    _password = TextEditingController();
    _confirmPassword = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _name.dispose();
    _phone.dispose();
    _email.dispose();
    _password.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(1.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const RegistrationHeader(),
                    const CustomLogoWidget(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: kPadding),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                                "Sign up",
                                style: AppStyles.registrationTitle
                            ),
                          ),
                          SizedBox(height: 3.0.h,),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: RebiInput(
                              labelText: 'Email'.tra,
                              controller: _email,
                              keyboardType: TextInputType.emailAddress,
                              textInputAction: TextInputAction.done,
                              autoValidateMode:
                              AutovalidateMode.onUserInteraction,
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
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: RebiInput(
                              labelText: 'Full Name'.tra,
                              controller: _name,
                              keyboardType: TextInputType.name,
                              textInputAction: TextInputAction.done,
                              autoValidateMode:
                              AutovalidateMode.onUserInteraction,
                              isOptional: false,
                              color: AppColors.formsLabel,
                              readOnly: false,
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 13),
                              obscureText: false,
                              validator: (value) {
                                return Validator.requiredValidator(_name.text);
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: RebiInput(
                              labelText: 'Phone'.tra,
                              controller: _phone,
                              keyboardType: TextInputType.phone,
                              textInputAction: TextInputAction.done,
                              autoValidateMode:
                              AutovalidateMode.onUserInteraction,
                              isOptional: false,
                              color: AppColors.formsLabel,
                              readOnly: false,
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 13),
                              obscureText: false,
                              validator: (value) {
                                return Validator.phoneValidator(_phone.text);
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: RebiInput(
                              labelText: 'Password'.tra,
                              controller: _password,
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
                                    _password.text);
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: RebiInput(
                              labelText: 'Confirm password'.tra,
                              controller: _confirmPassword,
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
                                } else if (value != _password.text) {
                                  return "password does not match".tra;
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ),
                          PrivacyAndMarketingCheckBox(
                              isTherePrivacy: true,
                              value: privacyValue,
                              onChanged: (value) {
                                setState(() {
                                  privacyValue = value!;
                                });
                              }),
                          privacyValue
                              ? Padding(
                            padding:
                            const EdgeInsets.symmetric(vertical: 20),
                            child: RebiButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    Navigator.push(context, MaterialPageRoute(
                                        builder: (context) =>
                                            VerificationScreen(email:_email.text)));
                                  } else {}
                                },
                                backgroundColor: AppColors.white,
                                child: const Text("Sign up")),
                          )
                              : Padding(
                            padding:
                            const EdgeInsets.symmetric(vertical: 20),
                            child: RebiButton(
                                onPressed: () {
                                  RebiMessage.error(
                                      msg:
                                      "Please accept the privacy first"
                                          .tra);
                                },
                                backgroundColor: AppColors.formsLabel,
                                child: const Text("Sign up")),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: RichText(
                              text: TextSpan(children: <TextSpan>[
                                TextSpan(
                                  text: "Already have an account? ".tra,
                                  style: const TextStyle(
                                      color: AppColors.white, fontSize: 16),
                                ),
                                TextSpan(
                                    text: " Sign In".tra,
                                    style: const TextStyle(
                                        color: AppColors.gold,
                                        fontSize: 16,
                                        decoration: TextDecoration.underline),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.pushNamed(
                                            context, loginRoute);
                                      }),
                              ]),
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
        ),
      ),
    );
  }
}
