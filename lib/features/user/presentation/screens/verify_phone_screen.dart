import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proequine/core/utils/extensions.dart';
import 'package:proequine/core/utils/sharedpreferences/SharedPreferencesHelper.dart';
import 'package:proequine/core/widgets/loading_widget.dart';
import 'package:proequine/features/user/data/register_request_model.dart';
import 'package:proequine/features/user/domain/user_cubit.dart';
import 'package:proequine/features/user/presentation/screens/verification_screen.dart';

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
                        const CustomLogoWidget(),
                        const SizedBox(
                          height: 40,
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.symmetric(horizontal: kPadding),
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text("Verify Phone Number",
                                    style: AppStyles.registrationTitle),
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
                                    if (state is RegisterLoading) {
                                      return const LoadingCircularWidget();
                                    }
                                    return RebiButton(
                                        onPressed: () {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            FocusManager.instance.primaryFocus?.unfocus();
                                            _sendRegisterData(
                                                email: widget.email,
                                                name: widget.fullName,
                                                phone: _countryCode.text +
                                                    _phone.text,
                                                password: widget.password,
                                                dob: widget.dob);
                                          } else {}
                                        },
                                        backgroundColor: AppColors.white,
                                        child: const Text("Verify"));
                                  },
                                  listener: (context, state) {
                                    if (state is RegisterSuccessful) {
                                      AppSharedPreferences.inputPhoneNumber =
                                          _countryCode.text + _phone.text;
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  VerificationScreen(
                                                    phone: _countryCode.text +
                                                        _phone.text,
                                                  )));
                                    } else if (state is RegisterError) {
                                      RebiMessage.error(msg: state.message!,context: context);
                                    }
                                  },
                                ),
                              ),
                              const SizedBox(
                                height: 40,
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

  _sendRegisterData(
      {String? email,
      String? name,
      String? phone,
      String? password,
      String? dob}) {
    return cubit.register(RegisterRequestModel(
      email: email,
      fullName: name,
      password: password,
      phoneNumber: phone,
      dob: dob,
    ));
  }
}
