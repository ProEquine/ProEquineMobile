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
import '../../../../core/widgets/profile_help_bottom_sheet.dart';
import '../../../../core/widgets/profile_two_lines_list_tile.dart';
import '../../../../core/widgets/rebi_button.dart';
import '../../../../core/widgets/rebi_input.dart';
import '../../../../core/widgets/drop_down_menu_widget.dart';
import '../../../../core/widgets/profile_list_tile_widget.dart';
import 'change_password_screen.dart';

class ManageAccountScreen extends StatefulWidget {
  const ManageAccountScreen({super.key});

  @override
  State<ManageAccountScreen> createState() => _ManageAccountScreenState();
}

class _ManageAccountScreenState extends State<ManageAccountScreen> {
  ManageAccountCubit cubit = ManageAccountCubit();
  String? email;
  final GlobalKey<FormState> _yearKey = GlobalKey<FormState>();
  TextEditingController reason = TextEditingController();
  TextEditingController firstName = TextEditingController();
  TextEditingController middleName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController nationality = TextEditingController();
  TextEditingController dateOfBirth = TextEditingController();
  TextEditingController year = TextEditingController();
  DateTime _selectedDay = DateTime.utc(1950);
  final DateTime _focusedDay = DateTime.now();
  late int _selectedYear;
  late TextEditingController _yearController;
  late DateTime dateTime;

  var now = DateTime.now();

  int? firstDay = 1;
  int? firstMonth = 1;
  int? firstYear = 1;
  int? lastDay = 30;
  int? lastMonth = 1;
  int? lastYear = 1;
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
  void initState() {
    initializeDateFormatting();
    _selectedYear = _selectedDay.year;
    _yearController = TextEditingController(text: _selectedDay.year.toString());
    super.initState();
  }

