import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:proequine/features/user/presentation/screens/interests_screen.dart';
import 'package:sizer/sizer.dart';
import 'dart:ui' as ui;

import '../../../../core/constants/colors/app_colors.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/constants/images/app_images.dart';
import '../../../../core/constants/thems/app_styles.dart';
import '../../../../core/constants/thems/pin_put_theme.dart';
import '../../../../core/utils/Printer.dart';
import '../../../../core/widgets/rebi_button.dart';
import '../../../nav_bar/presentation/screens/bottomnavigation.dart';
import '../widgets/register_header.dart';

class VerificationScreen extends StatefulWidget {
  final String? email;

  VerificationScreen({super.key, this.email});

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
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                RegistrationHeader(isThereBackButton: true),
                Transform.translate(
                    offset: const Offset(0.0, -35.0),
                    child: SizedBox(
                      // padding: const EdgeInsets.symmetric(vertical: kPadding),
                      height: 25.h,
                      child: Image.asset(
                        AppImages.logo,
                        scale: 1,
                      ),
                    )),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: kPadding),
                  child: Transform.translate(
                    offset: const Offset(0.0, -35.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Confirm your number",
                            style: AppStyles.registrationTitle),
                        SizedBox(
                          height: 1.h,
                        ),
                        Text(
                          "A 6 digit verification code has been sent to your registered phone number.",
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
                              submittedPinTheme:
                                  PinThemeConst.submittedPinTheme,
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
                            : Padding(
                                padding:
                                    EdgeInsets.symmetric(horizontal: 25.0.w),
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      isResendCode = true;
                                    });

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
                                            color: Colors.white,
                                            spreadRadius: 1),
                                      ],
                                    ),
                                    child: Center(
                                      child: Row(
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
                              ),
                        const SizedBox(
                          height: 30,
                        ),
                        RebiButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const InterestsScreen()));
                            } else {}
                          },
                          backgroundColor: AppColors.white,
                          child: const Text("Sign up"),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
