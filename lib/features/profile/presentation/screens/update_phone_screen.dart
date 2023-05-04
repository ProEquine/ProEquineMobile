import 'package:flutter/material.dart';
import 'package:proequine/core/utils/extensions.dart';
import 'package:proequine/features/profile/presentation/screens/verify_email_screen.dart';
import 'package:proequine/features/profile/presentation/screens/verify_updated_phone_screen.dart';
import 'package:proequine/features/user/presentation/screens/verify_phone_screen.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/constants/colors/app_colors.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/utils/validator.dart';
import '../../../../core/widgets/custom_header.dart';
import '../../../../core/widgets/headerText.dart';
import '../../../../core/widgets/rebi_button.dart';
import '../../../../core/widgets/rebi_input.dart';

class UpdatePhoneScreen extends StatelessWidget {
  UpdatePhoneScreen({Key? key}) : super(key: key);

  final TextEditingController _phone = TextEditingController();
  final TextEditingController _countryCode = TextEditingController(text: "+971");
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(20.0.h),
        child: CustomHeader(
          title: "",
          isThereBackButton: true,
        ),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            HeaderText("Update Phone Number", "", false),
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10,horizontal: kPadding),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: RebiInput(
                      hintText: 'CC'.tra,
                      controller: _countryCode,
                      keyboardType: TextInputType.number,
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
                        return Validator.countryCodeValidator(
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
                      autoValidateMode:
                      AutovalidateMode.onUserInteraction,
                      isOptional: false,
                      color: AppColors.formsLabel,
                      readOnly: false,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 13),
                      obscureText: false,
                      validator: (value) {
                        return Validator.phoneValidator(
                            _phone.text);
                      },
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(kPadding),
              child: RebiButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => VerifyUpdatedPhoneScreen(
                                phone: _phone.text,
                              )));
                    } else {}
                  },
                  child: const Text("Update")),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
