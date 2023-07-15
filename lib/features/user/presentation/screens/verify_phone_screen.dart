import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proequine/core/utils/extensions.dart';
import 'package:proequine/core/utils/sharedpreferences/SharedPreferencesHelper.dart';
import 'package:proequine/core/widgets/loading_widget.dart';
import 'package:proequine/features/user/data/send_verification_request_model.dart';
import 'package:proequine/features/user/domain/user_cubit.dart';
import 'package:proequine/features/user/presentation/screens/verification_screen.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/constants/colors/app_colors.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/constants/thems/app_styles.dart';
import '../../../../core/utils/rebi_message.dart';
import '../../../../core/utils/validator.dart';
import '../../../../core/widgets/custom_logo_widget.dart';
import '../../../../core/widgets/rebi_button.dart';
import '../../../../core/widgets/rebi_input.dart';
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
  double logoHeight = 18.h;

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
                        const Spacer(flex: 3,),
                        const Spacer(flex: 6,),
                        SizedBox(height: 5,),
                        Padding(
                          padding:
                              const EdgeInsets.symmetric(horizontal: kPadding),
                          child: Column(
                            children: [
                               Align(
                                alignment: Alignment.centerLeft,
                                child: Text("Verify Phone Number",
                                    style: AppStyles.mainTitle),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: RebiInput(
                                        onTap: () {
                                          setState(() {
                                            logoHeight = 15.h;
                                          });
                                        },
                                        onFieldSubmitted: (size){
                                          setState(() {
                                            logoHeight = 18.h;
                                          });
                                        },
                                        inputFormatters: [
                                          LengthLimitingTextInputFormatter(4),
                                        ],
                                        hintText: 'CC'.tra,
                                        controller: _countryCode,
                                        keyboardType: TextInputType.number,
                                        textInputAction: TextInputAction.done,
                                        autoValidateMode:
                                            AutovalidateMode.onUserInteraction,
                                        isOptional: false,
                                        color: AppColors.formsLabel,
                                        readOnly: false,
                                        contentPadding:
                                            const EdgeInsets.symmetric(
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
                                        onTap: () {
                                          setState(() {
                                            logoHeight = 15.h;
                                          });
                                        },
                                        onFieldSubmitted: (size){
                                          setState(() {
                                            logoHeight = 18.h;
                                          });
                                        },
                                        hintText: 'Phone'.tra,
                                        controller: _phone,
                                        keyboardType: TextInputType.number,
                                        textInputAction: TextInputAction.done,
                                        autoValidateMode:
                                            AutovalidateMode.onUserInteraction,
                                        isOptional: false,
                                        color: AppColors.formsLabel,
                                        readOnly: false,
                                        contentPadding:
                                            const EdgeInsets.symmetric(
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
                                          if (_formKey.currentState!
                                              .validate()) {
                                            FocusManager.instance.primaryFocus
                                                ?.unfocus();
                                            cubit.sendVerificationCode(
                                                SendVerificationRequestModel(
                                                    phoneNumber:
                                                        _countryCode.text +
                                                            _phone.text,
                                                    channel: "sms"));
                                          } else {}
                                        },
                                        backgroundColor:AppSharedPreferences.getTheme ==
                                            'ThemeCubitMode.dark'
                                            ? AppColors.white
                                            : AppColors.backgroundColor,
                                        child: const Text("Verify"));
                                  },
                                  listener: (context, state) {
                                    if (state is SendVerificationSuccessful) {
                                      AppSharedPreferences.inputPhoneNumber =
                                          _countryCode.text + _phone.text;
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  VerificationScreen(
                                                      email: widget.email,
                                                      name: widget.fullName,
                                                      phone: _countryCode.text +
                                                          _phone.text,
                                                      password: widget.password,
                                                      dob: widget.dob)));
                                    } else if (state is SendVerificationError) {
                                      RebiMessage.error(
                                          msg: state.message!,
                                          context: context);
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
