import 'package:flutter/material.dart';

import 'package:proequine/core/constants/constants.dart';
import 'package:proequine/features/equine_info/presentation/screens/chose_stable_update_screen.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/constants/routes/routes.dart';
import '../../../../core/utils/secure_storage/secure_storage_helper.dart';
import '../../../../core/widgets/custom_header.dart';
import '../../../../core/widgets/profile_list_tile_widget.dart';
import 'chose_discilpine_update_screen.dart';

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
            isThereThirdOption: false),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(kPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProfileListTileWidget(
                title: "Equine Interests",
                onTap: () async {
                  String? userId = await SecureStorage().getUserId();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ChooseDisciplineScreen(
                              userId: int.parse(userId!))));
                },
                notificationList: false,
                isThereNewNotification: false,
              ),
              // ProfileListTileWidget(
              //   title: "Role",
              //   onTap: () {
              //     Navigator.pushNamed(context, allRoles);
              //   },
              //   notificationList: false,
              //   isThereNewNotification: false,
              // ),
              ProfileListTileWidget(
                title: "Stables",
                onTap: () async {
                  String? userId = await SecureStorage().getUserId();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ChooseUpdateStableScreen(
                              userId: int.parse(userId!))));
                },
                notificationList: false,
                isThereNewNotification: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
