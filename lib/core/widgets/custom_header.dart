import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:proequine/core/constants/constants.dart';

import '../constants/colors/app_colors.dart';


class CustomHeader extends StatelessWidget {
  CustomHeader(
      {Key? key,
        required this.title,
        this.isThereBackButton = true,
        this.isThereChangeWithNavigate = false,
        this.onPressAddButton,
        this.clearButton=false,
        this.onPressBack,})
      : super(key: key);

  final String title;
  final bool isThereBackButton;
  bool isThereChangeWithNavigate = false;
  bool clearButton ;
  final Function? onPressBack;
  final Function? onPressAddButton;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: isThereBackButton
          ? Padding(
        padding: const EdgeInsets.symmetric(horizontal: kPadding, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Transform(
              // alignment: Alignment.center,
                transform: Directionality.of(context) == TextDirection.rtl
                    ? Matrix4.rotationY(math.pi)
                    : Matrix4.rotationY(0),
                child:  Container(
               padding: const EdgeInsets.all(8),
                    decoration:const  BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.formsBackground,
                    ),
                    child:InkWell(

                  child:const Icon(
                    Icons.arrow_back,
                    color: AppColors.white,
                  ),
                  onTap: () {
                    isThereChangeWithNavigate
                        ? onPressBack!()
                        : Navigator.pop(context);
                  },
                )),
            ),
            Text(
              title,
              style: const TextStyle(
                color: AppColors.white,
                fontSize: 17.0,
                fontFamily: 'notosan',
                fontWeight: FontWeight.w500,
              ),
            ),

                 const SizedBox(
              width: 24,
            ),
          ],
        ),
      )
          : Padding(
        padding: const EdgeInsets.symmetric(horizontal: kPadding, vertical: kPadding),
        child: Text(
          title,
          style: const TextStyle(
            color: AppColors.white,
            fontSize: 20.0,
            fontFamily: 'notosan',
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
