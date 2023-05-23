import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:proequine/core/widgets/rebi_button.dart';
import 'package:proequine/features/profile/data/verify_email_route.dart';
import 'package:proequine/features/profile/domain/profile_cubit.dart';
import 'package:sizer/sizer.dart';

import '../constants/colors/app_colors.dart';
import '../constants/constants.dart';
import '../utils/sharedpreferences/SharedPreferencesHelper.dart';

class SubmitVerifyEmail extends StatefulWidget {
  String? title;
  bool isThereButton = false;
  Function? onButtonPressed;
  String? buttonText;

  SubmitVerifyEmail(
      {Key? key,
        this.title,
        this.isThereButton = false,
        this.onButtonPressed,
        this.buttonText})
      : super(key: key);

  @override
  State<SubmitVerifyEmail> createState() => _SubmitVerifyEmailState();
}

class _SubmitVerifyEmailState extends State<SubmitVerifyEmail>
    with TickerProviderStateMixin {
  late final AnimationController _controller;
  ProfileCubit cubit = ProfileCubit();
  VerifyEmailRoute verifyEmailRoute=VerifyEmailRoute();

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
     verifyEmailRoute = ModalRoute.of(context)?.settings.arguments as VerifyEmailRoute;
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
                  if (widget.isThereButton) {
                    _controller
                      ..duration = composition.duration
                      ..forward();
                  } else {
                    //Todo: handle navigate from navbar pages
                    if(verifyEmailRoute.type=='Booking'){
                      _controller
                        ..duration = composition.duration
                        ..forward().whenComplete(() =>
                            Navigator.popAndPushNamed(context, '/homeRouteBooking'));
                    }else if (verifyEmailRoute.type=='notifications'){
                      _controller
                        ..duration = composition.duration
                        ..forward().whenComplete(() =>
                            Navigator.popAndPushNamed(context, '/homeRouteNotifications'));
                    }
                    else if (verifyEmailRoute.type=='createTrip'){
                      _controller
                        ..duration = composition.duration
                        ..forward().whenComplete(() =>
                            Navigator.popAndPushNamed(context, '/createTrip'));
                    }
                    else if (verifyEmailRoute.type=='createEvent'){
                      _controller
                        ..duration = composition.duration
                        ..forward().whenComplete(() =>
                            Navigator.popAndPushNamed(context, '/createEvent'));
                    }
                    else if (verifyEmailRoute.type=='updateEmail'){
                      _controller
                        ..duration = composition.duration
                        ..forward().whenComplete(() =>
                            Navigator.popAndPushNamed(context, '/accountInformation'));
                    }

                  }
                },
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0.w),
              child: Text(
                verifyEmailRoute.email!,
                style: const TextStyle(
                    color: AppColors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 20),
              ),
            ),
          ),
          const Spacer(
            flex: 2,
          ),
          widget.isThereButton
              ? Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: kPadding, vertical: 10),
              child: RebiButton(
                  onPressed: () {
                    widget.onButtonPressed!();
                  },
                  child: Text(widget.buttonText!)))
              : const SizedBox(
            height: 2,
          ),
          const SizedBox(
            height: 40,
          ),
        ],
      ),
    );
  }
}
