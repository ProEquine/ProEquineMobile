import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:proequine/core/constants/colors/app_colors.dart';
import 'package:proequine/core/constants/constants.dart';
import 'package:proequine/core/utils/extensions.dart';
import 'package:proequine/core/widgets/custom_dashed_divider_widget.dart';
import 'package:proequine/core/widgets/divider.dart';
import 'package:proequine/core/widgets/global_bottom_sheet.dart';
import 'package:proequine/core/widgets/profile_two_lines_list_tile.dart';
import 'package:proequine/core/widgets/rebi_button.dart';
import 'package:proequine/core/widgets/rebi_input.dart';
import 'package:proequine/features/nav_bar/presentation/screens/bottomnavigation.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/constants/thems/app_styles.dart';
import '../../../../core/utils/validator.dart';
import '../../../../core/widgets/custom_header.dart';

class TestApplePayResult extends StatefulWidget {
  final String? status;


  const TestApplePayResult(
      {Key? key,
        this.status,})
      : super(key: key);

  @override
  State<TestApplePayResult> createState() => _TestApplePayResultState();
}

class _TestApplePayResultState extends State<TestApplePayResult>
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
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(20.0.h),
        child: CustomHeader(
          title: "Test Apple Pay Result",
          isThereBackButton: true,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(widget.status!,

            )
          ],
        ),
      ),
    );
  }
}
