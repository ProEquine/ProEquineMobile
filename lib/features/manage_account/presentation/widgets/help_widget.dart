import 'package:country_picker/country_picker.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:proequine/core/utils/extensions.dart';
import 'package:proequine/core/widgets/loading_widget.dart';
import 'package:proequine/features/manage_account/data/delete_account_request_model.dart';
import 'package:proequine/features/manage_account/data/update_dob_request_model.dart';
import 'package:proequine/features/manage_account/data/update_name_request_model.dart';
import 'package:proequine/features/manage_account/data/update_nationality_request_model.dart';
import 'package:proequine/features/manage_account/domain/manage_account_cubit.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/constants/colors/app_colors.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/constants/routes/routes.dart';
import '../../../../core/constants/thems/app_styles.dart';
import '../../../../core/utils/Printer.dart';
import '../../../../core/utils/rebi_message.dart';
import '../../../../core/utils/secure_storage/secure_storage_helper.dart';
import '../../../../core/utils/sharedpreferences/SharedPreferencesHelper.dart';
import '../../../../core/utils/validator.dart';
import '../../../../core/widgets/date_time_picker.dart';
import '../../../../core/widgets/drop_down_menu_widget.dart';
import '../../../../core/widgets/global_bottom_sheet.dart';
import '../../../../core/widgets/profile_list_tile_widget.dart';
import '../../../../core/widgets/rebi_button.dart';
import '../../../../core/widgets/rebi_input.dart';
import '../../../../main.dart';
import '../../../splash/presentation/screens/splash_screen.dart';
import '../../data/basic_account_management_route.dart';

class HelpWidget extends StatefulWidget {
  final String name;
  final String nationality;
  final String dob;

  const HelpWidget(
      {Key? key,
      required this.name,
      required this.nationality,
      required this.dob})
      : super(key: key);

  @override
  State<HelpWidget> createState() => _HelpWidgetState();
}

class _HelpWidgetState extends State<HelpWidget> {
  TextEditingController reason = TextEditingController();
  TextEditingController firstName = TextEditingController();
  TextEditingController middleName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController nationality = TextEditingController();
  TextEditingController dateOfBirth = TextEditingController();
  TextEditingController year = TextEditingController();
  ManageAccountCubit cubit = ManageAccountCubit();
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

  int? firstDay = 1;
  int? firstMonth = 1;
  int? firstYear = 1;
  int? lastDay = 30;
  int? lastMonth = 1;
  int? lastYear = 1;
  final GlobalKey<FormState> _yearKey = GlobalKey<FormState>();

  DateTime _selectedDay = DateTime.utc(1950);
  DateTime currentDate = DateTime.utc(1950);
  String current ='';
  final DateTime _focusedDay = DateTime.now();
  late int _selectedYear;
  late TextEditingController _yearController;
  late DateTime dateTime;

  var now = DateTime.now();

  @override
  void initState() {
    initializeDateFormatting();
    _selectedYear = _selectedDay.year;
    _yearController = TextEditingController(text: _selectedDay.year.toString());
    super.initState();
  }

