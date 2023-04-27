import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:proequine/core/constants/constants.dart';
import 'package:proequine/core/constants/thems/app_styles.dart';
import 'package:proequine/core/utils/extensions.dart';
import 'package:proequine/features/user/presentation/screens/create_password_screen.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/constants/colors/app_colors.dart';
import '../../../../core/utils/validator.dart';
import '../../../../core/widgets/custom_logo_widget.dart';
import '../../../../core/widgets/rebi_button.dart';
import '../../../../core/widgets/rebi_input.dart';
import '../widgets/register_header.dart';

class EmailAndPhoneScreen extends StatefulWidget {
  const EmailAndPhoneScreen({super.key});

  @override
  State<EmailAndPhoneScreen> createState() => _EmailAndPhoneScreenState();
}

class _EmailAndPhoneScreenState extends State<EmailAndPhoneScreen> {
  late final TextEditingController _email;
  late final TextEditingController _phone;
  late final TextEditingController _countryCode;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _email = TextEditingController();
    _phone = TextEditingController();
    _countryCode = TextEditingController(text: "+971");
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _phone.dispose();
    _countryCode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              RegistrationHeader(isThereBackButton: true),
              Transform.translate(
                  offset: const Offset(0.0, -35.0),
                  child: const CustomLogoWidget()),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: kPadding),
                child: Transform.translate(
                  offset: const Offset(0.0, -35.0),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Enter your email address and phone number",
                            style: AppStyles.registrationTitle),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: RebiInput(
                          hintText: 'Email'.tra,
                          controller: _email,
                          keyboardType: TextInputType.name,
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
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: RebiInput(
                                hintText: 'CC'.tra,
                                controller: _countryCode,
                                keyboardType: TextInputType.name,
                                textInputAction: TextInputAction.done,
                                onTap: () {
                                  showModalBottomSheet(
                                      context: context,
                                      builder: (context) => CountryCodePicker(
                                            onChanged:
                                                (CountryCode countryCode) {
                                              setState(() {
                                                _countryCode.text =
                                                    countryCode.dialCode ?? '';
                                                _countryCode.text =
                                                    countryCode.toString();
                                              });
                                              Navigator.pop(
                                                  context); // Pop the bottom sheet
                                            },
                                            hideMainText: false,
                                            showFlagMain: true,
                                            showFlag: true,
                                            flagWidth: 10.0.w,
                                            initialSelection: _countryCode.text,
                                            hideSearch: false,
                                            showCountryOnly: false,
                                            boxDecoration: const BoxDecoration(
                                                color: Colors.transparent,
                                                border: Border.fromBorderSide(
                                                    BorderSide.none)),
                                            showOnlyCountryWhenClosed: false,
                                            onInit: (code) {
                                              _countryCode.text =
                                                  code?.dialCode ?? '';
                                            },
                                            searchDecoration:
                                                const InputDecoration(
                                              prefixIcon: Icon(
                                                Icons.search,
                                                color: AppColors.gold,
                                              ),
                                            ),
                                          ));
                                },
                                autoValidateMode:
                                    AutovalidateMode.onUserInteraction,
                                isOptional: false,
                                color: AppColors.formsLabel,
                                readOnly: true,
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 13),
                                obscureText: false,
                                validator: (value) {
                                  return Validator.requiredValidator(
                                      _countryCode.text);
                                },
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              flex: 3,
                              child: RebiInput(
                                hintText: 'Phone'.tra,
                                controller: _phone,
                                keyboardType: TextInputType.number,
                                textInputAction: TextInputAction.done,
                                onTap: () {},
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
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: kPadding,
                ),
                child: RebiButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const CreatePasswordScreen()));
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
    );
  }
}
