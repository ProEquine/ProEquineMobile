import 'package:flutter/material.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/constants/images/app_images.dart';
import '../../../../core/widgets/shimmer.dart';
import 'horse_card-widget.dart';

class MainHorsesLoadingWidget extends StatefulWidget {
  const MainHorsesLoadingWidget({Key? key}) : super(key: key);

  @override
  State<MainHorsesLoadingWidget> createState() => _MainHorsesLoadingWidgetState();
}

class _MainHorsesLoadingWidgetState extends State<MainHorsesLoadingWidget> {
  @override
  Widget build(BuildContext context) {
    return  Shimmer(
      child: Column(
        children: [
         const SizedBox(height: 7,),
          GridView.builder(
                gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisSpacing: 8,
                  childAspectRatio: 1,

                  crossAxisCount: 2, // Adjust the number of columns
                ),
              shrinkWrap: true,
              primary: false,
              physics: NeverScrollableScrollPhysics(),
              itemCount: 12,
              itemBuilder: (context, index) {
                return Padding(
                  padding:  const EdgeInsets.symmetric(
                      horizontal: kPadding, vertical: 10),
                  child: ShimmerLoading(
                    isLoading: true,
                    child: Container(
                      height: 180,
                      width: 200,
                      decoration: BoxDecoration(
                        color: Colors.grey,
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
    );
  }
}