  @override
  void dispose() {
    reason.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ProfileListTileWidget(
          title: "Update Info",
          onTap: () {
            showGlobalBottomSheet(
                context: MyApp.navigatorKey.currentState!.context,
                title: "Update Info",
                content: StatefulBuilder(
                  builder: (context, setstate) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: kPadding),
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
                          padding:
                              const EdgeInsets.symmetric(horizontal: kPadding),
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
                          padding: const EdgeInsets.symmetric(vertical: 7),
                          child: DropDownWidget(
                            items: updateOptions,
                            selected: selectedOption,
                            onChanged: (selected) {
                              setstate(() {
                                selectedOption = selected;
                                Print('selected Option $selectedOption');
                              });
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
                          visible: selectedOption != null ? true : false,
                          child: RebiButton(
                            onPressed: () {
                              /// show and handle change name
                              if (selectedOption == 'Name') {
                                showGlobalBottomSheet(
                                    context: context,
                                    title: "Change Your Name",
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: kPadding),
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text("Current Name",
                                                style: AppStyles
                                                    .profileBlackTitles),
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
                                            child: Text(widget.name,
                                                style: AppStyles.currentData),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Expanded(
                                              flex: 9,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 7),
                                                child: RebiInput(
                                                  hintText: 'First Name'.tra,
                                                  controller: firstName,
                                                  keyboardType:
                                                      TextInputType.text,
                                                  textInputAction:
                                                      TextInputAction.done,
                                                  isOptional: false,
                                                  color: AppColors.formsLabel,
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
                                                            firstName.text);
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
                                                    const EdgeInsets.symmetric(
                                                        vertical: 7),
                                                child: RebiInput(
                                                  hintText: 'Middle Name'.tra,
                                                  controller: middleName,
                                                  keyboardType:
                                                      TextInputType.text,
                                                  textInputAction:
                                                      TextInputAction.done,
                                                  isOptional: false,
                                                  color: AppColors.formsLabel,
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
                                                            middleName.text);
                                                  },
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 7),
                                          child: RebiInput(
                                            hintText: 'Last Name'.tra,
                                            controller: lastName,
                                            keyboardType: TextInputType.text,
                                            textInputAction:
                                                TextInputAction.done,
                                            isOptional: false,
                                            color: AppColors.formsLabel,
                                            readOnly: false,
                                            contentPadding:
                                                const EdgeInsets.symmetric(
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
                                          padding: const EdgeInsets.symmetric(
                                              vertical: kPadding),
                                          child: BlocConsumer<
                                              ManageAccountCubit,
                                              ManageAccountState>(
                                            bloc: cubit,
                                            listener: (context, state) {
                                              if (state
                                                  is UpdateNameSuccessful) {
                                                Navigator.pushReplacementNamed(
                                                    context, successScreen,
                                                    arguments:
                                                        BasicAccountManagementRoute(
                                                            type:
                                                                'manageAccount',
                                                            title:
                                                                "Change Name request has been sent successfully"));
                                              } else if (state
                                                  is UpdateNameError) {
                                                RebiMessage.error(
                                                    msg: state.message!,
                                                    context: context);
                                              }
                                            },
                                            builder: (context, state) {
                                              if (state is UpdateNameLoading) {
                                                return const LoadingCircularWidget();
                                              }
                                              return RebiButton(
                                                onPressed: () {
                                                  onPressUpdateName();
                                                },
                                                child: const Text(
                                                  "Confirm",
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    ));
                              }

                              /// show and handle change nationality
                              else if (selectedOption == 'Nationality') {
                                showGlobalBottomSheet(
                                    context: context,
                                    title: "Change Your Nationality",
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: kPadding),
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text("Current Nationality",
                                                style: AppStyles
                                                    .profileBlackTitles),
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
                                            child: Text("United Arab Emirates",
                                                style: AppStyles.currentData),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 7),
                                          child: RebiInput(
                                            hintText: 'Nationality'.tra,
                                            controller: nationality,
                                            keyboardType: TextInputType.name,
                                            textInputAction:
                                                TextInputAction.done,
                                            onTap: () {
                                              showCountryPicker(
                                                context: context,
                                                showPhoneCode: true,
                                                countryListTheme:
                                                    CountryListThemeData(
                                                  flagSize: 25,
                                                  backgroundColor: AppColors
                                                      .backgroundColorLight,
                                                  textStyle: const TextStyle(
                                                      fontSize: 16,
                                                      color:
                                                          AppColors.blackLight),
                                                  bottomSheetHeight: 85.0.h,
                                                  borderRadius:
                                                      const BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(20.0),
                                                    topRight:
                                                        Radius.circular(20.0),
                                                  ),
                                                  inputDecoration:
                                                      const InputDecoration(
                                                    hintText:
                                                        'Search by name or code',
                                                    hintStyle: TextStyle(
                                                      color: AppColors
                                                          .formsHintFontLight,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                    prefixIcon: Icon(
                                                      Icons.search,
                                                      color: AppColors
                                                          .formsHintFontLight,
                                                    ),
                                                    filled: true,
                                                    fillColor:
                                                        AppColors.whiteLight,
                                                    border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  8)),
                                                      borderSide: BorderSide(
                                                        color:
                                                            Color(0xFFDBD4C3),
                                                        width: 0.50,
                                                      ),
                                                    ),
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  8)),
                                                      borderSide: BorderSide(
                                                        color:
                                                            Color(0xFFDBD4C3),
                                                        width: 0.50,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                onSelect: (Country country) =>
                                                    nationality.text =
                                                        country.name,
                                              );
                                            },
                                            autoValidateMode: AutovalidateMode
                                                .onUserInteraction,
                                            isOptional: false,
                                            color: AppColors.formsLabel,
                                            readOnly: true,
                                            contentPadding:
                                                const EdgeInsets.symmetric(
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
                                          padding: const EdgeInsets.symmetric(
                                              vertical: kPadding),
                                          child: BlocConsumer<
                                              ManageAccountCubit,
                                              ManageAccountState>(
                                            bloc: cubit,
                                            listener: (context, state) {
                                              if (state
                                                  is UpdateNationalitySuccessful) {
                                                Navigator.pushReplacementNamed(
                                                    context, successScreen,
                                                    arguments:
                                                        BasicAccountManagementRoute(
                                                            type:
                                                                'manageAccount',
                                                            title:
                                                                "Nationality request has been sent successfully"));
                                              } else if (state
                                                  is UpdateNationalityError) {
                                                RebiMessage.error(
                                                    msg: state.message!,
                                                    context: context);
                                              }
                                              // TODO: implement listener
                                            },
                                            builder: (context, state) {
                                              if (state
                                                  is UpdateNationalityLoading) {
                                                return const LoadingCircularWidget();
                                              }
                                              return RebiButton(
                                                onPressed: () {
                                                  onPressUpdateNationality();
                                                },
                                                child: const Text(
                                                  "Confirm",
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    ));
                              }

                              /// show and handle change date of birth
                              else if (selectedOption == 'DOB') {
                                // DateFormat inputFormat =
                                // DateFormat("dd MMM yyyy");
                                // DateTime dateTime =
                                // inputFormat.parse(widget.dob);
                                // currentDate = dateTime;
                                // current=currentDate.toString();
                                showGlobalBottomSheet(
                                    context: context,
                                    title: "Change Your DOB",
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: kPadding),
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text("Current Date Of Birth",
                                                style: AppStyles
                                                    .profileBlackTitles),
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
                                            child: Text(widget.dob,
                                                style: AppStyles.currentData),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 7),
                                          child: RebiInput(
                                            hintText: 'Date Of Birth'.tra,
                                            controller: dateOfBirth,
                                            keyboardType: TextInputType.name,
                                            textInputAction:
                                                TextInputAction.done,
                                            onTap: () {
                                              selectDate(
                                                  context: context,
                                                  isSupportChangingYears: true,
                                                  selectedOurDay: _selectedDay,
                                                  from: DateTime.utc(1950),
                                                  to: DateTime.utc(2030),
                                                  selectedYear: _selectedYear,
                                                  yearController:
                                                      _yearController,
                                                  focusDay: _focusedDay,
                                                  controller: dateOfBirth,
                                                  yearKey: _yearKey);
                                            },
                                            autoValidateMode: AutovalidateMode
                                                .onUserInteraction,
                                            isOptional: false,
                                            color: AppColors.formsLabel,
                                            readOnly: true,
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                    horizontal: 20,
                                                    vertical: 13),
                                            obscureText: false,
                                            validator: (value) {
                                              DateFormat inputFormat =
                                                  DateFormat("dd MMM yyyy");
                                              DateTime dateTime =
                                                  inputFormat.parse(value!);
                                              _selectedDay = dateTime;
                                              return Validator
                                                  .requiredValidator(
                                                      dateOfBirth.text);
                                            },
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: kPadding),
                                          child: BlocConsumer<
                                              ManageAccountCubit,
                                              ManageAccountState>(
                                            bloc: cubit,
                                            listener: (context, state) {
                                              if (state
                                                  is UpdateDOBSuccessful) {
                                                Navigator.pushReplacementNamed(
                                                    context, successScreen,
                                                    arguments:
                                                        BasicAccountManagementRoute(
                                                            type:
                                                                'manageAccount',
                                                            title:
                                                                "Update date of birth request has been sent successfully"));
                                              } else if (state
                                                  is UpdateDOBError) {
                                                RebiMessage.error(
                                                    msg: state.message!,
                                                    context: context);
                                              }
                                            },
                                            builder: (context, state) {
                                              if (state is UpdateDOBLoading) {
                                                return const LoadingCircularWidget();
                                              }
                                              return RebiButton(
                                                onPressed: () {
                                                  onPressUpdateDOB();
                                                },
                                                child: const Text(
                                                  "Confirm",
                                                ),
                                              );
                                            },
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
                  },
                ));
          },
          notificationList: false,
          isThereNewNotification: false,
        ),
        ProfileListTileWidget(
          isDeleteAccount: true,
          title: "Delete Account",
          onTap: () {
            showGlobalBottomSheet(
                context: context,
                title: "Delete Account",
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: kPadding),
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
                      padding: const EdgeInsets.symmetric(horizontal: kPadding),
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
                      padding: const EdgeInsets.symmetric(vertical: 7),
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
                      child:
                          BlocConsumer<ManageAccountCubit, ManageAccountState>(
                        bloc: cubit,
                        listener: (context, state) {
                          if (state is DeleteAccountSuccessful) {
                            if (context.mounted) {
                              RebiMessage.success(
                                  msg: "Account Deleted Successfully",
                                  context: context);
                            }
                            if (context.mounted) {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const SplashScreen()));
                            }
                          }
                        },
                        builder: (context, state) {
                          if (state is DeleteAccountLoading) {
                            return const LoadingCircularWidget();
                          }
                          return RebiButton(
                            onPressed: () async {
                              onPressDeleteAccount();
                              AppSharedPreferences.clearForLogOut();
                              await SecureStorage().deleteUserId();
                              await SecureStorage().deleteDeviceId();
                              await SecureStorage().deleteRefreshToken();
                              await SecureStorage().deleteToken();
                              AppSharedPreferences.phoneVerified = false;
                              AppSharedPreferences.typeSelected = false;
                              AppSharedPreferences.emailVerified = false;
                            },
                            child: const Text(
                              "Confirm",
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ));
          },
          notificationList: false,
          isThereNewNotification: false,
        ),
      ],
    );
  }

  onPressDeleteAccount() {
    cubit.deleteAccount(DeleteAccountRequestModel(reason: reason.text));
  }

  onPressUpdateName() {
    cubit.updateName(UpdateNameRequestModel(
      firstName: firstName.text,
      middleName: middleName.text,
      lastName: lastName.text,
    ));
  }

  onPressUpdateNationality() {
    cubit.updateNationality(
        UpdateNationalityRequestModel(nationality: nationality.text));
  }

  onPressUpdateDOB() {
    cubit.updateDOB(UpdateDateOfBirthRequestModel(
      dateOfBirth: _selectedDay.toIso8601String(),
    ));
  }
}
