import 'package:flutter/material.dart';
import 'package:proequine/core/utils/extensions.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/constants/colors/app_colors.dart';
import '../../../../core/utils/Printer.dart';
import '../../../../core/utils/validator.dart';
import '../../../../core/widgets/custom_header.dart';
import '../../../../core/widgets/headerText.dart';
import '../../../../core/widgets/rebi_button.dart';
import '../../../../core/widgets/rebi_input.dart';
import '../../../../core/widgets/thank_widget.dart';

class Support extends StatelessWidget {
  final TextEditingController bookingNumber = TextEditingController();
  final TextEditingController descriptionIssue = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Support({super.key});

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
            HeaderText("Support", "Get in touch, we're here to help",true),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
              child: RebiInput(
                labelText: 'Booking Refrence number'.tra,
                controller: bookingNumber,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.done,
                autoValidateMode: AutovalidateMode.onUserInteraction,
                isOptional: false,
                color: AppColors.formsLabel,
                readOnly: false,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
                obscureText: false,
                validator: (value) {
                  return Validator.requiredValidator(bookingNumber.text);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
              child: RebiInput(
                labelText: 'Description of the Issue or Query'.tra,
                controller: descriptionIssue,
                keyboardType: TextInputType.multiline,
                maxLines: 5,
                textInputAction: TextInputAction.done,
                autoValidateMode: AutovalidateMode.onUserInteraction,
                isOptional: false,
                color: AppColors.formsLabel,
                readOnly: false,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
                obscureText: false,
                validator: (value) {
                  return Validator.requiredValidator(descriptionIssue.text);
                },
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: RebiButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Print("Success");
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ThanksWidget()));
                    } else {}
                  },
                  child: Text("Send")),
            ),
            const SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }
}
