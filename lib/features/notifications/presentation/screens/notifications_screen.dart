import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:proequine/features/notifications/data/booking_details_response_model.dart';
import 'package:proequine/features/notifications/presentation/widgets/notification_widget.dart';

import '../../../../core/constants/colors/app_colors.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/constants/routes/routes.dart';
import '../../../../core/utils/sharedpreferences/SharedPreferencesHelper.dart';
import '../../../../core/widgets/verify_dialog.dart';
import '../../../horses/presentation/widgets/cards_loading_widget.dart';
import '../../../manage_account/data/verify_email_route.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  NotificationsScreenState createState() => NotificationsScreenState();
}

class NotificationsScreenState extends State<NotificationsScreen> {
  List<String> statuses = [
    'Payment pending',
    'Completed',
    'Responses',
    'Payment pending',
    'Completed',
    'Responses'
  ];
  List<bool> statusesBool = [true, false, false, true, false, false];
  ScrollController _scrollController = ScrollController();
  bool isScrolled = false;
  bool isLoading = true;
  late Timer timer;


  @override
  void initState() {
    super.initState();
    checkVerificationStatus().then((verified) {
      if (!verified) {
        // If the account is not verified, show a dialog after a delay.
        Future.delayed(const Duration(milliseconds: 50), () {
          showUnverifiedAccountDialog(
            context: context,
            isThereNavigationBar: true,
            onPressVerify: () {
              Navigator.pushNamed(context, verifyEmail,
                  arguments: VerifyEmailRoute(
                      type: 'notifications',
                      email: AppSharedPreferences.userEmailAddress))
                  .then((value) {});
            },
          );
        });
      }
    });
    timer=Timer(const Duration(seconds: 5), () {
      setState(() {
        isLoading = false;
      });
    });
    _scrollController.addListener(() {
      if (_scrollController.offset > 30) {
        if (!isScrolled) {
          setState(() {
            isScrolled = true;
          });
        }
      } else {
        if (isScrolled) {
          setState(() {
            isScrolled = false;
          });
        }
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    timer.cancel();
    super.dispose();
  }

  Future<bool> checkVerificationStatus() async {
    if (AppSharedPreferences.getEmailVerified!) {
      return true;
    } else {
      await Future.delayed(
          const Duration(milliseconds: 50)); // Simulating an asynchronous call
      return false;
    }
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child:
      // isLoading
      //     ? CardLoadingWidget(
      //   title: "Inbox",
      //   isSmallCard: true,
      // )
      //     :
      MediaQuery(
        data: const MediaQueryData(
            viewInsets: EdgeInsets.only(top: 100, bottom: 0)),
        child: CupertinoPageScaffold(
          child: NestedScrollView(
            controller: _scrollController,
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                CupertinoSliverNavigationBar(
                  automaticallyImplyLeading: false,
                  border: Border(
                      bottom: BorderSide(
                          width: 1.0,

                          color: isScrolled
                              ? AppColors.borderColor
                              : Colors.transparent)),
                  alwaysShowMiddle: false,
                  padding: const EdgeInsetsDirectional.only(bottom: 1),
                  backgroundColor: AppColors.backgroundColorLight,
                  largeTitle: const Text(
                    'Inbox',
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 30),
                  ),
                  middle: const Text(
                    'Inbox',
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
                  ),
                ),
              ];
            },
            body: SingleChildScrollView(
              child: PreferredSize(
                preferredSize: const Size.fromHeight(0),
                child: Column(
                  children: [
                    ListView.builder(
                        shrinkWrap: true,
                        primary: false,
                        itemCount: 6,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: kPadding, vertical: 5),
                            child: InboxWidget(
                              status: statuses[index],
                              onTapPay: () {
                              },
                              isTherePay: statusesBool[index],
                              date: '10 min ago',
                              transportType: "Shipping",
                              bookingId: 'LT9677',
                            ),
                          );
                        }),
                    const SizedBox(
                      height: 80,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
