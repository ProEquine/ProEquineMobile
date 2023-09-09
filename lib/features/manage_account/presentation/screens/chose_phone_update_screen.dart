import 'package:flutter/material.dart';

import 'package:proequine/core/constants/constants.dart';
import 'package:proequine/core/constants/thems/app_styles.dart';
import 'package:proequine/features/manage_account/domain/manage_account_cubit.dart';

import 'package:proequine/features/manage_account/presentation/screens/update_username_screen.dart';

import 'package:sizer/sizer.dart';

import '../../../../core/constants/routes/routes.dart';
import '../../../../core/widgets/custom_header.dart';
import '../../../../core/widgets/profile_list_tile_widget.dart';
import '../../../../core/widgets/profile_two_lines_list_tile.dart';

class ChoosePhoneUpdateScreen extends StatefulWidget {
  const ChoosePhoneUpdateScreen({super.key});

  @override
  State<ChoosePhoneUpdateScreen> createState() =>
      _ChoosePhoneUpdateScreenState();
}

class _ChoosePhoneUpdateScreenState extends State<ChoosePhoneUpdateScreen> {
  ManageAccountCubit cubit = ManageAccountCubit();
  String? email;

  @override
  void dispose() {
    cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final themeCubit = ThemeCubitProvider.of(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(20.h),
        child: CustomHeader(
          title: "Phone",
          isThereBackButton: true,
          isThereChangeWithNavigate: false,
          isThereThirdOption: true,
          thirdOptionTitle: 'Add',
          onPressThirdOption: () {
            Navigator.pushNamed(context, addSecondaryPhone);
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
                  "Main",
                  style: AppStyles.profileTitles,
                  textAlign: TextAlign.start,
                ),
              ),
              ProfileListTileWidget(
                title: "+9715-509887889",
                onTap: () {
                  Navigator.pushNamed(context, updatePhone);
                },
                notificationList: false,
                isThereNewNotification: false,
              ),
              const SizedBox(
                height: 5,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 14),
                child: Text(
                  "Secondary Number",
                  style: AppStyles.profileTitles,
                  textAlign: TextAlign.start,
                ),
              ),
              ProfileTwoLineListTile(
                title: "Whatsapp",
                subTitle: "+9715-45049937",
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => UpdateUserNameScreen()));
                },
                ableToEdit: true,
              ),
              ProfileTwoLineListTile(
                title: "Office",
                subTitle: "+9715-509887889",
                onTap: () {
                  Navigator.pushNamed(context, updatePhone);
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
