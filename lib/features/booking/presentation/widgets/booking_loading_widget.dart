import 'package:flutter/material.dart';
import 'package:proequine/core/widgets/shimmer.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/constants/colors/app_colors.dart';
import '../../../../core/constants/constants.dart';

class BookingLoadingWidget extends StatefulWidget {
  BookingLoadingWidget({Key? key}) : super(key: key);

  @override
  State<BookingLoadingWidget> createState() => _BookingLoadingWidgetState();
}

class _BookingLoadingWidgetState extends State<BookingLoadingWidget> {
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
    //                 const Padding(
    //                   padding:  EdgeInsets.symmetric(
    //                       horizontal: kPadding, vertical: 10),
    //                   child: Text(
    //                     'Services',
    //                     style: TextStyle(
    //                         fontWeight: FontWeight.w700, fontSize: 30,letterSpacing: 1),
    //                   ),
    //                 ),
    //                 const SizedBox(height: 20,),
    //                 Padding(padding: const EdgeInsets.symmetric(horizontal: 20),
    //                 child:Row(
    //                   children:  [
    //                     FadeShimmer(width: 75, height: 10,radius: 20,baseColor: AppColors.shimmerColors,
    //                       highlightColor: AppColors.shimmerColor2,),
    //                      SizedBox(width: 50,),
    //                     FadeShimmer(width: 75, height: 10,radius: 20,baseColor: AppColors.shimmerColors,
    //                       highlightColor: AppColors.shimmerColor2,),
    //                      SizedBox(width: 50,),
    //                     FadeShimmer(width: 75, height: 10,radius: 20,baseColor: AppColors.shimmerColors,
    //                       highlightColor: AppColors.shimmerColor2,),
    //
    //                   ],
    //                 ) ,),
    //                 ListView.builder(
    //                     shrinkWrap: true,
    //                     physics: const NeverScrollableScrollPhysics(),
    //                     itemCount: 6,
    //                     itemBuilder: (context, index) {
    //                       return   Padding(
    //                         padding:  const EdgeInsets.symmetric(
    //                             horizontal: kPadding, vertical: 10),
    //                         child: FadeShimmer(
    //                           baseColor: AppColors.shimmerColors,
    //                           highlightColor: AppColors.shimmerColor2,
    //                           height: 100,
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
      child: Scaffold(
        body: Shimmer(
          child: ScrollConfiguration(
            behavior:
                ScrollConfiguration.of(context).copyWith(scrollbars: false),
            child: SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: SizedBox(
                height: 300.0.h,
                child: Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 18,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: kPadding, vertical: 10),
                        child: Text(
                          'Services',
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 30,
                              letterSpacing: 1),
                        ),
                      ),
                      const SizedBox(
                        height: 22,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            ShimmerLoading(
                              isLoading: true,
                              child: Container(
                                width: 85,
                                height: 8,
                                decoration: BoxDecoration(
                                  color: AppColors.borderColor,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 30,
                            ),
                            ShimmerLoading(
                              isLoading: true,
                              child: Container(
                                width: 85,
                                height: 8,
                                decoration: BoxDecoration(
                                  color: AppColors.borderColor,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 30,
                            ),
                            ShimmerLoading(
                              isLoading: true,
                              child: Container(
                                width: 85,
                                height: 8,
                                decoration: BoxDecoration(
                                  color: AppColors.borderColor,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20,),
                      ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: 6,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: kPadding, vertical: 10),
                              child: ShimmerLoading(
                                isLoading: true,
                                child: Container(
                                  height: 96,

                                  decoration: BoxDecoration(
                                    color:AppColors.borderColor,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
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
    );
  }
}
