import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinput/pinput.dart';
import 'package:proequine/core/constants/routes/routes.dart';
import 'package:proequine/core/utils/sharedpreferences/SharedPreferencesHelper.dart';
import 'package:proequine/features/profile/data/verify_email_route.dart';
import 'package:proequine/features/user/data/check_mail_request_model.dart';
import 'package:proequine/features/user/data/send-mail_request_model.dart';
import 'package:proequine/features/user/domain/user_cubit.dart';
import 'package:sizer/sizer.dart';
import 'dart:ui' as ui;

import '../../../../core/constants/colors/app_colors.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/constants/thems/app_styles.dart';
import '../../../../core/constants/thems/pin_put_theme.dart';
import '../../../../core/utils/rebi_message.dart';
import '../../../../core/widgets/custom_header.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../../../core/widgets/rebi_button.dart';

class VerifyEmailScreen extends StatefulWidget {
  final String? email;


  const VerifyEmailScreen({super.key, this.email});

  @override
  State<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  UserCubit cubit = UserCubit();

  final TextEditingController _pinPutController = TextEditingController();
  int _secondsLeft = 60;
  bool isResendCode = false;
  late Timer _timer;
  onSendMail() {
    return cubit.sendMailVerificationCode(SendMailVerificationRequestModel(
      email: AppSharedPreferences.userEmailAddress,
    ));
  }

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

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String minutes = twoDigits(duration.inMinutes.remainder(60));
    String seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$minutes:$seconds";
  }
VerifyEmailRoute verifyEmailRoute=VerifyEmailRoute();
  @override
  void initState() {
    onSendMail();
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
    verifyEmailRoute = ModalRoute.of(context)?.settings.arguments as VerifyEmailRoute;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(20.0.h),
        child: CustomHeader(
          title: "Confirm your Email",
          isThereBackButton: true,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: kPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20,),
                      Text(
                        "A 6 digit verification code has been sent to your registered email.",
                        style: AppStyles.descriptions,
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Center(
                        child: Directionality(
                          textDirection: ui.TextDirection.ltr,
                          child: Pinput(
                            preFilledWidget: Container(
                              width: 30,
                              height: 20,
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              decoration: const BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                      width: 2.0, color: AppColors.white),
                                ),
                                color: AppColors.formsBackground,
                              ),
                            ),
                            androidSmsAutofillMethod:
                                AndroidSmsAutofillMethod.smsUserConsentApi,
                            length: 6,
                            closeKeyboardWhenCompleted: true,
                            isCursorAnimationEnabled: true,
                            controller: _pinPutController,
                            defaultPinTheme: PinThemeConst.defaultPinTheme,
                            focusedPinTheme: PinThemeConst.focusedPinTheme,
                            submittedPinTheme: PinThemeConst.submittedPinTheme,
                            pinAnimationType: PinAnimationType.rotation,
                            pinputAutovalidateMode:
                                PinputAutovalidateMode.onSubmit,
                            validator: (value) {
                              if (value!.isEmpty || value.length < 6) {
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
                              color: AppColors.white,
                              fontSize: 14.0,
                              fontFamily: 'notosan',
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Divider(
                        height: 10,
                        thickness: 3,
                        color: Color(0XFF36393D),
                        endIndent: 30.0,
                        indent: 30.0,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      isResendCode
                          ? Center(
                              child: Text(
                              _formatDuration(Duration(seconds: _secondsLeft))
                                  .toString(),
                              style: const TextStyle(
                                  color: AppColors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700),
                            ))
                          : Center(
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    isResendCode = true;
                                  });
                                  context
                                      .read<UserCubit>()
                                      .sendMailVerificationCode(
                                          SendMailVerificationRequestModel(
                                              email: verifyEmailRoute.email));

                                  _startTimer();
                                  // Navigator.push(context,
                                  //     MaterialPageRoute(builder: (context) => LoginScreen()));
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 25, vertical: 7),
                                  decoration: BoxDecoration(
                                    color: const Color(0xff161616),
                                    borderRadius: BorderRadius.circular(8.0),
                                    boxShadow: const [
                                      BoxShadow(
                                          color: Colors.white, spreadRadius: 1),
                                    ],
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: const [
                                      Text(
                                        "Resend Code",
                                        style: TextStyle(
                                            color: AppColors.white,
                                            fontFamily: "notosan"),
                                      ),
                                      SizedBox(
                                        width: 4,
                                      ),
                                      Icon(
                                        Icons.refresh,
                                        color: AppColors.white,
                                        size: 20,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                      const SizedBox(
                        height: 30,
                      ),
                      BlocConsumer<UserCubit, UserState>(
                        bloc: cubit,
                        listener: (context, state) {
                          if (state is CheckMailVerificationSuccessful) {
                     Navigator.pushReplacementNamed(context, submitVerifyEmail,arguments: VerifyEmailRoute(email: "Email verified successfully",type: verifyEmailRoute.type));
                          } else if (state is CheckMailVerificationError) {
                            RebiMessage.error(msg: state.message!,context: context);
                          }
                        },
                        builder: (context, state) {
                          if (state is CheckMailVerificationLoading) {
                            return LoadingCircularWidget();
                          }
                          return RebiButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                FocusManager.instance.primaryFocus?.unfocus();
                                _onPressVerify(verifyEmailRoute.email!);
                              } else {}
                            },
                            backgroundColor: AppColors.white,
                            child: const Text("Confirm"),
                          );
                        },
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
  }
  _onPressVerify(String email) {
    return cubit.checkMailVerificationCode(CheckMailVerificationRequestModel(
        email: email,
        code: _pinPutController.text));
  }
}
