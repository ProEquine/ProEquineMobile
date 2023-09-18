import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'package:proequine/core/constants/colors/app_colors.dart';
import 'package:proequine/core/constants/constants.dart';
import 'package:proequine/core/utils/extensions.dart';
import 'package:proequine/core/utils/rebi_message.dart';
import 'package:proequine/core/widgets/phone_number_field_widget.dart';
import 'package:proequine/features/home/data/trip_service_data_model.dart';
import 'package:proequine/features/home/presentation/screens/chose_horses_trip_screen.dart';
import 'package:proequine/features/home/presentation/widgets/hospital_bottom_sheet.dart';
import 'package:proequine/features/home/presentation/widgets/select_date_time_widget.dart';
import 'package:proequine/features/home/presentation/widgets/select_place_widget.dart';

import '../../../../core/utils/Printer.dart';
import '../../../../core/utils/sharedpreferences/SharedPreferencesHelper.dart';
import '../../../../core/utils/validator.dart';
import '../../../../core/widgets/date_time_picker.dart';
import '../../../../core/widgets/divider.dart';
import '../../../../core/widgets/rebi_button.dart';
import '../../../../core/widgets/rebi_input.dart';
import '../widgets/select_place_form_widget.dart';

class CreateTripScreen extends StatefulWidget {
  final String? type;

  const CreateTripScreen({super.key, this.type});

  @override
  CreateTripScreenState createState() => CreateTripScreenState();
}

