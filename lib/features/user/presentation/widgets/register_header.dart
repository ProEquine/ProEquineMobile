import 'package:flutter/material.dart';
import 'package:proequine/core/constants/constants.dart';
import 'package:proequine/features/user/presentation/screens/login_screen.dart';

import 'dart:math' as math;

import '../../../../core/constants/colors/app_colors.dart';

class RegistrationHeader extends StatelessWidget {
  bool isThereBackButton = false;
   RegistrationHeader({super.key,this.isThereBackButton=false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kPadding,vertical: kPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          isThereBackButton?
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
                     Navigator.pop(context);
              },
            )),
          ):
              Container(),
          InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()));
            },
            child: Container(
              padding:
              const EdgeInsets.symmetric(horizontal: 25, vertical: 7),
              decoration: BoxDecoration(
                color: const Color(0xff161616),
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: const [
                  BoxShadow(color: Colors.white, spreadRadius: 1),
                ],
              ),
              child: const Text(
                "Sign In",
                style:
                TextStyle(color: AppColors.white, fontFamily: "notosan"),
              ),
            ),
          ),

        ],
      ),
    );
  }
}