  @override
  void dispose() {
    cubit.close();
    reason.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final themeCubit = ThemeCubitProvider.of(context);
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
            showProfileHelpBottomSheet(
                context: MyApp.navigatorKey.currentState!.context,
                title: "Account Help",
                content: Column(
                  children: [
                    ProfileListTileWidget(
                      title: "Update Info",
                      onTap: () {
                        showProfileHelpBottomSheet(
                            context: MyApp.navigatorKey.currentState!.context,
                            title: "Update Info",
                            content:
                                StatefulBuilder(builder: (context, setstate) {
                              return Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: kPadding),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text("What you want to update",
                                          style: AppStyles.profileBlackTitles),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: kPadding),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                          "To keep your records consistent you need to submit this form and wait for the request to approved and your account gets updated.",
                                          style: AppStyles.descriptions),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 7),
                                    child: DropDownWidget(
                                      items: updateOptions,
                                      selected: selectedOption,
                                      onChanged: (selected) {
                                        setstate(() {
                                          selectedOption = selected;
                                          Print(
                                              'selected Option $selectedOption');
                                        });
                                        // setState(() {
                                        //
                                        // });
                                      },
                                      validator: (value) {
                                        // return Validator.requiredValidator(selectedNumber);
                                      },
                                      hint: 'select',
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Visibility(
                                    visible:
                                        selectedOption != null ? true : false,
                                    child: RebiButton(
                                      onPressed: () {
                                        /// show and handle change name
                                        if (selectedOption == 'Name') {
                                          showProfileHelpBottomSheet(
                                              context: context,
                                              title: "Change Your Name",
                                              content: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  const Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal:
                                                                kPadding),
                                                    child: Align(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                          "Current Name",
                                                          style: AppStyles
                                                              .profileBlackTitles),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: kPadding),
                                                    child: Align(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                          "Abdalla Alsharif",
                                                          style: AppStyles
                                                              .currentData),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: [
                                                      Expanded(
                                                        flex: 9,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  vertical: 7),
                                                          child: RebiInput(
                                                            hintText:
                                                                'First Name'
                                                                    .tra,
                                                            controller:
                                                                firstName,
                                                            keyboardType:
                                                                TextInputType
                                                                    .name,
                                                            textInputAction:
                                                                TextInputAction
                                                                    .done,
                                                            isOptional: false,
                                                            color: AppColors
                                                                .formsLabel,
                                                            readOnly: false,
                                                            contentPadding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        20,
                                                                    vertical:
                                                                        13),
                                                            obscureText: false,
                                                            validator: (value) {
                                                              return Validator
                                                                  .requiredValidator(
                                                                      firstName
                                                                          .text);
                                                            },
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        width: 5,
                                                      ),
                                                      Expanded(
                                                        flex: 10,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  vertical: 7),
                                                          child: RebiInput(
                                                            hintText:
                                                                'Middle Name'
                                                                    .tra,
                                                            controller:
                                                                middleName,
                                                            keyboardType:
                                                                TextInputType
                                                                    .name,
                                                            textInputAction:
                                                                TextInputAction
                                                                    .done,
                                                            isOptional: false,
                                                            color: AppColors
                                                                .formsLabel,
                                                            readOnly: false,
                                                            contentPadding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        20,
                                                                    vertical:
                                                                        13),
                                                            obscureText: false,
                                                            validator: (value) {
                                                              return Validator
                                                                  .requiredValidator(
                                                                      middleName
                                                                          .text);
                                                            },
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(vertical: 7),
                                                    child: RebiInput(
                                                      hintText: 'Last Name'.tra,
                                                      controller: lastName,
                                                      keyboardType:
                                                          TextInputType.name,
                                                      textInputAction:
                                                          TextInputAction.done,
                                                      isOptional: false,
                                                      color:
                                                          AppColors.formsLabel,
                                                      readOnly: false,
                                                      contentPadding:
                                                          const EdgeInsets
                                                                  .symmetric(
                                                              horizontal: 20,
                                                              vertical: 13),
                                                      obscureText: false,
                                                      validator: (value) {
                                                        return Validator
                                                            .requiredValidator(
                                                                lastName.text);
                                                      },
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        vertical: kPadding),
                                                    child: RebiButton(
                                                      onPressed: () {},
                                                      child: const Text(
                                                        "Confirm",
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ));
                                        }

                                        /// show and handle change nationality
                                        else if (selectedOption ==
                                            'Nationality') {
                                          showProfileHelpBottomSheet(
                                              context: context,
                                              title: "Change Your Nationality",
                                              content: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  const Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal:
                                                                kPadding),
                                                    child: Align(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                          "Current Nationality",
                                                          style: AppStyles
                                                              .profileBlackTitles),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: kPadding),
                                                    child: Align(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                          "United Arab Emirates",
                                                          style: AppStyles
                                                              .currentData),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(vertical: 7),
                                                    child: RebiInput(
                                                      hintText:
                                                          'Nationality'.tra,
                                                      controller: nationality,
                                                      keyboardType:
                                                          TextInputType.name,
                                                      textInputAction:
                                                          TextInputAction.done,
                                                      onTap: () {
                                                        showCountryPicker(
                                                          context: context,
                                                          showPhoneCode: true,
                                                          countryListTheme:
                                                              CountryListThemeData(
                                                            flagSize: 25,
                                                            backgroundColor:
                                                                AppColors
                                                                    .backgroundColorLight,
                                                            textStyle: const TextStyle(
                                                                fontSize: 16,
                                                                color: AppColors
                                                                    .blackLight),
                                                            bottomSheetHeight:
                                                                85.0.h,
                                                            // Optional. Country list modal height
                                                            //Optional. Sets the border radius for the bottomsheet.
                                                            borderRadius:
                                                                const BorderRadius
                                                                    .only(
                                                              topLeft: Radius
                                                                  .circular(
                                                                      20.0),
                                                              topRight: Radius
                                                                  .circular(
                                                                      20.0),
                                                            ),
                                                            //Optional. Styles the search field.
                                                            inputDecoration:
                                                                const InputDecoration(
                                                              hintText:
                                                                  'Search by name or code',
                                                              hintStyle:
                                                                  TextStyle(
                                                                color: AppColors
                                                                    .formsHintFontLight,
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                              ),
                                                              prefixIcon: Icon(
                                                                Icons.search,
                                                                color: AppColors
                                                                    .formsHintFontLight,
                                                              ),
                                                              filled: true,
                                                              fillColor: AppColors
                                                                  .whiteLight,
                                                              border:
                                                                  OutlineInputBorder(
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            8)),
                                                                borderSide:
                                                                    BorderSide(
                                                                  color: Color(
                                                                      0xFFDBD4C3),
                                                                  width: 0.50,
                                                                ),
                                                              ),
                                                              enabledBorder:
                                                                  OutlineInputBorder(
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            8)),
                                                                borderSide:
                                                                    BorderSide(
                                                                  color: Color(
                                                                      0xFFDBD4C3),
                                                                  width: 0.50,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          onSelect: (Country
                                                                  country) =>
                                                              nationality.text =
                                                                  country.name,
                                                        );
                                                      },
                                                      autoValidateMode:
                                                          AutovalidateMode
                                                              .onUserInteraction,
                                                      isOptional: false,
                                                      color:
                                                          AppColors.formsLabel,
                                                      readOnly: true,
                                                      contentPadding:
                                                          const EdgeInsets
                                                                  .symmetric(
                                                              horizontal: 20,
                                                              vertical: 13),
                                                      obscureText: false,
                                                      validator: (value) {},
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        vertical: kPadding),
                                                    child: RebiButton(
                                                      onPressed: () {},
                                                      child: const Text(
                                                        "Confirm",
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ));
                                        }

                                        /// show and handle change date of birth
                                        else if (selectedOption == 'DOB') {
                                          showProfileHelpBottomSheet(
                                              context: context,
                                              title: "Change Your DOB",
                                              content: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  const Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal:
                                                                kPadding),
                                                    child: Align(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                          "Current Date Of Birth",
                                                          style: AppStyles
                                                              .profileBlackTitles),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: kPadding),
                                                    child: Align(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text("19-11-1992",
                                                          style: AppStyles
                                                              .currentData),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(vertical: 7),
                                                    child: RebiInput(
                                                      hintText:
                                                          'Date Of Birth'.tra,
                                                      controller: dateOfBirth,
                                                      keyboardType:
                                                          TextInputType.name,
                                                      textInputAction:
                                                          TextInputAction.done,
                                                      onTap: () {
                                                        selectDate(
                                                            context: context,
                                                            isSupportChangingYears:
                                                                true,
                                                            selectedOurDay:
                                                                _selectedDay,
                                                            from: DateTime.utc(
                                                                1950),
                                                            to: DateTime.utc(
                                                                2030),
                                                            selectedYear:
                                                                _selectedYear,
                                                            yearController:
                                                                _yearController,
                                                            focusDay:
                                                                _focusedDay,
                                                            controller:
                                                                dateOfBirth,
                                                            yearKey: _yearKey);
                                                      },
                                                      autoValidateMode:
                                                          AutovalidateMode
                                                              .onUserInteraction,
                                                      isOptional: false,
                                                      color:
                                                          AppColors.formsLabel,
                                                      readOnly: true,
                                                      contentPadding:
                                                          const EdgeInsets
                                                                  .symmetric(
                                                              horizontal: 20,
                                                              vertical: 13),
                                                      obscureText: false,
                                                      validator: (value) {
                                                        DateFormat inputFormat =
                                                            DateFormat(
                                                                "dd MMM yyyy");
                                                        DateTime dateTime =
                                                            inputFormat
                                                                .parse(value!);
                                                        _selectedDay = dateTime;
                                                        return Validator
                                                            .requiredValidator(
                                                                dateOfBirth
                                                                    .text);
                                                      },
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        vertical: kPadding),
                                                    child: RebiButton(
                                                      onPressed: () {},
                                                      child: const Text(
                                                        "Confirm",
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ));
                                        }
                                      },
                                      child: const Text(
                                        "Confirm",
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            }));
                      },
                      notificationList: false,
                      isThereNewNotification: false,
                    ),
                    ProfileListTileWidget(
                      isDeleteAccount: true,
                      title: "Delete Account",
                      onTap: () {
                        showProfileHelpBottomSheet(
                            context: context,
                            title: "Delete Account",
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: kPadding),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text("Confirmation",
                                        style: AppStyles.profileBlackTitles),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: kPadding),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                        "To keep your records consistent you need to submit this form and wait for the request to approved and your account gets updated.",
                                        style: AppStyles.descriptions),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 7),
                                  child: RebiInput(
                                    hintText: 'Reason'.tra,
                                    controller: reason,
                                    keyboardType: TextInputType.name,
                                    textInputAction: TextInputAction.done,
                                    isOptional: false,
                                    color: AppColors.formsLabel,
                                    readOnly: false,
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 13),
                                    obscureText: false,
                                    validator: (value) {},
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(kPadding),
                                  child: RebiButton(
                                    onPressed: () {},
                                    child: const Text(
                                      "Confirm",
                                    ),
                                  ),
                                ),
                              ],
                            ));
                      },
                      notificationList: false,
                      isThereNewNotification: false,
                    ),
                  ],
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
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const ManageAccountFadeLoadingScreen()));
                      },
                      child: Text("Fade Shimmer")),
                  TextButton(onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                             ManageAccountGradientLoadingScreen()));
                  }, child: Text("Gradient Shimmer")),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}