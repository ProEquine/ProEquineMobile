import 'dart:math';

import 'package:flutter/material.dart';
import 'package:proequine/core/widgets/rebi_button.dart';
import 'package:proequine/features/profile/presentation/screens/add_horse_screen.dart';
import 'package:proequine/features/profile/presentation/widgets/horses_widget.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/widgets/custom_header.dart';

class HorsesScreen extends StatefulWidget {
  const HorsesScreen({super.key});

  @override
  _HorsesScreenState createState() => _HorsesScreenState();
}

class _HorsesScreenState extends State<HorsesScreen> {
  bool random = Random().nextBool();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(20.0.h),
        child: CustomHeader(
          title: "Horses",
          isThereBackButton: true,
        ),
      ),
      body:  Column(
          children: [
          Expanded(
            // flex: 10,
            child: ListView.builder(
                  shrinkWrap: true,
                  primary: false,
                scrollDirection: Axis.vertical,
                physics: const AlwaysScrollableScrollPhysics(),
                  itemCount: 8,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: kPadding, vertical: 10),
                      child: HorsesWidget(
                        imageUrl:
                            'https://proequineimagestore.blob.core.windows.net/proequineimages/Testing%207',
                        isActive: random,
                        name: 'Lexus',
                        property: 'Own Horse',
                      ),
                    );
                  }),
          ),

            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: kPadding, vertical: kPadding),
                child: RebiButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AddHorseScreen()));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        // height: 10,
                        // width: 10,
                        padding: const EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.add,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Text("Add new horse"),
                    ],
                  ),
                ),

              ),
            ),
            const SizedBox(height: 10,)
          ],
        ),
    );
  }
}
