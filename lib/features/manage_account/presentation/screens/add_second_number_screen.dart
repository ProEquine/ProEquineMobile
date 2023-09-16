import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proequine/core/constants/routes/routes.dart';
import 'package:proequine/core/utils/extensions.dart';
import 'package:proequine/core/widgets/phone_number_field_widget.dart';
import 'package:proequine/features/manage_account/domain/manage_account_cubit.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/constants/colors/app_colors.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/constants/thems/app_styles.dart';
import '../../../../core/utils/Printer.dart';
import '../../../../core/utils/rebi_message.dart';
import '../../../../core/utils/validator.dart';
import '../../../../core/widgets/custom_header.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../../../core/widgets/rebi_button.dart';
import '../../../../core/widgets/rebi_input.dart';
import '../../data/edit_phone_request_model.dart';
import '../../../../core/widgets/drop_down_menu_widget.dart';

class AddSecondaryPhoneScreen extends StatefulWidget {
  AddSecondaryPhoneScreen({Key? key}) : super(key: key);

  @override
  State<AddSecondaryPhoneScreen> createState() => _AddSecondaryPhoneScreenState();
}

class _AddSecondaryPhoneScreenState extends State<AddSecondaryPhoneScreen> {
  final TextEditingController _phone = TextEditingController();

  final TextEditingController _countryCode =
  TextEditingController(text: "+971");

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  ManageAccountCubit cubit = ManageAccountCubit();

  List<DropdownMenuItem<String>> phoneTypes = [
    const DropdownMenuItem(
      value: "Calling",
      child: Text("Calling"),
    ),
    const DropdownMenuItem(
      value: "Whatsapp",
      child: Text("Whatsapp"),
    ),
  ];

  String? selectedSecondaryType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(20.0.h),
        child: CustomHeader(
          title: "Add Secondary Number",
          isThereBackButton: true,
        ),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: kPadding),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text("Secondary number", style: AppStyles.mainTitle),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: kPadding),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text("Add a secondary mobile number for enhanced security, account recovery, and backup notifications",
                    style: AppStyles.descriptions),
              ),
            ),
            const SizedBox(height: 14,),
            PhoneNumberFieldWidget(countryCode: _countryCode, phoneNumber: _phone),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 7,horizontal: 15),
              child: DropDownWidget(
                items: phoneTypes,
                selected: selectedSecondaryType,
                onChanged: (secondaryType) {
                  setState(() {
                    selectedSecondaryType = secondaryType;
                    Print('selected secondary $selectedSecondaryType');
                  });
                },
                validator: (value) {
                  // return Validator.requiredValidator(selectedNumber);
                },
                hint: 'Select secondary number usage',
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(kPadding),
              child: BlocConsumer<ManageAccountCubit, ManageAccountState>(
                bloc: cubit,
                builder: (context, state) {
                  if (state is SendPhoneLoading) {
                    return const LoadingCircularWidget();
                  }
                  return RebiButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          FocusManager.instance.primaryFocus?.unfocus();
                          onSendPhone();
                        } else {}
                      },
                      child: const Text("Add"));
                },
                listener: (context, state) {
                  if (state is SendPhoneSuccessful) {
                    Navigator.pushReplacementNamed(context, verifyUpdatePhone,
                        arguments: _countryCode.text + _phone.text);
                    // Navigator.pushReplacement(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => VerifyUpdatedPhoneScreen(
                    //               phone: _countryCode.text + _phone.text,
                    //             )));
                  } else if (state is SendPhoneError) {
                    RebiMessage.error(msg: state.message!, context: context);
                  }
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  onSendPhone() {
    return cubit.sendPhoneNumber(EditPhoneRequestModel(
      newPhoneNumber: _countryCode.text + _phone.text,
    ));
  }
}
