import 'package:easy_localization/easy_localization.dart';
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
import '../../../../core/global_functions/date_time_picker.dart';
import '../../../../core/utils/validator.dart';
import '../../../../core/widgets/custom_logo_widget.dart';
import '../../../../core/widgets/rebi_button.dart';
import '../../../../core/widgets/rebi_input.dart';
import '../widgets/register_header.dart';
import 'interests_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen

  ({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late final TextEditingController _name;
  late final TextEditingController _dateOfBirth;
  late DateTime dateTime;

  bool privacyValue = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _name = TextEditingController();
    _dateOfBirth = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _name.dispose();
    _dateOfBirth.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                 RegistrationHeader(isThereBackButton:true),
                 Transform.translate(
                     offset:const Offset(0.0,-35.0),
                     child: const CustomLogoWidget()),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: kPadding),
                  child: Transform.translate(
                    offset: const Offset(0.0,-35.0),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                              "Sign up",
                              style: AppStyles.registrationTitle
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: RebiInput(
                            hintText: 'Full Name'.tra,
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
                            hintText: 'Date Of Birth'.tra,
                            controller: _dateOfBirth,
                            keyboardType: TextInputType.name,
                            textInputAction: TextInputAction.done,
                            onTap: () {
                              showDate(context, (value) {
                                setState(() {
                                  dateTime = value!;

                                  final DateFormat formatter =
                                  DateFormat('dd MMM yyyy');
                                  final String formatted =
                                  formatter.format(dateTime);
                                  _dateOfBirth.text = formatted;
                                });
                              });
                            },
                            autoValidateMode: AutovalidateMode.onUserInteraction,
                            isOptional: false,
                            color: AppColors.formsLabel,
                            readOnly: true,
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 13),
                            obscureText: false,
                            validator: (value) {

                              return Validator.requiredValidator(_dateOfBirth.text);
                            },
                          ),
                        ),
                       Transform.translate(
                         offset: const Offset(-10.0,0.0),
                         child: PrivacyAndMarketingCheckBox(
                              isTherePrivacy: true,
                              value: privacyValue,
                              onChanged: (value) {
                                setState(() {
                                  privacyValue = value!;
                                });
                              }),
                       ),
                        SizedBox(height: 20,),

                        privacyValue
                            ? Padding(
                          padding:
                          const EdgeInsets.symmetric(vertical: 20),
                          child: RebiButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  Navigator.push(context, MaterialPageRoute(
                                      builder: (context) =>
                                          const InterestsScreen()));
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
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
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
