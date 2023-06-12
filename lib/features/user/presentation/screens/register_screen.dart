import 'package:flutter/material.dart';
import 'package:proequine/core/constants/constants.dart';
import 'package:proequine/core/constants/thems/app_styles.dart';
import 'package:proequine/core/utils/extensions.dart';
import 'package:proequine/core/utils/rebi_message.dart';
import 'package:proequine/core/widgets/privacy_checkbox.dart';
import 'package:proequine/features/user/presentation/screens/signup_screen.dart';

import '../../../../core/constants/colors/app_colors.dart';
import '../../../../core/utils/validator.dart';
import '../../../../core/widgets/custom_logo_widget.dart';
import '../../../../core/widgets/date_time_picker.dart';
import '../../../../core/widgets/rebi_button.dart';
import '../../../../core/widgets/rebi_input.dart';
import '../widgets/register_header.dart';
import 'package:intl/date_symbol_data_local.dart';

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
  late final TextEditingController year;

  late DateTime dateTime;

  var now = DateTime.now();

  int? firstDay = 1;
  int? firstMonth = 1;
  int? firstYear = 1;
  int? lastDay = 30;
  int? lastMonth = 1;
  int? lastYear = 1;

  bool privacyValue = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _yearKey = GlobalKey<FormState>();
  final DateTime _selectedDay = DateTime.utc(1950);
  final DateTime _focusedDay = DateTime.now();
  late int _selectedYear;
  late TextEditingController _yearController;

  @override
  void initState() {
    initializeDateFormatting();
    _firstName = TextEditingController();
    _yearController = TextEditingController(text: _selectedDay.year.toString());
    _middleName = TextEditingController();
    _lastName = TextEditingController();
    _dateOfBirth = TextEditingController();
    year = TextEditingController();
    _selectedYear = _selectedDay.year;

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
                                    selectDate(
                                        context: context,
                                        isSupportChangingYears: true,
                                        selectedOurDay: _selectedDay,
                                        from: DateTime.utc(1950),
                                        to: DateTime.utc(2030),
                                        selectedYear: _selectedYear,
                                        yearController: _yearController,
                                        focusDay: _focusedDay,
                                        controller: _dateOfBirth,
                                        yearKey: _yearKey);
                                    // showDate(context, (value) {
                                    //   setState(() {
                                    //     dateTime = value!;
                                    //     final DateFormat formatter =
                                    //         DateFormat('dd MMM yyyy');
                                    //     final String formatted =
                                    //         formatter.format(dateTime);
                                    //     _dateOfBirth.text = formatted;
                                    //   });
                                    // });
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
                                                            dob: _selectedDay
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
                                                        .tra,
                                                context: context);
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
