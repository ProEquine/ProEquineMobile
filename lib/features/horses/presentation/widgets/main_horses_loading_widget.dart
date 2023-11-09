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
          ListView.builder(
              shrinkWrap: true,
              primary: false,
              physics: NeverScrollableScrollPhysics(),
              itemCount: 6,
              itemBuilder: (context, index) {
                return Padding(
                  padding:  const EdgeInsets.symmetric(
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
    );
  }
}
