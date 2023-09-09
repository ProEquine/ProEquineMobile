import 'package:flutter/material.dart';

import 'package:proequine/core/constants/constants.dart';
import 'package:proequine/core/constants/thems/app_styles.dart';
import 'package:proequine/features/manage_account/presentation/screens/update_username_screen.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/constants/routes/routes.dart';
import '../../../../core/widgets/custom_header.dart';
import '../../../../core/widgets/profile_list_tile_widget.dart';
import '../../../../core/widgets/profile_two_lines_list_tile.dart';


class EquineInfoScreen extends StatefulWidget {
  const EquineInfoScreen({super.key});

  @override
  State<EquineInfoScreen> createState() => _EquineInfoScreenState();
}

class _EquineInfoScreenState extends State<EquineInfoScreen> {


  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final themeCubit = ThemeCubitProvider.of(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(20.h),
        child: CustomHeader(
          title: "Equine Info",
          isThereBackButton: true,
          isThereChangeWithNavigate: false,
          isThereThirdOption: false
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(kPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProfileListTileWidget(
                title: "Discipline",
                onTap: () {
                  Navigator.pushNamed(context, choseDiscipline);
                },
                notificationList: false,
                isThereNewNotification: false,
              ),
              ProfileListTileWidget(
                title: "Role",
                onTap: () {
                  Navigator.pushNamed(context, updateRole);
                },
                notificationList: false,
                isThereNewNotification: false,
              ),
              ProfileListTileWidget(
                title: "Stables",
                onTap: () {
                  Navigator.pushNamed(context, choseUpdateStable);
                },
                notificationList: false,
                isThereNewNotification: false,
              ),
              // const SizedBox(height: 5,),
              // const Padding(
              //   padding: EdgeInsets.symmetric(horizontal: 14),
              //   child: Text(
              //     "Secondary Number",
              //     style: AppStyles.profileTitles,
              //     textAlign: TextAlign.start,
              //   ),
              // ),
              // ProfileTwoLineListTile(
              //   title: "Whatsapp",
              //   subTitle: "+9715-45049937",
              //   onTap: () {
              //     Navigator.push(
              //         context,
              //         MaterialPageRoute(
              //             builder: (context) => UpdateUserNameScreen()));
              //   },
              //   ableToEdit: true,
              // ),
              // ProfileTwoLineListTile(
              //   title: "Office",
              //   subTitle: "+9715-509887889",
              //   onTap: () {
              //     Navigator.pushNamed(context, updatePhone);
              //   },
              //   ableToEdit: true,
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
