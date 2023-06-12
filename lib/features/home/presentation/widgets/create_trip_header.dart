import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';



class CreateTripHeader extends StatelessWidget {
  final String?image;
   const CreateTripHeader({super.key,this.image});
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 40.0.h,
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(image!),fit: BoxFit.cover),
          ),
        ),
      ],
    );
  }
}
