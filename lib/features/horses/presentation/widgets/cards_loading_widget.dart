import 'package:fade_shimmer/fade_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/constants/colors/app_colors.dart';
import '../../../../core/constants/constants.dart';

class CardLoadingWidget extends StatefulWidget {
  bool isSmallCard=false;
  final String title;

  CardLoadingWidget({Key? key,this.isSmallCard=false, required this.title,}) : super(key: key);

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
    return SafeArea(
      child: Scaffold(
        body: ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
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
                     Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: kPadding, vertical: 10),
                      child: Text(
                        widget.title,
                        style: const TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 30,letterSpacing: 1),
                      ),
                    ),
                    ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: 6,
                        itemBuilder: (context, index) {
                          return  Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: kPadding, vertical: 10),
                            child: FadeShimmer(
                              baseColor: AppColors.shimmerColors,
                              highlightColor: AppColors.shimmerColor2,
                              height: widget.isSmallCard?100:200,
                              width: double.infinity,
                              radius: 8,
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
