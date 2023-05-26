import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:proequine/features/user/presentation/screens/interests_screen.dart';
import 'package:sizer/sizer.dart';

import '../constants/colors/app_colors.dart';

class VerificationSubmit extends StatefulWidget {
  const VerificationSubmit({Key? key}) : super(key: key);

  @override
  State<VerificationSubmit> createState() => _VerificationSubmitState();
}

class _VerificationSubmitState extends State<VerificationSubmit>
    with TickerProviderStateMixin {
  late final AnimationController _controller;

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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Spacer(
            flex: 2,
          ),
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.0.w, vertical: 10),
              child: Lottie.asset(
                'assets/animation/check-Animation.json',
                controller: _controller,
                onLoaded: (composition) {
                  // Configure the AnimationController with the duration of the
                  // Lottie file and start the animation.
                  _controller
                    ..duration = composition.duration
                    ..forward().whenComplete(() => Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const InterestsScreen())));
                },
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: const Text(
                "Your phone has been verified successfully",
                textAlign: TextAlign.center,
                style:  TextStyle(
                    color: AppColors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 20),
              ),
            ),
          ),
          const Spacer(
            flex: 2,
          ),
          const SizedBox(
            height: 40,
          ),
        ],
      ),
    );
  }
}
