import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:proequine/core/constants/images/app_images.dart';
import 'package:proequine/core/widgets/shimmer.dart';

import '../../../../core/constants/colors/app_colors.dart';
import '../../../../core/constants/constants.dart';
import '../../../booking/presentation/widgets/booking_item_widget.dart';
import '../../../notifications/presentation/widgets/notification_widget.dart';
import 'horse_card-widget.dart';

class CardLoadingWidget extends StatefulWidget {
  bool isSmallCard = false;
  final String title;

  CardLoadingWidget({
    Key? key,
    this.isSmallCard = false,
    required this.title,
  }) : super(key: key);

  @override
  State<CardLoadingWidget> createState() => _CardLoadingWidgetState();
}

class _CardLoadingWidgetState extends State<CardLoadingWidget> {
  ScrollController _scrollController = ScrollController();
  bool isScrolled = false;

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // return SafeArea(
    //   child: Scaffold(
    //     body: ScrollConfiguration(
    //       behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
    //       child: SingleChildScrollView(
    //         physics: const NeverScrollableScrollPhysics(),
    //         child: SizedBox(
    //           height: 300.0.h,
    //           child: Padding(
    //             padding: const EdgeInsets.only(top: 10.0),
    //             child: Column(
    //               crossAxisAlignment: CrossAxisAlignment.start,
    //               children: [
    //                 const SizedBox(
    //                   height: 18,
    //                 ),
    //                  Padding(
    //                   padding: const EdgeInsets.symmetric(
    //                       horizontal: kPadding, vertical: 10),
    //                   child: Text(
    //                     widget.title,
    //                     style: const TextStyle(
    //                         fontWeight: FontWeight.w700, fontSize: 30,letterSpacing: 1),
    //                   ),
    //                 ),
    //                 ListView.builder(
    //                     shrinkWrap: true,
    //                     physics: const NeverScrollableScrollPhysics(),
    //                     itemCount: 6,
    //                     itemBuilder: (context, index) {
    //                       return  Padding(
    //                         padding: const EdgeInsets.symmetric(
    //                             horizontal: kPadding, vertical: 10),
    //                         child: FadeShimmer(
    //                           baseColor: AppColors.shimmerColors,
    //                           highlightColor: AppColors.shimmerColor2,
    //                           height: widget.isSmallCard?100:200,
    //                           width: double.infinity,
    //                           radius: 8,
    //                         ),
    //                       );
    //                     }),
    //                 const SizedBox(
    //                   height: 80,
    //                 ),
    //               ],
    //             ),
    //           ),
    //         ),
    //       ),
    //     ),
    //   ),
    // );
    return SafeArea(
      child: MediaQuery(
        data: const MediaQueryData(
            viewInsets: EdgeInsets.only(top: 100, bottom: 0)),
        child: CupertinoPageScaffold(
          child: NestedScrollView(
            controller: _scrollController,
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                widget.isSmallCard
                    ? CupertinoSliverNavigationBar(
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
                          style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 30),
                        ),
                        middle: const Text(
                          'Inbox',
                          style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 18),
                        ),
                      )
                    : CupertinoSliverNavigationBar(
                        automaticallyImplyLeading: false,
                        border: Border(
                            bottom: BorderSide(
                                width: 1.0,
                                color: isScrolled
                                    ? AppColors.borderColor
                                    : Colors.transparent)),
                        trailing: TextButton(
                          onPressed: () {
                          },
                          child: const Text(
                            "Add Horse",
                            style: TextStyle(
                              color: Color(0xFFC48636),
                              fontSize: 14,
                              fontFamily: 'notosans',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        alwaysShowMiddle: false,
                        padding: const EdgeInsetsDirectional.only(bottom: 1),
                        backgroundColor: AppColors.backgroundColorLight,
                        largeTitle: const Text(
                          'Horses',
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 30,
                              fontFamily: 'notosan'),
                        ),
                        middle: const Text(
                          'Horses',
                          style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 18),
                        ),
                      ),
              ];
            },
            body: Shimmer(
              child: ScrollConfiguration(
                behavior:
                    ScrollConfiguration.of(context).copyWith(scrollbars: false),
                child: SingleChildScrollView(
                  child: PreferredSize(
                    preferredSize: const Size.fromHeight(0),
                    child: Column(
                      children: [
                        widget.isSmallCard?SizedBox():SizedBox(height: 7,),
                        ListView.builder(
                            shrinkWrap: true,
                            primary: false,
                            itemCount: 6,
                            itemBuilder: (context, index) {
                              return widget.isSmallCard
                                  ? Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: kPadding, vertical: 5),
                                      child: ShimmerLoading(
                                        isLoading: true,
                                        child: InboxWidget(
                                          status: 'statuses[index]',
                                          onTapPay: () {},
                                          isTherePay: false,
                                          date: '10 min ago',
                                          transportType: "Shipping",
                                          bookingId: 'LT9677',
                                        ),
                                      ),
                                    )
                                  : Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: kPadding, vertical: 10),
                                      child: ShimmerLoading(
                                        isLoading: true,
                                        child: HorseCardWidget(
                                          age: 'ages[index]',
                                          gender: 'Mare',
                                          breed: "Selle",
                                          isLoading: true,
                                          placeOfBirth: "Français",
                                          horseName: 'names[index]',
                                          discipline: "Show jumping",
                                          horsePic: AppImages.stormy,
                                          isVerified: false,
                                          horseStable: "Malath",
                                          horseStatus: 'status[index]',
                                        ),
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
        ),
      ),
    );
  }
}