class CreateTripScreenState extends State<CreateTripScreen>
    with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController pickUpLocation = TextEditingController();
  TextEditingController dropLocation = TextEditingController();
  TextEditingController selectHospital = TextEditingController();
  TextEditingController pickUpContactName = TextEditingController();
  TextEditingController dropContactName = TextEditingController();
  TextEditingController pickUpContactNumber = TextEditingController();
  TextEditingController numberOfHorses = TextEditingController();
  TextEditingController dropContactNumber = TextEditingController();
  TextEditingController pickUpCountryCode = TextEditingController(text: '+971');
  TextEditingController dropCountryCode = TextEditingController(text: '+971');
  DateTime focusedDay = DateTime.now();
  TextEditingController? date;
  TextEditingController? expectedDate;
  late DateTime dateTime;
  late DateTime expectedDateTime;
  late DateTime pickDate;
  late DateTime exDropDate;
  late DateTime expectedPickDate;

  String convertToTime(DateTime dateTime) {
    final time = DateFormat.Hm().format(dateTime);
    return time;
  }

  DateTime? time;
  DateTime? expectedTime;
  late TextEditingController? timePicked;
  late TextEditingController? expectedTimePicked;

  Future<bool> checkVerificationStatus() async {
    if (AppSharedPreferences.getEmailVerified!) {
      return true;
    } else {
      await Future.delayed(
          const Duration(milliseconds: 50)); // Simulating an asynchronous call
      return false;
    }
  }

  String? selectedTrip;
  String? selectedHospital;
  String? selectedPlace;

  @override
  void initState() {
    // checkVerificationStatus().then((verified) {
    //   if (!verified) {
    //     // If the account is not verified, show a dialog after a delay.
    //     Future.delayed(const Duration(milliseconds: 50), () {
    //       showUnverifiedAccountDialog(
    //         context: context,
    //         isThereNavigationBar: true,
    //         onPressVerify: () {
    //           Navigator.pushNamed(context, verifyEmail,
    //               arguments: VerifyEmailRoute(
    //                   type: 'Booking',
    //                   email: AppSharedPreferences.userEmailAddress))
    //               .then((value) {});
    //         },
    //       );
    //     });
    //   }
    // });
    initializeDateFormatting();
    pickDate = DateTime.now();
    dateTime = DateTime.now();
    exDropDate = DateTime.now();
    expectedPickDate = DateTime.now().add(const Duration(days: 1));
    expectedDateTime = DateTime.now().add(const Duration(days: 1));
    date = TextEditingController();
    expectedDate = TextEditingController();
    timePicked = TextEditingController();
    expectedTimePicked = TextEditingController();
    time = DateTime.utc(0, 0, 0, 15, 0);
    expectedTime = DateTime.utc(0, 0, 0, 15, 0);
    selectedTrip = "Other day return";

    super.initState();
  }

  bool? isEmailVerified = false;
  DateTime? currentBackPressTime;
  List<String> hospitals = [
    'Dubai Equine Hospital',
    'Sharjah Equine Hospital',
    'Equine Hydrotherapy Center',
    'AL Marmoom Equine hospital',
    'AL Hawraa Vet . Med .& Equip. Est',
    'Europets Hospital',
    'Salsabeel vet. establishment '
  ];

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > const Duration(seconds: 0)) {
      currentBackPressTime = now;
      return Future.value(true);
    }
    return Future.value(true);
  }

  @override
  void dispose() {
    date?.dispose();
    expectedDate?.dispose();
    timePicked?.dispose();
    expectedTimePicked?.dispose();
    super.dispose();
  }

  String? selectedNumber;
  String? pickPhoneNumber;
  String? dropPhoneNumber;

  @override
  Widget build(BuildContext context) {
    isEmailVerified = ModalRoute.of(context)?.settings.arguments as bool?;
    expectedDateTime = pickDate.add(const Duration(days: 1));
    isEmailVerified ??= false;

    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text(
              widget.type == 'hospital'
                  ? "Hospital Transport"
                  : "Local Transport",
              style: TextStyle(
                  fontSize: 17,
                  fontFamily: "notosan",
                  fontWeight: FontWeight.w600,
                  color: AppSharedPreferences.getTheme == 'ThemeCubitMode.dark'
                      ? Colors.white
                      : AppColors.blackLight)),
          centerTitle: true,
          backgroundColor:
              AppSharedPreferences.getTheme == 'ThemeCubitMode.dark'
                  ? Colors.transparent
                  : AppColors.backgroundColorLight,
          leading: Padding(
            padding: const EdgeInsets.symmetric(horizontal: kPadding),
            child: Align(
                alignment: Alignment.centerLeft,
                child: InkWell(
                  onTap: () {
                    if (isEmailVerified!) {
                      Navigator.pop(context);
                      Navigator.pop(context);
                      Navigator.pop(context);
                    } else {
                      Navigator.pop(context);
                    }
                  },
                  child: Icon(
                    Icons.arrow_back_ios_new,
                    color:
                        AppSharedPreferences.getTheme == 'ThemeCubitMode.dark'
                            ? Colors.white
                            : AppColors.backgroundColor,
                  ),
                )),
          ),
        ),
        body: LayoutBuilder(builder: (context, constraint) {
          return Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraint.maxHeight),
                child: IntrinsicHeight(
                  child: Column(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          widget.type == 'hospital'
                              ? const SizedBox(
                                  height: 15,
                                )
                              : Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: kPadding,
                                    vertical: kPadding,
                                  ),
                                  child: Center(
                                    child: CupertinoPageScaffold(
                                      child: Container(
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: AppColors.borderColor),
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: CupertinoSlidingSegmentedControl<
                                            String>(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 1, horizontal: 2),
                                          thumbColor: AppColors.gold,
                                          backgroundColor: Colors.white,
                                          children: {
                                            "No Return": Container(
                                              width: 350,
                                              height: 30,
                                              margin: const EdgeInsets.only(
                                                  top: 2,
                                                  right: 0,
                                                  left: 2,
                                                  bottom: 2),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(8)),
                                              child: Center(
                                                child: Text(
                                                  "One way",
                                                  style: TextStyle(
                                                      color: selectedTrip ==
                                                              'No Return'
                                                          ? AppColors.white
                                                          : AppColors
                                                              .backgroundColor,
                                                      fontWeight:
                                                          FontWeight.w700),
                                                ),
                                              ),
                                            ),
                                            "Other day return": Container(
                                              width: 350,
                                              height: 30,
                                              margin: const EdgeInsets.only(
                                                  top: 2,
                                                  right: 2,
                                                  left: 0,
                                                  bottom: 2),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(8)),
                                              child: Center(
                                                child: Text(
                                                  "Return",
                                                  style: TextStyle(
                                                      color: selectedTrip ==
                                                              'Other day return'
                                                          ? AppColors.white
                                                          : AppColors
                                                              .backgroundColor,
                                                      fontWeight:
                                                          FontWeight.w700),
                                                ),
                                              ),
                                            ),
                                          },
                                          groupValue: selectedTrip,
                                          onValueChanged: (value) {
                                            setState(() {
                                              selectedTrip = value;
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                          SelectPlaceWidget(
                            location: pickUpLocation,
                            showingList: placesList,
                            title: "Pickup Location",
                          ),
                          SelectDateAndTimeWidget(
                              time: time!,
                              timeController: timePicked!,
                              from: DateTime.now(),
                              validator: (value) {
                                if (value!.isNotEmpty) {
                                  DateFormat inputFormat =
                                      DateFormat("dd MMM yyyy");
                                  DateTime setUpdatedDate =
                                      inputFormat.parse(value);
                                  pickDate = setUpdatedDate;
                                } else {
                                  return '';
                                }

                                if (dateTime.isBefore(DateTime.now()) &&
                                    !dateTime.isSameDate(DateTime.now())) {
                                  return 'correct date please';
                                }
                                return Validator.requiredValidator(date!.text);
                              },
                              pickedDate: pickDate,
                              dateController: date!),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: kPadding, vertical: 6),
                            child: RebiInput(
                              hintText: 'Pickup contact name'.tra,
                              controller: pickUpContactName,
                              keyboardType: TextInputType.name,
                              textInputAction: TextInputAction.done,
                              autoValidateMode:
                                  AutovalidateMode.onUserInteraction,
                              isOptional: false,
                              color: AppColors.formsLabel,
                              readOnly: false,
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 13),
                              obscureText: false,
                              validator: (value) {
                                return Validator.requiredValidator(
                                    pickUpContactName.text);
                              },
                            ),
                          ),
                          PhoneNumberFieldWidget(
                              countryCode: pickUpCountryCode,
                              phoneNumber: pickUpContactNumber),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: kPadding),
                            child: CustomDivider(),
                          ),
                          widget.type == 'hospital'
                              ? Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: kPadding, vertical: 6),
                                  child: RebiInput(
                                    hintText: 'Select hospital'.tra,
                                    controller: selectHospital,
                                    keyboardType: TextInputType.name,
                                    textInputAction: TextInputAction.done,
                                    autoValidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    isOptional: false,
                                    color: AppColors.formsLabel,
                                    readOnly: true,
                                    onTap: () {
                                      showHospitalsAndPlacesBottomSheet(
                                          context: context,
                                          title: "Select Hospital",
                                          content: Column(
                                            children: [
                                              ListView.separated(
                                                shrinkWrap: true,
                                                itemCount: hospitals.length,
                                                separatorBuilder:
                                                    (context, index) {
                                                  return const CustomDivider();
                                                },
                                                itemBuilder: (context, index) {
                                                  return GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        selectedHospital =
                                                            hospitals[index];
                                                        selectHospital.text =
                                                            hospitals[index];

                                                        Navigator.pop(context);
                                                        Print(
                                                            "Selected hospital ${hospitals[index]}");
                                                        Print(
                                                            "hospital Name $selectedHospital");
                                                      });
                                                    },
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(hospitals[index])
                                                      ],
                                                    ),
                                                  );
                                                },
                                              ),
                                            ],
                                          ));
                                    },
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 13),
                                    obscureText: false,
                                    validator: (value) {
                                      return Validator.requiredValidator(
                                          selectHospital.text);
                                    },
                                  ),
                                )
                              : SelectPlaceWidget(
                                  location: dropLocation,
                                  showingList: placesList,
                                  title: "Drop Location",
                                ),
                          Padding(
                            padding: const EdgeInsets.only(
                                right: kPadding,
                                left: kPadding,
                                top: 6,
                                bottom: 6),
                            child: RebiInput(
                              hintText: 'Drop Contact Name'.tra,
                              controller: dropContactName,
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.done,
                              autoValidateMode:
                                  AutovalidateMode.onUserInteraction,
                              isOptional: false,
                              color: AppColors.formsLabel,
                              readOnly: false,
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 13),
                              obscureText: false,
                              validator: (value) {
                                return Validator.requiredValidator(
                                    dropContactName.text);
                              },
                            ),
                          ),
                          PhoneNumberFieldWidget(
                              countryCode: dropCountryCode,
                              phoneNumber: dropContactNumber),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: kPadding, vertical: 6),
                            child: RebiInput(
                              hintText: 'Number Of Horses'.tra,
                              controller: numberOfHorses,
                              keyboardType: TextInputType.number,
                              textInputAction: TextInputAction.done,
                              autoValidateMode:
                                  AutovalidateMode.onUserInteraction,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(2),
                                // Limit input to 2 characters
                                FilteringTextInputFormatter.digitsOnly,
                                // Only allow digits
                              ],
                              isOptional: false,
                              color: AppColors.formsLabel,
                              readOnly: false,
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 13),
                              obscureText: false,
                              needToMessage: true,
                              validator: (value) {
                                return Validator.validateHorseNumber(
                                    numberOfHorses.text);
                              },
                            ),
                          ),
                          widget.type == 'hospital'
                              ? const SizedBox()
                              : Visibility(
                                  visible: selectedTrip == 'No Return'
                                      ? false
                                      : true,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: kPadding, vertical: 6),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: RebiInput(
                                            hintText: 'Return Date'.tra,
                                            controller: expectedDate,
                                            keyboardType: TextInputType.name,
                                            textInputAction:
                                                TextInputAction.done,
                                            onTap: () {
                                              selectDate(
                                                context: context,
                                                from: pickDate.add(
                                                    const Duration(days: 1)),
                                                to: DateTime(2025, 1, 1),
                                                isSupportChangingYears: false,
                                                selectedOurDay: pickDate.add(
                                                    const Duration(days: 1)),
                                                controller: expectedDate!,
                                                focusDay: focusedDay,
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
                                            validator: (value) {
                                              DateFormat inputFormat =
                                                  DateFormat("dd MMM yyyy");
                                              DateTime setUpdatedDate =
                                                  inputFormat.parse(value!);
                                              exDropDate = setUpdatedDate;

                                              return Validator
                                                  .requiredValidator(
                                                      expectedDate?.text);
                                            },
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                          child: RebiInput(
                                            hintText:
                                                expectedTimePicked!.text.isEmpty
                                                    ? 'Return Time'
                                                    : expectedTimePicked?.text,
                                            controller: expectedTimePicked,
                                            onTap: () async {
                                              TimeOfDay? pickedTime =
                                                  await showTimePicker(
                                                confirmText: "Confirm".tra,
                                                context: context,
                                                cancelText: "Cancel".tra,
                                                initialEntryMode:
                                                    TimePickerEntryMode.dial,
                                                initialTime:
                                                    TimeOfDay.fromDateTime(
                                                        DateTime.utc(
                                                            0, 0, 0, 15, 0)),
                                              );

                                              Print(pickedTime);

                                              if (pickedTime != null) {
                                                expectedTime =
                                                    pickedTime.toDateTime();
                                                //output 10:51 PM
                                                String parsedTime =
                                                    pickedTime.format(context);

                                                setState(() {
                                                  expectedTimePicked?.text =
                                                      parsedTime;
                                                });
                                              } else {}
                                            },
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                    horizontal: 20,
                                                    vertical: 13),
                                            isOptional: false,
                                            readOnly: true,
                                            validator: (value) {
                                              if (value!.isNotEmpty &&
                                                  expectedPickDate
                                                      .isSameDate(pickDate) &&
                                                  expectedTime!
                                                      .isBefore(time!)) {
                                                return 'Correct time please';
                                              }
                                              // return Validator.requiredValidator(
                                              //     expectedTimePicked?.text);
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                        ],
                      ),
                      const Spacer(),
                      Padding(
                        padding:
                            const EdgeInsets.symmetric(horizontal: kPadding),
                        child: RebiButton(
                            onPressed: () {
                              Print("pick up location ${pickUpLocation.text}");
                              Print("PickDate ${pickDate.toString()}");
                              Print("PickTime ${timePicked!.text}");
                              Print("DropDate ${exDropDate.toString()}");
                              Print("DropTime ${expectedTimePicked!.text}");
                              pickPhoneNumber = pickUpCountryCode.text +
                                  pickUpContactNumber.text;
                              dropPhoneNumber =
                                  dropCountryCode.text + dropContactNumber.text;
                              if (widget.type == 'hospital') {
                                if (_formKey.currentState!.validate() &&
                                    selectedHospital != null &&
                                    numberOfHorses.text.isNotEmpty) {
                                  TripServiceDataModel tripServiceModel =
                                      TripServiceDataModel(
                                    expectedTime: expectedTimePicked?.text,
                                    expectedDate: exDropDate,
                                    pickupContactName: pickUpContactName.text,
                                    pickupContactNumber: pickPhoneNumber!,
                                    showingDate: date!.text,
                                    trip: 'hospital',
                                    dropContactName: dropContactName.text,
                                    dropContactNumber: dropContactNumber.text,
                                    hospitalName: selectedHospital,
                                    horsesNumber: numberOfHorses.text,
                                    tripType: selectedTrip!,
                                    pickupDate: pickDate,
                                    pickupTime: timePicked!.text,
                                    pickupLocation: pickUpLocation.text,
                                  );
                                  if (selectedTrip == "No Return") {
                                    Print("No Return");
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ChoseTripHorseScreen(
                                                  tripServiceDataModel:
                                                      tripServiceModel,
                                                )));
                                  } else {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ChoseTripHorseScreen(
                                                  tripServiceDataModel:
                                                      tripServiceModel,
                                                )));
                                  }
                                } else {
                                  RebiMessage.error(
                                      msg: "please fill all fields correctly",
                                      context: context);
                                }
                              } else {
                                if (_formKey.currentState!.validate() &&
                                    numberOfHorses.text.isNotEmpty) {
                                  TripServiceDataModel tripServiceModel =
                                      TripServiceDataModel(
                                    expectedTime: expectedTimePicked?.text,
                                    expectedDate: exDropDate,
                                    pickupContactName: pickUpContactName.text,
                                    pickupContactNumber: pickPhoneNumber!,
                                    trip: 'local',
                                    showingDate: date!.text,
                                    dropContactName: dropContactName.text,
                                    dropContactNumber: dropPhoneNumber!,
                                    dropLocation: dropLocation.text,
                                    horsesNumber: numberOfHorses.text,
                                    tripType: selectedTrip!,
                                    pickupDate: pickDate,
                                    pickupTime: timePicked!.text,
                                    pickupLocation: pickUpLocation.text,
                                  );
                                  if (selectedTrip == "No Return") {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ChoseTripHorseScreen(
                                                  tripServiceDataModel:
                                                      tripServiceModel,
                                                )));
                                  } else if ((selectedTrip ==
                                          "Other day return" &&
                                      exDropDate.isBefore(pickDate))) {
                                    RebiMessage.error(
                                        msg:
                                            "please enter the correct expected Date",
                                        context: context);
                                  } else {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ChoseTripHorseScreen(
                                                  tripServiceDataModel:
                                                      tripServiceModel,
                                                )));
                                  }
                                } else {
                                  RebiMessage.error(
                                      msg: "please fill all fields correctly",
                                      context: context);
                                }
                              }
                            },
                            child: const Text("Next")),
                      ),
                      const SizedBox(
                        height: 30,
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
