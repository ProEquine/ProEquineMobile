import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:proequine/core/utils/extensions.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/constants/colors/app_colors.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'custom_header.dart';

class PrivacyAndMarketingCheckBox extends StatelessWidget {
  final Key? key;
  final bool? value;
  final Function(bool? val)? onChanged;
  final bool? isTherePrivacy;
  final Function? onTap;

  const PrivacyAndMarketingCheckBox({
    this.onTap,
    this.value,
    this.isTherePrivacy = false,
    this.key,
    this.onChanged,
  }) : super(key: key);

  final String privacyUrl = 'https://findyourteam.io/privacy-policy.html';

  void pressPrivacy2() async {
    if (!await launchUrl(
      Uri.parse(privacyUrl),
      mode: LaunchMode.inAppWebView,
    )) {
      throw 'Could not launch $privacyUrl';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Theme(
          data: Theme.of(context).copyWith(
            unselectedWidgetColor: AppColors.formsBackground,
            primaryColor: AppColors.formsBackground,
          ),
          child: Transform.scale(
            scale: 1.2,
            child: Checkbox(
              key: key,
              checkColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              activeColor: AppColors.gold,
              value: value,
              onChanged: (bool? val) {
                onChanged!(val);
              },
            ),
          ),
        ),
        isTherePrivacy!
            ? RichText(
                text: TextSpan(
                  text: 'Agree with '.tra,
                  style: TextStyle(
                    fontSize: 12.5.sp,
                    fontFamily: 'nonotosan',
                    fontWeight: FontWeight.w400,
                    color: AppColors.white,
                  ),
                  children: [
                    TextSpan(
                      text: 'privacy policy & terms of use'.tra,
                      style: TextStyle(
                        fontSize: 12.0.sp,
                        fontFamily: 'nonotosan',
                        fontWeight: FontWeight.w400,
                        decoration: TextDecoration.underline,
                        color: AppColors.gold,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  TermsAndConditionsPage(url: privacyUrl),
                            ),
                          );
                          // pressPrivacy2();
                        },
                    )
                  ],
                ),
              )
            : RichText(
                text: TextSpan(
                  text: 'I accept receiving marketing emails'.tra,
                  style: TextStyle(
                    fontSize: 12.5.sp,
                    color: AppColors.white,
                  ),
                ),
              ),
      ],
    );
  }
}

class TermsAndConditionsPage extends StatefulWidget {
  const TermsAndConditionsPage({Key? key, required this.url}) : super(key: key);

  final String url;

  @override
  State<TermsAndConditionsPage> createState() => _TermsAndConditionsPageState();
}

class _TermsAndConditionsPageState extends State<TermsAndConditionsPage> {
  @override
  void initState() {
    super.initState();
    // Enable virtual display.
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  PreferredSize(
        preferredSize: Size.fromHeight(10.0.h),
        child: CustomHeader(title: 'Terms&Conditions'.tra),
      ),
      body: Column(
        children: [
          Expanded(
            child: WebView(
              initialUrl: widget.url,
            ),
          ),
        ],
      ),
    );
  }
}
