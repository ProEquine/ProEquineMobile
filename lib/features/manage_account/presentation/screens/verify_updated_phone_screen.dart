import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinput/pinput.dart';
import 'package:proequine/core/constants/routes/routes.dart';
import 'package:proequine/core/utils/rebi_message.dart';
import 'package:proequine/core/utils/sharedpreferences/SharedPreferencesHelper.dart';
import 'package:proequine/core/widgets/loading_widget.dart';
import 'package:proequine/features/manage_account/domain/manage_account_cubit.dart';
import 'package:sizer/sizer.dart';
import 'dart:ui' as ui;

import '../../../../core/constants/colors/app_colors.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/constants/thems/app_styles.dart';
import '../../../../core/constants/thems/pin_put_theme.dart';
import '../../../../core/widgets/custom_header.dart';
import '../../../../core/widgets/rebi_button.dart';
import '../../data/update_phone_request_model.dart';
import '../../data/verify_phone_route.dart';

class VerifyUpdatedPhoneScreen extends StatefulWidget {
  const VerifyUpdatedPhoneScreen({
    super.key,
  });

  @override
  State<VerifyUpdatedPhoneScreen> createState() =>
      _VerifyUpdatedPhoneScreenState();
}

class _VerifyUpdatedPhoneScreenState extends State<VerifyUpdatedPhoneScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  ManageAccountCubit cubit = ManageAccountCubit();

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

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String minutes = twoDigits(duration.inMinutes.remainder(60));
    String seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$minutes:$seconds";
  }
  @override
  void dispose() {
   cubit.close();
   _pinPutController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final String phone = ModalRoute.of(context)?.settings.arguments as String;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(20.0.h),
        child: CustomHeader(
          title: "Confirm your number",
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
                        color: AppColors.borderColor,
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
                      BlocConsumer<ManageAccountCubit, ManageAccountState>(
                        bloc: cubit,
                        listener: (context, state) {
                          if (state is UpdatePhoneSuccessful) {
                            AppSharedPreferences.inputPhoneNumber = phone;
                            Navigator.pushReplacementNamed(
                                context, successScreen,
                                arguments: VerifyPhoneRoute(
                                    type: 'accountInfo',
                                    title: "Phone Updated Successfully"));
                          } else if (state is UpdatePhoneError) {
                            RebiMessage.error(msg: state.message!,context: context);
                          }
                        },
                        builder: (context, state) {
                          if (state is UpdatePhoneLoading) {
                            return const LoadingCircularWidget();
                          }
                          return RebiButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                FocusManager.instance.primaryFocus?.unfocus();
                                onPressVerify(phone);
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

  onPressVerify(String phone) {
    return cubit
      ..updatePhoneNumber(UpdatePhoneRequestModel(
        previousPhoneNumber: AppSharedPreferences.userPhoneNumber,
        newPhoneNumber: phone,
        code: _pinPutController.text,
      ));
  }
}
