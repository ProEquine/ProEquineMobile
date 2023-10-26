import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proequine/app_settings.dart';
import 'package:proequine/core/constants/constants.dart';
import 'package:proequine/core/constants/thems/app_styles.dart';
import 'package:proequine/core/utils/sharedpreferences/SharedPreferencesHelper.dart';
import 'package:proequine/core/widgets/custom_error_widget.dart';
import 'package:proequine/features/manage_account/domain/manage_account_cubit.dart';

import 'package:proequine/features/manage_account/presentation/screens/add_address_screen.dart';
import 'package:proequine/features/manage_account/presentation/screens/bio_screen.dart';
import 'package:proequine/features/manage_account/presentation/screens/chose_phone_update_screen.dart';
import 'package:proequine/features/manage_account/presentation/screens/update_email_screen.dart';

import 'package:proequine/features/manage_account/presentation/screens/update_username_screen.dart';
import 'package:proequine/core/widgets/profile_header_widget.dart';
import 'package:proequine/features/manage_account/presentation/widgets/account_management_gradient_loading.dart';
import 'package:proequine/main.dart';

import 'package:sizer/sizer.dart';

import '../../../../core/constants/routes/routes.dart';
import '../../../../core/widgets/custom_header.dart';
import '../../../../core/widgets/global_bottom_sheet.dart';
import '../../../../core/widgets/profile_two_lines_list_tile.dart';
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

  @override
  void dispose() {
    cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final themeCubit = ThemeCubitProvider.of(context);
    return BlocBuilder<ManageAccountCubit, ManageAccountState>(
        bloc: cubit..getUser(),
        builder: (context, state) {
          if (state is GetUserError) {
            return Scaffold(
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(20.h),
                child: CustomHeader(
                  title: "Manage Account",
                  isThereBackButton: true,
                  isThereChangeWithNavigate: false,
                ),
              ),
              body: CustomErrorWidget(
                errorMessage: 'Oops! Something went wrong. Please try again.',
                onRetry: () {
                  cubit.getUser();
                },
              ),
            );
          } else if (state is GetUserLoading) {
            return const ManageAccountGradientLoadingScreen();
          } else if (state is GetUserSuccessful) {
            return Scaffold(
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
                        content: HelpWidget(
                          name: state.responseModel!.name!,
                          nationality: state.responseModel!.nationality!,
                          dob: state.responseModel!.dob!,
                        ));
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
                        pictureUrl:state.responseModel!.userPhoto! ,
                        name: state.responseModel!.name,
                        userName: 'PE ID : ${state.responseModel!.peid}',
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
                        subTitle: state.responseModel!.userName,
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      UpdateUserNameScreen()));
                        },
                        ableToEdit: true,
                      ),
                      ProfileTwoLineListTile(
                        title: "Phone",
                        subTitle: state.responseModel!.phoneNumber,
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ChoseUpdatePhoneScreen(
                                        mainPhoneNumber:
                                            state.responseModel!.phoneNumber,
                                        secondaryNumbers: state.responseModel!
                                            .secondaryPhoneNumbers,
                                      )));
                        },
                        ableToEdit: true,
                      ),
                      ProfileTwoLineListTile(
                        title: "Email",
                        subTitle: state.responseModel!.email,
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => UpdateEmailScreen(
                                        previousEmail: AppSharedPreferences
                                            .userEmailAddress,
                                      )));
                        },
                        ableToEdit: true,
                      ),
                      ProfileTwoLineListTile(
                        title: "Address",
                        subTitle: state.responseModel?.country != null
                            ? '${state.responseModel?.country} - ${state.responseModel?.state}'
                            : '',
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AddAddressScreen(
                                        city: state.responseModel?.city,
                                        countryState:
                                            state.responseModel?.state,
                                        country: state.responseModel?.country,
                                        address: state.responseModel?.address,
                                      )));
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
                                  builder: (context) =>
                                      ChangePasswordScreen()));
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
          return Container();
        });
  }
}
