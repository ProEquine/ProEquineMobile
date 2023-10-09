import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:proequine/core/constants/constants.dart';
import 'package:proequine/core/constants/images/app_images.dart';
import 'package:proequine/core/constants/thems/app_styles.dart';
import 'package:proequine/core/utils/extensions.dart';
import 'package:proequine/features/user/presentation/screens/verify_phone_screen.dart';
import 'package:proequine/features/user/presentation/widgets/security_cases_widget.dart';
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
  final String? firstName;
  final String? middleName;
  final String? lastName;
  final String? gender;
  final String? nationality;

  const SignUpScreen(
      {super.key,
      this.dob,
      this.firstName,
      this.middleName,
      this.lastName,
      this.gender,
      this.nationality});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late final TextEditingController _email;
  late final TextEditingController _password;
  late final TextEditingController _confirmPassword;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isCoverCases = false;
  bool isCoverNumbers = false;
  bool isCoverCharacters = false;
  bool isCoverSpecial = false;
  bool isCoverAllCases = false;

  bool _containsSymbol(String value) {
    return value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
  }

  bool _containsNumber(String value) {
    return value.contains(RegExp(r'[0-9]'));
  }

  bool _containsCapitalLetter(String value) {
    return value.contains(RegExp(r'[A-Z]'));
  }

  bool _containsSmallLetter(String value) {
    return value.contains(RegExp(r'[a-z]'));
  }

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
                        const Spacer(
                          flex: 3,
                        ),
                        const SizedBox(
                          height: 35,
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.symmetric(horizontal: kPadding),
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text("Enter your email",
                                    style: AppStyles.mainTitle),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                    "For account verification and receive timely notifications this helps us",
                                    style: AppStyles.descriptions),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 7),
                                child: RebiInput(
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
                              const SizedBox(
                                height: 24,
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text("Create your password",
                                    style: AppStyles.mainTitle),
                              ),
                              const SizedBox(
                                height: 14,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  SvgPicture.asset(
                                    isCoverAllCases
                                        ? AppIcons.check
                                        : AppIcons.info,
                                    height: isCoverAllCases ? 25 : 40,
                                    color: isCoverAllCases
                                        ? AppColors.greenLight
                                        : AppColors.yellow,
                                  ),
                                  SecurityCasesWidget(
                                    header: "Aa",
                                    description: "Cases",
                                    isValidate: isCoverCases,
                                  ),
                                  SecurityCasesWidget(
                                    header: "@!&",
                                    description: "Special",
                                    isValidate: isCoverSpecial,
                                  ),
                                  SecurityCasesWidget(
                                    header: "1",
                                    description: "Number",
                                    isValidate: isCoverNumbers,
                                  ),
                                  SecurityCasesWidget(
                                    header: "8+",
                                    description: "characters",
                                    isValidate: isCoverCharacters,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 7,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 7),
                                child: RebiInput(
                                  hintText: 'Password'.tra,
                                  controller: _password,
                                  onChanged: (value) {
                                    if (_containsSymbol(value!)) {
                                      setState(() {
                                        isCoverSpecial = true;
                                      });
                                    } else {
                                      setState(() {
                                        isCoverSpecial = false;
                                      });
                                    }
                                    if (_containsCapitalLetter(value) &&
                                        _containsSmallLetter(value)) {
                                      setState(() {
                                        isCoverCases = true;
                                      });
                                    } else {
                                      setState(() {
                                        isCoverCases = false;
                                      });
                                    }
                                    if (_containsNumber(value)) {
                                      setState(() {
                                        isCoverNumbers = true;
                                      });
                                    } else {
                                      setState(() {
                                        isCoverNumbers = false;
                                      });
                                    }
                                    if (value.length >= 8) {
                                      setState(() {
                                        isCoverCharacters = true;
                                      });
                                    } else {
                                      setState(() {
                                        isCoverCharacters = false;
                                      });
                                    }
                                    if (_containsNumber(value) &&
                                        _containsSmallLetter(value) &&
                                        _containsCapitalLetter(value) &&
                                        _containsSymbol(value) &&
                                        value.length >= 8) {
                                      setState(() {
                                        isCoverAllCases = true;
                                      });
                                    } else {
                                      setState(() {
                                        isCoverAllCases = false;
                                      });
                                    }
                                  },
                                  keyboardType: TextInputType.visiblePassword,
                                  textInputAction: TextInputAction.done,
                                  isOptional: false,
                                  autoValidateMode: AutovalidateMode.disabled,
                                  color: AppColors.formsLabel,
                                  readOnly: false,
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 13),
                                  obscureText: true,
                                  validator: (value) {
                                    if (!_containsNumber(value!) ||
                                        !_containsSmallLetter(value) ||
                                        !_containsCapitalLetter(value) ||
                                        !_containsSymbol(value) ||
                                        value.length < 8) {
                                      return 'Password must include numbers, capital letters, and symbols.'
                                          .tra;
                                    }
                                    if (value.isEmpty) {
                                      return 'Please enter your password'.tra;
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 7),
                                child: RebiInput(
                                  hintText: 'Confirm password'.tra,
                                  controller: _confirmPassword,
                                  scrollPadding:
                                      const EdgeInsets.only(bottom: 100),
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
                                      return "".tra;
                                    } else if (value != _password.text) {
                                      return "".tra;
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
                          padding:
                              const EdgeInsets.symmetric(horizontal: kPadding),
                          child: RebiButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => VerifyPhoneScreen(
                                              firstName: widget.firstName,
                                              middleName: widget.middleName,
                                              lastName: widget.lastName,
                                              dob: widget.dob,
                                              password: _password.text,
                                              email: _email.text,
                                              confirmPassword:
                                                  _confirmPassword.text,
                                              gender: widget.gender,
                                              nationality: widget.nationality,
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
