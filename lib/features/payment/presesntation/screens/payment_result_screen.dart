import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:proequine/core/constants/colors/app_colors.dart';
import 'package:proequine/core/constants/constants.dart';
import 'package:proequine/core/utils/extensions.dart';
import 'package:proequine/core/widgets/custom_dashed_divider_widget.dart';
import 'package:proequine/core/widgets/divider.dart';
import 'package:proequine/core/widgets/profile_help_bottom_sheet.dart';
import 'package:proequine/core/widgets/profile_two_lines_list_tile.dart';
import 'package:proequine/core/widgets/rebi_button.dart';
import 'package:proequine/core/widgets/rebi_input.dart';
import 'package:proequine/features/nav_bar/presentation/screens/bottomnavigation.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/constants/thems/app_styles.dart';
import '../../../../core/utils/validator.dart';

class PaymentResultScreen extends StatefulWidget {
  final String? status;
  final String? totalPrice;
  final String? time;
  final String? refNo;
  final String? serviceType;

  const PaymentResultScreen(
      {Key? key,
      this.status,
      this.totalPrice,
      this.time,
      this.refNo,
      this.serviceType})
      : super(key: key);

  @override
  State<PaymentResultScreen> createState() => _PaymentResultScreenState();
}

class _PaymentResultScreenState extends State<PaymentResultScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller;

  final TextEditingController descriptionIssue = TextEditingController();

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Spacer(
              flex: 1,
            ),
            Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 35.0.w, vertical: 10),
                child: widget.status == 'Payment Successful'
                    ? Lottie.asset(
                        'assets/animation/check-Animation.json',
                        controller: _controller,
                        onLoaded: (composition) {
                          _controller
                            ..duration = composition.duration
                            ..forward();
                        },
                      )
                    : Lottie.asset(
                        'assets/animation/animation_error.json',
                        controller: _controller,
                        onLoaded: (composition) {
                          _controller
                            ..duration = composition.duration
                            ..forward();
                        },
                      ),
              ),
            ),
            Center(
              child: Text(
                '${widget.status!} !',
                style: const TextStyle(
                    color: AppColors.blackLight,
                    fontWeight: FontWeight.w400,
                    fontSize: 18),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Center(
              child: Text(
                '${widget.totalPrice} AED',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: AppColors.blackLight,
                  fontSize: 24,
                  fontFamily: 'notosan',
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const CustomDivider(),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Payment Details",
              style: AppStyles.profileBlackTitles,
              textAlign: TextAlign.start,
            ),
            Row(
              children: [
                const Text(
                  'Reference No. ',
                  style: TextStyle(
                    color: AppColors.formsHintFontLight,
                    fontSize: 14,
                    fontFamily: 'notosan',
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const Spacer(),
                Text(
                  widget.refNo!,
                  style: const TextStyle(
                    color: AppColors.blackLight,
                    fontSize: 14,
                    fontFamily: 'notosan',
                    fontWeight: FontWeight.w400,
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                const Text(
                  'Payment Status ',
                  style: TextStyle(
                    color: AppColors.formsHintFontLight,
                    fontSize: 14,
                    fontFamily: 'notosan',
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const Spacer(),
                Text(
                  widget.status!,
                  style: const TextStyle(
                    color: AppColors.blackLight,
                    fontSize: 14,
                    fontFamily: 'notosan',
                    fontWeight: FontWeight.w400,
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                const Text(
                  'Payment Time ',
                  style: TextStyle(
                    color: AppColors.formsHintFontLight,
                    fontSize: 14,
                    fontFamily: 'notosan',
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const Spacer(),
                Text(
                  widget.time!,
                  style: const TextStyle(
                    color: AppColors.blackLight,
                    fontSize: 14,
                    fontFamily: 'notosan',
                    fontWeight: FontWeight.w400,
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const CustomDashedDivider(),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                const Text(
                  'Total ',
                  style: TextStyle(
                    color: AppColors.blackLight,
                    fontSize: 14,
                    fontFamily: 'notosan',
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const Spacer(),
                Text(
                  '${widget.totalPrice!} AED',
                  style: const TextStyle(
                    color: AppColors.blackLight,
                    fontSize: 14,
                    fontFamily: 'notosan',
                    fontWeight: FontWeight.w700,
                  ),
                )
              ],
            ),
            widget.status == 'Payment Successful'
                ? Expanded(
                    flex: 4,
                    child: Column(
                      children: [
                        const Spacer(
                          flex: 4,
                        ),
                        RebiButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const BottomNavigation(
                                            selectedIndex: 1,
                                          )));
                            },
                            child: const Text("Bookings"))
                      ],
                    ),
                  )
                : Expanded(
                    flex: 4,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 30,
                        ),
                        ProfileTwoLineListTile(
                          onTap: () {
                            showProfileHelpBottomSheet(
                                context: context,
                                title: "ContactSupport",
                                content: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 10,
                                    ),
                                    const Text(
                                      "Payment Concerns? We're Here for You",
                                      style: AppStyles.profileBlackTitles,
                                      textAlign: TextAlign.start,
                                    ),
                                    SizedBox(
                                      height: 14,
                                    ),
                                    Row(
                                      children: [
                                        const Text(
                                          'Service type ',
                                          style: TextStyle(
                                            color: AppColors.blackLight,
                                            fontSize: 14,
                                            fontFamily: 'notosan',
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 50,
                                        ),
                                        Text(
                                          widget.serviceType!,
                                          style: const TextStyle(
                                            color: AppColors.formsHintFontLight,
                                            fontSize: 14,
                                            fontFamily: 'notosan',
                                            fontWeight: FontWeight.w700,
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 14,
                                    ),
                                    Row(
                                      children: [
                                        const Text(
                                          'Reference No. ',
                                          style: TextStyle(
                                            color: AppColors.blackLight,
                                            fontSize: 14,
                                            fontFamily: 'notosan',
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 50,
                                        ),
                                        Text(
                                          widget.refNo!,
                                          style: const TextStyle(
                                            color: AppColors.formsHintFontLight,
                                            fontSize: 14,
                                            fontFamily: 'notosan',
                                            fontWeight: FontWeight.w700,
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 14,
                                    ),
                                    RebiInput(
                                      hintText: 'How we can Help you'.tra,
                                      controller: descriptionIssue,
                                      keyboardType: TextInputType.multiline,
                                      maxLines: 5,
                                      textInputAction: TextInputAction.done,
                                      autoValidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      isOptional: false,
                                      readOnly: false,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 13),
                                      obscureText: false,
                                      validator: (value) {
                                        return Validator.requiredValidator(
                                            descriptionIssue.text);
                                      },
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    RebiButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text("Send")),
                                  ],
                                ));
                          },
                          title: "Trouble with your payment",
                          subTitle: 'Get Help with Payment Issues',
                        ),
                        const Spacer(
                          flex: 3,
                        ),
                        RebiButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const BottomNavigation()));
                          },
                          isBackButton: true,
                          child: const Text(
                            "Home",
                            style: TextStyle(color: AppColors.yellow),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        RebiButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text("Try again"))
                      ],
                    ),
                  ),
            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}
