import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:proequine/core/constants/routes/routes.dart';
import 'package:proequine/core/widgets/rebi_button.dart';
import 'package:sizer/sizer.dart';

import '../../features/manage_account/data/verify_email_route.dart';
import '../constants/colors/app_colors.dart';
import '../constants/constants.dart';
import '../constants/thems/app_styles.dart';

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
                'assets/animation/Success.json',
                controller: _controller,
                onLoaded: (composition) {
                  // Configure the AnimationController with the duration of the
                  // Lottie file and start the animation.
                  if (widget.isThereButton) {
                    _controller
                      ..duration = composition.duration
                      ..forward();
                  } else {
                    if(verifyEmailRoute.type=='Booking'){
                      _controller
                        ..duration = composition.duration
                        ..forward().whenComplete(() =>
                            Navigator.popAndPushNamed(context, bookingRoute));
                    }else if (verifyEmailRoute.type=='notifications'){
                      _controller
                        ..duration = composition.duration
                        ..forward().whenComplete(() =>
                            Navigator.popAndPushNamed(context, inboxRoute));
                    }
                    else if (verifyEmailRoute.type=='Horses'){
                      _controller
                        ..duration = composition.duration
                        ..forward().whenComplete(() =>
                            Navigator.popAndPushNamed(context, horses));
                    }
                    else if (verifyEmailRoute.type=='createTrip'){
                      _controller
                        ..duration = composition.duration
                        ..forward().whenComplete(() =>
                            Navigator.popAndPushNamed(context, createTrip,arguments: true));
                    }
                    else if (verifyEmailRoute.type=='createEvent'){
                      _controller
                        ..duration = composition.duration
                        ..forward().whenComplete(() =>
                            Navigator.popAndPushNamed(context, createEvent,arguments: true));
                    }
                    else if (verifyEmailRoute.type=='createMedia'){
                      _controller
                        ..duration = composition.duration
                        ..forward().whenComplete(() =>
                            Navigator.popAndPushNamed(context, createEvent,arguments: true));
                    }
                    else if (verifyEmailRoute.type=='import'){
                      _controller
                        ..duration = composition.duration
                        ..forward().whenComplete(() =>
                            Navigator.popAndPushNamed(context, import,arguments: true));
                    }
                    else if (verifyEmailRoute.type=='export'){
                      _controller
                        ..duration = composition.duration
                        ..forward().whenComplete(() =>
                            Navigator.popAndPushNamed(context, export,arguments: true));
                    }
                    else if (verifyEmailRoute.type=='updateEmail'){
                      _controller
                        ..duration = composition.duration
                        ..forward().whenComplete(() =>
                            Navigator.popAndPushNamed(context, accountInfo,arguments: true));
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

                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: AppColors.blackLight,
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
                  child: Text(widget.buttonText!, style: AppStyles.buttonStyle,)))
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
