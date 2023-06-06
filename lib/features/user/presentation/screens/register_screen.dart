import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:proequine/core/constants/constants.dart';
import 'package:proequine/core/constants/thems/app_styles.dart';
import 'package:proequine/core/utils/extensions.dart';
import 'package:proequine/core/utils/rebi_message.dart';
import 'package:proequine/core/widgets/privacy_checkbox.dart';
import 'package:proequine/features/user/presentation/screens/signup_screen.dart';
import '../../../../core/constants/colors/app_colors.dart';
import '../../../../core/global_functions/date_time_picker.dart';
import '../../../../core/utils/validator.dart';
import '../../../../core/widgets/custom_logo_widget.dart';
import '../../../../core/widgets/rebi_button.dart';
import '../../../../core/widgets/rebi_input.dart';
import '../widgets/register_header.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late final TextEditingController _firstName;
  late final TextEditingController _middleName;
  late final TextEditingController _lastName;
  late final TextEditingController _dateOfBirth;

  late DateTime dateTime;
  late String dateTimeInString;

  bool privacyValue = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _firstName = TextEditingController();
    _middleName = TextEditingController();
    _lastName = TextEditingController();
    _dateOfBirth = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _firstName.dispose();
    _middleName.dispose();
    _lastName.dispose();
    _dateOfBirth.dispose();
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
              child: SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraint.maxHeight),
                  child: IntrinsicHeight(
                    child: Column(
                      children: [
                        RegistrationHeader(isThereBackButton: true),
                        const CustomLogoWidget(),
                        const Spacer(),
                        Padding(
                          padding:
                              const EdgeInsets.symmetric(horizontal: kPadding),
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text("Sign up",
                                    style: AppStyles.registrationTitle),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Expanded(
                                    flex: 9,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10),
                                      child: RebiInput(
                                        hintText: 'First Name'.tra,
                                        controller: _firstName,
                                        keyboardType: TextInputType.name,
                                        textInputAction: TextInputAction.done,
                                        isOptional: false,
                                        color: AppColors.formsLabel,
                                        readOnly: false,
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 20, vertical: 13),
                                        obscureText: false,
                                        validator: (value) {
                                          return Validator.requiredValidator(
                                              _firstName.text);
                                        },
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Expanded(
                                    flex: 10,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10),
                                      child: RebiInput(
                                        hintText: 'Middle Name'.tra,
                                        controller: _middleName,
                                        keyboardType: TextInputType.name,
                                        textInputAction: TextInputAction.done,
                                        isOptional: false,
                                        color: AppColors.formsLabel,
                                        readOnly: false,
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 20, vertical: 13),
                                        obscureText: false,
                                        validator: (value) {
                                          return Validator.requiredValidator(
                                              _middleName.text);
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: RebiInput(
                                  hintText: 'Last Name'.tra,
                                  controller: _lastName,
                                  keyboardType: TextInputType.name,
                                  textInputAction: TextInputAction.done,
                                  isOptional: false,
                                  color: AppColors.formsLabel,
                                  readOnly: false,
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 13),
                                  obscureText: false,
                                  validator: (value) {
                                    return Validator.requiredValidator(
                                        _lastName.text);
                                  },
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: RebiInput(
                                  hintText: 'Date Of Birth'.tra,
                                  controller: _dateOfBirth,
                                  keyboardType: TextInputType.name,
                                  textInputAction: TextInputAction.done,
                                  onTap: () {
                                    DatePicker.showDatePicker(context,
                                        theme: DatePickerTheme(
                                          containerHeight: 210.0,
                                        ),
                                        showTitleActions: true,
                                        minTime: DateTime(1950, 1, 1),
                                        maxTime: DateTime(2010, 12, 31), onConfirm: (date) {
                                          print('confirm $date');
                                          dateTimeInString = '${date.year} - ${date.month} - ${date.day}';
                                          setState(() {});
                                        }, currentTime: DateTime.now(), locale: LocaleType.en);
                                  },
                                  isOptional: false,
                                  color: AppColors.formsLabel,
                                  readOnly: true,
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 13),
                                  obscureText: false,
                                  validator: (value) {
                                    return Validator.requiredValidator(
                                        _dateOfBirth.text);
                                  },
                                ),
                              ),
                              Transform.translate(
                                offset: const Offset(-10.0, 0.0),
                                child: PrivacyCheckBox(
                                    isTherePrivacy: true,
                                    value: privacyValue,
                                    onChanged: (value) {
                                      setState(() {
                                        privacyValue = value!;
                                      });
                                    }),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              privacyValue
                                  ? Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 20),
                                      child: RebiButton(
                                          onPressed: () {
                                            if (_formKey.currentState!
                                                .validate()) {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          SignUpScreen(
                                                            dob: dateTime
                                                                .toIso8601String(),
                                                            name:
                                                                '${"${_firstName.text} ${_middleName.text} ${_lastName.text}"} ',
                                                          )));
                                            } else {}
                                          },
                                          backgroundColor: AppColors.white,
                                          child: const Text("Sign up")),
                                    )
                                  : Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 20),
                                      child: RebiButton(
                                          onPressed: () {
                                            RebiMessage.error(
                                                msg:
                                                    "Please accept the privacy first"
                                                        .tra,context: context);
                                          },
                                          backgroundColor: AppColors.formsLabel,
                                          child: const Text("Sign up")),
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
