import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:proequine/features/profile/presentation/screens/user_profile.dart';
import 'package:sizer/sizer.dart';

import '../constants/colors/app_colors.dart';

class SuccessStateScreen extends StatefulWidget {
  String? title;

  SuccessStateScreen({Key? key, this.title}) : super(key: key);

  @override
  State<SuccessStateScreen> createState() => _SuccessStateScreenState();
}

class _SuccessStateScreenState extends State<SuccessStateScreen>
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
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.0.w, vertical: 10),
            child: Lottie.asset(
              'assets/animation/check-Animation.json',
              controller: _controller,
              onLoaded: (composition) {
                // Configure the AnimationController with the duration of the
                // Lottie file and start the animation.
                _controller
                  ..duration = composition.duration
                  ..forward().whenComplete(() => Navigator.pop(context));
              },
            ),
          ),
          Center(
            child: Text(
              widget.title!,
              style: const TextStyle(
                  color: AppColors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 20),
            ),
          )
        ],
      ),
    );
  }
}
