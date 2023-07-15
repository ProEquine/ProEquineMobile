import 'package:flutter/material.dart';
import 'package:proequine/core/constants/constants.dart';
import 'package:proequine/core/constants/thems/app_styles.dart';
import 'package:proequine/core/utils/extensions.dart';
import 'package:proequine/features/user/presentation/screens/verify_phone_screen.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/constants/colors/app_colors.dart';
import '../../../../core/utils/sharedpreferences/SharedPreferencesHelper.dart';
import '../../../../core/utils/validator.dart';
import '../../../../core/widgets/custom_logo_widget.dart';
import '../../../../core/widgets/rebi_button.dart';
import '../../../../core/widgets/rebi_input.dart';
import '../widgets/register_header.dart';

class SignUpScreen extends StatefulWidget {
 final String? dob;
 final String? name;

  const SignUpScreen({super.key, this.dob, this.name});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late final TextEditingController _email;
  late final TextEditingController _password;
  late final TextEditingController _confirmPassword;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  double logoHeight = 18.h;

  @override
  void initState() {
    _email = TextEditingController();

    _password = TextEditingController();
    _confirmPassword = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    _confirmPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
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
                        RegistrationHeader(isThereBackButton: true),
                        const Spacer(flex: 3,),
                        // AnimatedContainer(
                        //     duration: const Duration(milliseconds: 500),
                        //     height: logoHeight,
                        //     child: const CustomLogoWidget()),
                        // const Spacer(flex: 3,),
                        const SizedBox(height: 35,),
                        Padding(
                          padding:
                              const EdgeInsets.symmetric(horizontal: kPadding),
                          child: Column(
                            children: [
                               Align(
                                alignment: Alignment.centerLeft,
                                child: Text("Enter Email & Password",
                                    style: AppStyles.mainTitle),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: RebiInput(
                                  onTap: () {
                                    setState(() {
                                      logoHeight = 15.h;
                                    });
                                  },
                                  onFieldSubmitted: (size){
                                    setState(() {
                                      logoHeight = 18.h;
                                    });
                                  },
                                  hintText: 'Email'.tra,
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
                                    return Validator.emailValidator(
                                        _email.text);
                                  },
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: RebiInput(
                                  onTap: () {
                                    setState(() {
                                      logoHeight = 15.h;
                                    });
                                  },
                                  onFieldSubmitted: (size){
                                    setState(() {
                                      logoHeight = 18.h;
                                    });
                                  },
                                  hintText: 'Password'.tra,
                                  controller: _password,
                                  keyboardType: TextInputType.visiblePassword,
                                  textInputAction: TextInputAction.done,
                                  isOptional: false,
                                  autoValidateMode:
                                  AutovalidateMode.onUserInteraction,
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
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: RebiInput(
                                  onTap: () {
                                    setState(() {
                                      logoHeight = 15.h;
                                    });
                                  },
                                  onFieldSubmitted: (size){
                                    setState(() {
                                      logoHeight = 18.h;
                                    });
                                  },
                                  hintText: 'Confirm password'.tra,
                                  controller: _confirmPassword,
                                  scrollPadding: const EdgeInsets.only(bottom: 100),
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
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: kPadding
                          ),
                          child: RebiButton(
                            backgroundColor:AppSharedPreferences.getTheme ==
                                'ThemeCubitMode.dark'
                                ? AppColors.white
                                : AppColors.backgroundColor,
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => VerifyPhoneScreen(
                                              fullName: widget.name,
                                              dob: widget.dob,
                                              password: _password.text,
                                              email: _email.text,
                                            )));
                              } else {}
                            },
                            child: const Text("Continue"),
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
}
