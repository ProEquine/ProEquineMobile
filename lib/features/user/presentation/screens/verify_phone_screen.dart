import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proequine/core/widgets/loading_widget.dart';
import 'package:proequine/core/widgets/phone_number_field_widget.dart';
import 'package:proequine/features/user/domain/user_cubit.dart';
import 'package:proequine/features/user/presentation/screens/verification_screen.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/constants/thems/app_styles.dart';

import '../../../../core/utils/Printer.dart';
import '../../../../core/widgets/rebi_button.dart';
import '../widgets/register_header.dart';

class VerifyPhoneScreen extends StatefulWidget {
  String? fullName;
  String? dob;
  String? email;
  String? password;

  VerifyPhoneScreen(
      {super.key, this.fullName, this.dob, this.email, this.password});

  @override
  State<VerifyPhoneScreen> createState() => _VerifyPhoneScreenState();
}

class _VerifyPhoneScreenState extends State<VerifyPhoneScreen> {
  late final TextEditingController _phone;
  late final TextEditingController _countryCode;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final UserCubit cubit = UserCubit();
  String? dob = '';
  String? phoneNumber;

  @override
  void initState() {
    _phone = TextEditingController();
    _countryCode = TextEditingController(text: "+971");
    super.initState();
  }

  @override
  void dispose() {
    _phone.dispose();
    _countryCode.dispose();
    cubit.close();
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
                        Spacer(),
                        Padding(
                          padding:
                              const EdgeInsets.symmetric(horizontal: kPadding),
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text("Mobile number",
                                    style: AppStyles.mainTitle),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                    "For account verification and receive timely notifications this helps us ensure your account's safety while keeping you informed",
                                    style: AppStyles.descriptions),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                             PhoneNumberFieldWidget(countryCode: _countryCode, phoneNumber: _phone),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 20),
                                child: BlocConsumer<UserCubit, UserState>(
                                  bloc: cubit,
                                  builder: (context, state) {
                                    if (state is SendVerificationLoading) {
                                      return const LoadingCircularWidget();
                                    }
                                    return RebiButton(
                                        onPressed: () {
                                          phoneNumber=_countryCode
                                              .text +
                                              _phone.text;
                                          Print(phoneNumber);
                                          if (_formKey.currentState!
                                              .validate()) {
                                            FocusManager.instance.primaryFocus
                                                ?.unfocus();
                                            // cubit.sendVerificationCode(
                                            //     SendVerificationRequestModel(
                                            //         phoneNumber:
                                            //             _countryCode.text +
                                            //                 _phone.text,
                                            //         channel: "sms"));

                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        VerificationScreen(
                                                            email: widget.email,
                                                            name:
                                                                widget.fullName,
                                                            phone: phoneNumber,
                                                            password:
                                                                widget.password,
                                                            dob: widget.dob)));
                                          } else {}
                                        },
                                        child: const Text("Verify"));
                                  },
                                  listener: (context, state) {

                                    // if (state is SendVerificationSuccessful) {
                                    //   AppSharedPreferences.inputPhoneNumber =
                                    //       _countryCode.text + _phone.text;
                                    //   Navigator.push(
                                    //       context,
                                    //       MaterialPageRoute(
                                    //           builder: (context) =>
                                    //               VerificationScreen(
                                    //                   email: widget.email,
                                    //                   name: widget.fullName,
                                    //                   phone: _countryCode.text +
                                    //                       _phone.text,
                                    //                   password: widget.password,
                                    //                   dob: widget.dob)));
                                    // } else if (state is SendVerificationError) {
                                    //   RebiMessage.error(
                                    //       msg: state.message!,
                                    //       context: context);
                                  },
                                ),
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
