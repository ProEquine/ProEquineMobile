import 'package:flutter/material.dart';
import 'package:proequine/core/utils/extensions.dart';
import 'package:proequine/features/user/presentation/screens/verification_screen.dart';

import '../../../../core/constants/colors/app_colors.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/constants/thems/app_styles.dart';
import '../../../../core/utils/validator.dart';
import '../../../../core/widgets/custom_logo_widget.dart';
import '../../../../core/widgets/rebi_button.dart';
import '../../../../core/widgets/rebi_input.dart';
import '../widgets/register_header.dart';
class CreatePasswordScreen extends StatefulWidget {
  const CreatePasswordScreen({Key? key}) : super(key: key);

  @override
  State<CreatePasswordScreen> createState() => _CreatePasswordScreenState();
}

class _CreatePasswordScreenState extends State<CreatePasswordScreen> {
  late final TextEditingController _password;
  late final TextEditingController _confirmPassword;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    _password = TextEditingController();
    _confirmPassword = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _password.dispose();
    _confirmPassword.dispose();
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
                              "Create Password",
                              style: AppStyles.registrationTitle
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: RebiInput(
                            hintText: 'Password'.tra,
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
                            hintText: 'Confirm password'.tra,
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
                        const SizedBox(height: 20,),
                        Padding(
                          padding:
                          const EdgeInsets.symmetric(vertical: 20),
                          child: RebiButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  Navigator.push(context, MaterialPageRoute(
                                      builder: (context) =>
                                       VerificationScreen()));
                                } else {}
                              },
                              backgroundColor: AppColors.white,
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
