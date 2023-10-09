import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinput/pinput.dart';
import 'package:proequine/core/utils/sharedpreferences/SharedPreferencesHelper.dart';
import 'package:proequine/core/widgets/divider.dart';
import 'package:proequine/core/widgets/submit_verification_widget.dart';
import 'package:sizer/sizer.dart';
import 'dart:ui' as ui;

import '../../../../core/constants/colors/app_colors.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/constants/thems/app_styles.dart';
import '../../../../core/constants/thems/pin_put_theme.dart';
import '../../../../core/utils/rebi_message.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../../../core/widgets/rebi_button.dart';
import '../../data/register_request_model.dart';
import '../../data/send_verification_request_model.dart';
import '../../domain/user_cubit.dart';
import '../widgets/register_header.dart';

class VerificationScreen extends StatefulWidget {
  final String? phone;
  final String? email;
  final String? firstName;
  final String? middleName;
  final String? lastName;
  final String? password;
  final String? confirmPassword;
  final String? gender;
  final String? nationality;
  final String? dob;

  const VerificationScreen(
      {super.key,
      this.phone,
      this.email,
      this.firstName,
      this.middleName,
      this.lastName,
      this.password,
      this.dob,
      this.gender,
      this.nationality,
      this.confirmPassword});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _pinPutController = TextEditingController();
  int _secondsLeft = 60;
  bool isResendCode = false;
  late Timer _timer;

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_secondsLeft > 0) {
          _secondsLeft--;
        } else {
          _timer.cancel();
          isResendCode = false;
          _secondsLeft = 60;
        }
      });
    });
  }

  UserCubit cubit = UserCubit();
  double logoHeight = 15.h;

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String minutes = twoDigits(duration.inMinutes.remainder(60));
    String seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$minutes:$seconds";
  }

  @override
  void initState() {
    // context.read<UserCubit>().sendVerificationCode(SendVerificationRequestModel(
    //     phoneNumber: widget.phone ?? AppSharedPreferences.userPhoneNumber,
    //     channel: "sms"));
    super.initState();
  }

  @override
  void dispose() {
    _pinPutController.dispose();
    cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: LayoutBuilder(builder: (context, constraint) {
          return SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraint.maxHeight),
                child: IntrinsicHeight(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      RegistrationHeader(isThereBackButton: true),
                      const Spacer(
                        flex: 1,
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.symmetric(horizontal: kPadding),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Confirm your number",
                                style: AppStyles.mainTitle),
                            SizedBox(
                              height: 1.h,
                            ),
                            Text(
                              "A 4 digit verification code has been sent to your registered phone number.",
                              style: AppStyles.descriptions,
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            Center(
                              child: Directionality(
                                textDirection: ui.TextDirection.ltr,
                                child: Pinput(
                                  scrollPadding: EdgeInsets.only(bottom: 50.h),
                                  preFilledWidget: Container(
                                    width: 30,
                                    height: 5,
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 15),
                                    decoration: BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                          width: 2.0,
                                          color:
                                              AppSharedPreferences.getTheme ==
                                                      'ThemeCubitMode.dark'
                                                  ? AppColors.greyLight
                                                  : AppColors.blackLight,
                                        ),
                                      ),
                                      color: AppSharedPreferences.getTheme ==
                                              'ThemeCubitMode.dark'
                                          ? AppColors.formsBackground
                                          : AppColors.formsBackgroundLight,
                                    ),
                                  ),
                                  androidSmsAutofillMethod:
                                      AndroidSmsAutofillMethod
                                          .smsUserConsentApi,
                                  length: 4,
                                  closeKeyboardWhenCompleted: true,
                                  isCursorAnimationEnabled: true,
                                  controller: _pinPutController,
                                  defaultPinTheme:
                                      PinThemeConst.defaultPinTheme,
                                  focusedPinTheme:
                                      PinThemeConst.focusedPinTheme,
                                  submittedPinTheme:
                                      PinThemeConst.submittedPinTheme,
                                  pinAnimationType: PinAnimationType.rotation,
                                  pinputAutovalidateMode:
                                      PinputAutovalidateMode.onSubmit,
                                  validator: (value) {
                                    if (value!.isEmpty || value.length < 4) {
                                      return 'please enter your code';
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const Center(
                              child: Text(
                                "Haven’t received a code?",
                                style: TextStyle(
                                    fontSize: 14.0,
                                    fontFamily: 'notosan',
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const CustomDivider(),
                            const SizedBox(
                              height: 20,
                            ),
                            isResendCode
                                ? Center(
                                    child: Text(
                                    _formatDuration(
                                            Duration(seconds: _secondsLeft))
                                        .toString(),
                                    style: const TextStyle(
                                        fontSize: 16,
                                        color: AppColors.yellow,
                                        fontWeight: FontWeight.w700),
                                  ))
                                : Center(
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          context
                                              .read<UserCubit>()
                                              .sendVerificationCode(
                                                  SendVerificationRequestModel(
                                                      phoneNumber: widget
                                                              .phone ??
                                                          AppSharedPreferences
                                                              .userPhoneNumber,
                                                  ));
                                          isResendCode = true;
                                        });

                                        _startTimer();
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 25, vertical: 7),
                                        clipBehavior: Clip.antiAlias,
                                        // decoration: BoxDecoration(
                                        //     color: AppSharedPreferences.getTheme == 'ThemeCubitMode.dark'
                                        //         ? AppColors.backgroundColor
                                        //         : AppColors.backgroundColorLight,

                                        decoration: ShapeDecoration(
                                          shape: RoundedRectangleBorder(
                                            side: const BorderSide(
                                                width: 0.50,
                                                color: AppColors.yellow),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                        ),
                                        child: const Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              "Resend Code",
                                              style: TextStyle(
                                                  color: AppColors.yellow,
                                                  fontFamily: "notosan"),
                                            ),
                                            SizedBox(
                                              width: 4,
                                            ),
                                            Icon(
                                              Icons.refresh,
                                              size: 20,
                                              color: AppColors.yellow,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                            const SizedBox(
                              height: 30,
                            ),
                            _buildVerifyConsumer(),
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
        }),
      ),
    );
  }

  _buildVerifyConsumer() {
    return BlocConsumer<UserCubit, UserState>(
        bloc: cubit,
        builder: (context, state) {
          if (state is RegisterLoading) {
            return const LoadingCircularWidget();
          }
          {
            return RebiButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  FocusManager.instance.primaryFocus?.unfocus();

                  _sendRegisterData(
                    email: widget.email,
                    dob: widget.dob,
                    phone: widget.phone,
                    password: widget.password,
                    confirmPassword: widget.confirmPassword,
                    gender: widget.gender,
                    nationality: widget.nationality,
                    firstName: widget.firstName,
                    middleName: widget.middleName,
                    lastName: widget.lastName,
                    verificationCode: _pinPutController.text,
                  );
                } else {}
              },
              child: const Text("Verify"),
            );
          }
        },
        listener: (context, state) {
          if (state is RegisterSuccessful) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const VerificationSubmit()));
          } else if (state is RegisterError) {
            RebiMessage.error(msg: state.message!, context: context);
          }
        });
  }

  _sendRegisterData(
      {String? email,
      String? firstName,
      String? middleName,
      String? lastName,
      String? verificationCode,
      String? phone,
      String? gender,
      String? nationality,
      String? password,
      String? confirmPassword,
      String? dob}) {
    return cubit.register(RegisterRequestModel(
      emailAddress: email,
      firstName: firstName,
      middleName: middleName,
      lastName: lastName,
      password: password,
      confirmPassword: confirmPassword,
      gender: gender,
      nationality: nationality,
      verificationCode: verificationCode,
      phoneNumber: phone,
      dob: dob,
    ));
  }
}
