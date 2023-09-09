import 'package:flutter/material.dart';

import 'package:proequine/core/constants/constants.dart';
import 'package:proequine/core/constants/thems/app_styles.dart';
import 'package:proequine/features/equine_info/presentation/screens/add_secondary_discipline_screen.dart';
import 'package:proequine/features/equine_info/presentation/screens/update_discipline_screen.dart';
import 'package:proequine/features/equine_info/presentation/screens/update_secondary_discipline_screen.dart';
import 'package:proequine/features/manage_account/domain/manage_account_cubit.dart';

import 'package:proequine/features/manage_account/presentation/screens/update_username_screen.dart';

import 'package:sizer/sizer.dart';

import '../../../../core/constants/routes/routes.dart';
import '../../../../core/widgets/custom_header.dart';
import '../../../../core/widgets/profile_two_lines_list_tile.dart';

class ChooseDisciplineScreen extends StatefulWidget {
  const ChooseDisciplineScreen({super.key});

  @override
  State<ChooseDisciplineScreen> createState() => _ChooseDisciplineScreenState();
}

class _ChooseDisciplineScreenState extends State<ChooseDisciplineScreen> {
  @override
  Widget build(BuildContext context) {
    // final themeCubit = ThemeCubitProvider.of(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(20.h),
        child: CustomHeader(
          title: "Discipline",
          isThereBackButton: true,
          isThereChangeWithNavigate: false,
          isThereThirdOption: true,
          thirdOptionTitle: 'Add',
          onPressThirdOption: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        const AddSecondaryDisciplineScreen()));
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
                  "Main Discipline",
                  style: AppStyles.profileTitles,
                  textAlign: TextAlign.start,
                ),
              ),
              ProfileTwoLineListTile(
                title: "Show Jumping",
                subTitle: "National id : SJ10001015 \nFei ID : 123213123 ",
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => UpdateMainDiscipline(
                                userDiscipline: "Show Jumping",
                                userFeId: '123213123',
                                userNationalId: 'SJ10001015',
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
                  "Secondary Discipline",
                  style: AppStyles.profileTitles,
                  textAlign: TextAlign.start,
                ),
              ),
              ProfileTwoLineListTile(
                title: "Endurance",
                subTitle:
                    "National id : Not Applicable \nFei ID : Not Applicable",
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => UpdateSecondaryDisciplineScreen(
                              secondaryDiscipline: "Endurance")));
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
