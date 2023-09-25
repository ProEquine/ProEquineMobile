import 'dart:async';

import 'package:country_picker/country_picker.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'package:proequine/core/constants/constants.dart';
import 'package:proequine/core/constants/thems/app_styles.dart';
import 'package:proequine/core/utils/Printer.dart';
import 'package:proequine/core/utils/extensions.dart';
import 'package:proequine/core/utils/sharedpreferences/SharedPreferencesHelper.dart';
import 'package:proequine/core/utils/validator.dart';
import 'package:proequine/features/manage_account/domain/manage_account_cubit.dart';

import 'package:proequine/features/manage_account/presentation/screens/add_address_screen.dart';
import 'package:proequine/features/manage_account/presentation/screens/bio_screen.dart';
import 'package:proequine/features/manage_account/presentation/screens/update_email_screen.dart';

import 'package:proequine/features/manage_account/presentation/screens/update_username_screen.dart';
import 'package:proequine/core/widgets/profile_header_widget.dart';
import 'package:proequine/features/manage_account/presentation/widgets/account_management_gradient_loading.dart';
import 'package:proequine/features/manage_account/presentation/widgets/account_management_loading.dart';

import 'package:proequine/main.dart';

import 'package:sizer/sizer.dart';

import '../../../../core/constants/colors/app_colors.dart';
import '../../../../core/constants/routes/routes.dart';
import '../../../../core/widgets/custom_header.dart';
import '../../../../core/widgets/date_time_picker.dart';
import '../../../../core/widgets/global_bottom_sheet.dart';
import '../../../../core/widgets/profile_two_lines_list_tile.dart';
import '../../../../core/widgets/rebi_button.dart';
import '../../../../core/widgets/rebi_input.dart';
import '../../../../core/widgets/drop_down_menu_widget.dart';
import '../../../../core/widgets/profile_list_tile_widget.dart';
import '../widgets/help_widget.dart';
import 'change_password_screen.dart';

class ManageAccountScreen extends StatefulWidget {
  const ManageAccountScreen({super.key});

  @override
  State<ManageAccountScreen> createState() => _ManageAccountScreenState();
}

class _ManageAccountScreenState extends State<ManageAccountScreen> {
  ManageAccountCubit cubit = ManageAccountCubit();
  String? email;

  late Timer timer;


  List<DropdownMenuItem<String>> updateOptions = [
    const DropdownMenuItem(
      value: "Name",
      child: Text("Name"),
    ),
    const DropdownMenuItem(
      value: "Nationality",
      child: Text("Nationality"),
    ),
    const DropdownMenuItem(
      value: "DOB",
      child: Text("Date Of Birth"),
    ),
  ];
  String? selectedOption;
  bool isLoading = true;

  @override
  void initState() {
    timer = Timer(const Duration(seconds: 4), () {
      setState(() {
        isLoading = false;
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    cubit.close();
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final themeCubit = ThemeCubitProvider.of(context);
    return isLoading
        ? const ManageAccountGradientLoadingScreen()
        :Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(20.h),
        child: CustomHeader(
          title: "Manage Account",
          isThereBackButton: true,
          isThereChangeWithNavigate: false,
          isThereThirdOption: true,
          thirdOptionTitle: 'Help',
          onPressThirdOption: () {
            showGlobalBottomSheet(
                context: MyApp.navigatorKey.currentState!.context,
                title: "Account Help",
                content: HelpWidget());
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
              ProfileHeaderWidget(
                name: "Abdalla Arif AlSharif",
                userName: 'PE ID : 100203',
                isFromEditing: true,
              ),
              const SizedBox(
                height: 20,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 14),
                child: Text(
                  "Personal Info",
                  style: AppStyles.profileTitles,
                  textAlign: TextAlign.start,
                ),
              ),
              // ProfileDivider(),
              ProfileTwoLineListTile(
                title: "Username",
                subTitle: "@Alsharif_Abdalla",
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => UpdateUserNameScreen()));
                },
                ableToEdit: true,
              ),
              ProfileTwoLineListTile(
                title: "Phone",
                subTitle: "+9715-509887889",
                onTap: () {
                  Navigator.pushNamed(context, chooseUpdatePhone);
                },
                ableToEdit: true,
              ),
              ProfileTwoLineListTile(
                title: "Email",
                subTitle: "abdalla@proequine.ae",
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => UpdateEmailScreen(
                                previousEmail:
                                    AppSharedPreferences.userEmailAddress,
                              )));
                },
                ableToEdit: true,
              ),
              ProfileTwoLineListTile(
                title: "Address",
                subTitle: "UAE-Sharjah",
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AddAddressScreen()));
                },
                ableToEdit: true,
              ),
              ProfileListTileWidget(
                title: "Bio & Social Accounts",
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const BioScreen()));
                },
                notificationList: false,
                isThereNewNotification: false,
              ),
              ProfileListTileWidget(
                title: "Update Password",
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ChangePasswordScreen()));
                },
                notificationList: false,
                isThereNewNotification: false,
              ),
              const SizedBox(
                height: 5,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
