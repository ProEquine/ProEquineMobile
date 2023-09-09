import 'package:flutter/material.dart';

import 'package:proequine/core/constants/constants.dart';
import 'package:proequine/core/constants/thems/app_styles.dart';
import 'package:proequine/features/equine_info/presentation/screens/add_secondary_discipline_screen.dart';
import 'package:proequine/features/equine_info/presentation/screens/add_secondary_stable_screen.dart';
import 'package:proequine/features/equine_info/presentation/screens/update_discipline_screen.dart';
import 'package:proequine/features/equine_info/presentation/screens/update_main_stable_screen.dart';
import 'package:proequine/features/equine_info/presentation/screens/update_secondary_stable_screen.dart';
import 'package:proequine/features/manage_account/domain/manage_account_cubit.dart';

import 'package:proequine/features/manage_account/presentation/screens/update_username_screen.dart';

import 'package:sizer/sizer.dart';

import '../../../../core/constants/routes/routes.dart';
import '../../../../core/widgets/custom_header.dart';
import '../../../../core/widgets/profile_two_lines_list_tile.dart';

class ChooseUpdateStableScreen extends StatefulWidget {
  const ChooseUpdateStableScreen({super.key});

  @override
  State<ChooseUpdateStableScreen> createState() =>
      _ChooseUpdateStableScreenState();
}

class _ChooseUpdateStableScreenState extends State<ChooseUpdateStableScreen> {
  @override
  Widget build(BuildContext context) {
    // final themeCubit = ThemeCubitProvider.of(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(20.h),
        child: CustomHeader(
          title: "Stables",
          isThereBackButton: true,
          isThereChangeWithNavigate: false,
          isThereThirdOption: true,
          thirdOptionTitle: 'Add',
          onPressThirdOption: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const AddSecondaryStableScreen()));
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(kPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 14),
                child: Text(
                  "Main Stable",
                  style: AppStyles.profileTitles,
                  textAlign: TextAlign.start,
                ),
              ),
              ProfileTwoLineListTile(
                title: "Al Safinat",
                subTitle: "Sharjah , UAE",
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => UpdateMainStableScreen(
                                mainStable: "Al Safinat",
                              )));
                },
                ableToEdit: true,
              ),
              const SizedBox(
                height: 20,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 14),
                child: Text(
                  "Secondary Stable",
                  style: AppStyles.profileTitles,
                  textAlign: TextAlign.start,
                ),
              ),
              ProfileTwoLineListTile(
                title: "Malalth Paradise",
                subTitle: "Umm Al Quwain , UAE",
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => UpdateSecondaryStableScreen(
                                secondaryStable: "Malalth Paradise",
                              )));
                },
                ableToEdit: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
