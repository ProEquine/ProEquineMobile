import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proequine/core/constants/constants.dart';
import 'package:proequine/core/utils/extensions.dart';
import 'package:proequine/core/utils/rebi_message.dart';
import 'package:proequine/core/utils/sharedpreferences/SharedPreferencesHelper.dart';
import 'package:proequine/core/widgets/loading_widget.dart';
import 'package:proequine/features/profile/data/support_request_model.dart';
import 'package:proequine/features/profile/domain/profile_cubit.dart';
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

  ProfileCubit cubit =ProfileCubit();

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
            HeaderText("Support", "Get in touch, we're here to help", true),
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
                isOptional: true,
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
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: BlocConsumer<ProfileCubit, ProfileState>(
                bloc: cubit,
                listener: (context, state) {
                  if (state is ContactSupportSuccessful){
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ThanksWidget()));
                  }else if (state is ContactSupportError){
                    RebiMessage.error(msg: state.message!);
                  }
                },
                builder: (context, state) {
                  if(state is ContactSupportLoading){
                    return LoadingCircularWidget();
                  }
                  return RebiButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          FocusManager.instance.primaryFocus?.unfocus();
                          onPressSend();
                        } else {}
                      },
                      child: const Text("Send"));
                },
              ),
            ),
            const SizedBox(
              height: 40,
            )
          ],
        ),
      ),
    );
  }
  onPressSend(){
    return cubit.contactSupport(SupportRequestModel(
      referenceNumber: bookingNumber.text,
      description: descriptionIssue.text,
      phoneNumber: AppSharedPreferences.userPhoneNumber,
    ));
  }
}
