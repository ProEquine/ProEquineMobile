import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:proequine/core/constants/colors/app_colors.dart';
import 'package:proequine/core/constants/constants.dart';
import 'package:proequine/core/constants/images/app_images.dart';
import 'package:proequine/core/utils/extensions.dart';
import 'package:proequine/core/utils/rebi_message.dart';
import 'package:proequine/features/home/data/form_data_model.dart';
import 'package:proequine/features/home/presentation/screens/local_summary.dart';
import 'package:proequine/features/home/presentation/widgets/create_trip_header.dart';

import '../../../../core/utils/Printer.dart';
import '../../../../core/utils/sharedpreferences/SharedPreferencesHelper.dart';
import '../../../../core/utils/validator.dart';
import '../../../../core/widgets/date_time_picker.dart';
import '../../../../core/widgets/rebi_button.dart';
import '../../../../core/widgets/rebi_input.dart';
import '../../../profile/presentation/widgets/drop_down_menu_widget.dart';

class CreateTripScreen extends StatefulWidget {
  final String? type;

  const CreateTripScreen({super.key, this.type});

  @override
  CreateTripScreenState createState() => CreateTripScreenState();
}

class CreateTripScreenState extends State<CreateTripScreen>
    with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController origin = TextEditingController();
  TextEditingController destination = TextEditingController();
  TextEditingController contact = TextEditingController();
  TextEditingController comment = TextEditingController();
  TextEditingController countryCode = TextEditingController(text: '+971');
  DateTime focusedDay = DateTime.now();
  TextEditingController? date;
  TextEditingController? expectedDate;
  bool isWithoutReturn = false;
  bool isInSameDay = false;
  late DateTime dateTime;
  late DateTime expectedDateTime;
  late DateTime pickDate;
  late DateTime expectedPickDate;
  List<DropdownMenuItem<String>> numberOfHorses = [
    const DropdownMenuItem(
      value: "1",
      child: Text("1"),
    ),
    const DropdownMenuItem(
      value: "2",
      child: Text("2"),
    ),
    const DropdownMenuItem(
      value: "3",
      child: Text("3"),
    ),
    const DropdownMenuItem(
      value: "4",
      child: Text("4"),
    ),
  ];

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
                      : Colors.black)),
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
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: kPadding),
                  child: CreateTripHeader(
                      image: widget.type == 'hospital'
                          ? AppImages.hospitalTransport
                          : AppImages.localTransport),
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: kPadding,
                      vertical: kPadding,
                    ),
                    child: Center(
                      child: CupertinoPageScaffold(
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: CupertinoSlidingSegmentedControl<String>(
                            padding: const EdgeInsets.symmetric(
                                vertical: 2, horizontal: 3),
                            thumbColor: AppColors.yellow,
                            backgroundColor: Colors.white,
                            children: {
                              "No Return": Container(
                                width: 330,
                                height: 35,
                                margin: const EdgeInsets.only(
                                    top: 2, right: 0, left: 2, bottom: 2),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8)),
                                child: Center(
                                  child: Text(
                                    "One way",
                                    style: TextStyle(
                                        color: selectedTrip == 'No Return'
                                            ? AppColors.white
                                            : AppColors.backgroundColor,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                              ),
                              "Other day return": Container(
                                width: 330,
                                height: 35,
                                margin: const EdgeInsets.only(
                                    top: 2, right: 2, left: 0, bottom: 2),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8)),
                                child: Center(
                                  child: Text(
                                    "Return",
                                    style: TextStyle(
                                        color:
                                            selectedTrip == 'Other day return'
                                                ? AppColors.white
                                                : AppColors.backgroundColor,
                                        fontWeight: FontWeight.w700),
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
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: kPadding, vertical: 10),
                  child: RebiInput(
                    hintText: 'Origin'.tra,
                    controller: origin,
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.done,
                    autoValidateMode: AutovalidateMode.onUserInteraction,
                    isOptional: false,
                    color: AppColors.formsLabel,
                    readOnly: false,
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 13),
                    obscureText: false,
                    validator: (value) {
                      return Validator.requiredValidator(origin.text);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: kPadding, vertical: 10),
                  child: RebiInput(
                    hintText: 'Destination'.tra,
                    controller: destination,
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.done,
                    autoValidateMode: AutovalidateMode.onUserInteraction,
                    isOptional: false,
                    color: AppColors.formsLabel,
                    readOnly: false,
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 13),
                    obscureText: false,
                    validator: (value) {
                      return Validator.requiredValidator(destination.text);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: kPadding, vertical: 10),
                  child: Row(
                    children: [
                      Expanded(
                        child: RebiInput(
                          hintText: 'Date'.tra,
                          controller: date,
                          keyboardType: TextInputType.name,
                          textInputAction: TextInputAction.done,
                          onTap: () {
                            selectDate(
                              context: context,
                              from: DateTime.now(),
                              to: DateTime(2025, 1, 1),
                              isSupportChangingYears: false,
                              selectedOurDay: dateTime,
                              controller: date!,
                              focusDay: focusedDay,
                            );
                          },
                          autoValidateMode: AutovalidateMode.onUserInteraction,
                          isOptional: false,
                          color: AppColors.formsLabel,
                          readOnly: true,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 13),
                          obscureText: false,
                          validator: (value) {
                            if (value!.isNotEmpty) {
                              DateFormat inputFormat =
                                  DateFormat("dd MMM yyyy");
                              DateTime setUpdatedDate =
                                  inputFormat.parse(value);
                              pickDate = setUpdatedDate;
                            } else {
                              return 'please select date';
                            }

                            if (dateTime.isBefore(DateTime.now()) &&
                                !dateTime.isSameDate(DateTime.now())) {
                              return 'correct date please';
                            }
                            return Validator.requiredValidator(date?.text);
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: RebiInput(
                          hintText: timePicked!.text.isEmpty
                              ? 'Time'
                              : timePicked?.text,
                          controller: timePicked,
                          onTap: () async {
                            TimeOfDay? pickedTime = await showTimePicker(
                              confirmText: "Confirm".tra,
                              context: context,
                              cancelText: "Cancel".tra,
                              initialEntryMode: TimePickerEntryMode.dial,
                              initialTime: TimeOfDay.fromDateTime(
                                  DateTime.utc(0, 0, 0, 15, 0)),
                            );

                            Print(pickedTime);

                            if (pickedTime != null) {
                              time = pickedTime.toDateTime();
                              //output 10:51 PM
                              String parsedTime = pickedTime.format(context);

                              setState(() {
                                timePicked?.text = parsedTime;
                              });
                            } else {}
                          },
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 13),
                          isOptional: false,
                          readOnly: true,
                          validator: (value) {
                            // return  Validator.requiredValidator(timePicked?.text);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: kPadding, vertical: 10),
                  child: DropDownWidget(
                    items: numberOfHorses,
                    selected: selectedNumber,
                    onChanged: (numberSelected) {
                      setState(() {
                        selectedNumber = numberSelected;
                        Print('selectedNumber$selectedNumber');
                      });
                    },
                    validator: (value) {
                      // return Validator.requiredValidator(selectedNumber);
                    },
                    hint: 'Number of horses',
                  ),
                ),
                Visibility(
                  visible: selectedTrip == 'No Return' ? false : true,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: kPadding, vertical: 10),
                    child: selectedTrip == 'Same day return'
                        ? RebiInput(
                            hintText: expectedTimePicked!.text.isEmpty
                                ? 'Time'
                                : expectedTimePicked?.text,
                            controller: expectedTimePicked,
                            onTap: () async {
                              TimeOfDay? pickedTime = await showTimePicker(
                                confirmText: "Confirm".tra,
                                context: context,
                                cancelText: "Cancel".tra,
                                initialEntryMode: TimePickerEntryMode.dial,
                                initialTime: TimeOfDay.fromDateTime(
                                    DateTime.utc(0, 0, 0, 15, 0)),
                              );

                              Print(pickedTime);

                              if (pickedTime != null) {
                                expectedTime = pickedTime.toDateTime();
                                String parsedTime = pickedTime.format(context);

                                setState(() {
                                  expectedTimePicked?.text = parsedTime;
                                });
                              } else {}
                            },
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 13),
                            isOptional: false,
                            readOnly: true,
                            validator: (value) {
                              if (value!.isNotEmpty &&
                                  expectedPickDate.isSameDate(pickDate) &&
                                  expectedTime!.isBefore(time!)) {
                                return 'Correct time please';
                              }
                              // return  Validator.requiredValidator(expectedTimePicked?.text);
                            },
                          )
                        : Row(
                            children: [
                              Expanded(
                                child: RebiInput(
                                  hintText: 'Expected Date'.tra,
                                  controller: expectedDate,
                                  keyboardType: TextInputType.name,
                                  textInputAction: TextInputAction.done,
                                  onTap: () {
                                    selectDate(
                                      context: context,
                                      from:
                                          pickDate.add(const Duration(days: 1)),
                                      to: DateTime(2025, 1, 1),
                                      isSupportChangingYears: false,
                                      selectedOurDay:
                                          pickDate.add(const Duration(days: 1)),
                                      controller: expectedDate!,
                                      focusDay: focusedDay,
                                    );
                                  },
                                  autoValidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  isOptional: false,
                                  color: AppColors.formsLabel,
                                  readOnly: true,
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 13),
                                  obscureText: false,
                                  validator: (value) {
                                    if (value!.isNotEmpty) {
                                      DateFormat inputFormat =
                                          DateFormat("dd MMM yyyy");
                                      DateTime setUpdatedDate =
                                          inputFormat.parse(value);
                                      expectedPickDate = setUpdatedDate;
                                    } else {
                                      return "please select date";
                                    }

                                    if (value.isNotEmpty &&
                                        (expectedPickDate.isBefore(pickDate) ||
                                            expectedPickDate
                                                .isAtSameMomentAs(pickDate))) {
                                      return "Correct date please".tra;
                                    } else {}
                                    return Validator.requiredValidator(
                                        expectedDate?.text);
                                  },
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: RebiInput(
                                  hintText: expectedTimePicked!.text.isEmpty
                                      ? 'Time'
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
                                      initialTime: TimeOfDay.fromDateTime(
                                          DateTime.utc(0, 0, 0, 15, 0)),
                                    );

                                    Print(pickedTime);

                                    if (pickedTime != null) {
                                      expectedTime = pickedTime.toDateTime();
                                      //output 10:51 PM
                                      String parsedTime =
                                          pickedTime.format(context);

                                      setState(() {
                                        expectedTimePicked?.text = parsedTime;
                                      });
                                    } else {}
                                  },
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 13),
                                  isOptional: false,
                                  readOnly: true,
                                  validator: (value) {
                                    if (value!.isNotEmpty &&
                                        expectedPickDate.isSameDate(pickDate) &&
                                        expectedTime!.isBefore(time!)) {
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
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: kPadding, vertical: 10),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: RebiInput(
                          hintText: 'CC'.tra,
                          controller: countryCode,
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.done,
                          autoValidateMode: AutovalidateMode.onUserInteraction,
                          isOptional: false,
                          color: AppColors.formsLabel,
                          readOnly: true,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 13),
                          obscureText: false,
                          validator: (value) {
                            return Validator.countryCodeValidator(
                                countryCode.text);
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        flex: 3,
                        child: RebiInput(
                          hintText: 'Contact number'.tra,
                          controller: contact,
                          keyboardType: TextInputType.phone,
                          textInputAction: TextInputAction.done,
                          autoValidateMode: AutovalidateMode.onUserInteraction,
                          isOptional: false,
                          color: AppColors.formsLabel,
                          readOnly: false,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 13),
                          obscureText: false,
                          validator: (value) {
                            return Validator.phoneValidator(contact.text);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      right: kPadding, left: kPadding, top: 10, bottom: 20),
                  child: RebiInput(
                    hintText: 'Comment'.tra,
                    controller: comment,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.done,
                    autoValidateMode: AutovalidateMode.onUserInteraction,
                    isOptional: true,
                    color: AppColors.formsLabel,
                    readOnly: false,
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 13),
                    obscureText: false,
                    validator: (value) {},
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: kPadding),
                  child: RebiButton(
                      onPressed: () {
                        Duration timeDifference =
                            expectedTime!.difference(time!);

                        bool isOneHourAfter = timeDifference.inHours >= 1;

                        if (_formKey.currentState!.validate() &&
                            selectedTrip != null &&
                            selectedNumber != null) {
                          DateFormat inputFormat = DateFormat("dd MMM yyyy");
                          String formatedDate = inputFormat.format(pickDate);
                          String expectedDateFormated =
                              inputFormat.format(expectedPickDate);

                          FromDataModel fromData = FromDataModel(
                            origin: origin.text,
                            destination: destination.text,
                            contact:
                                '${"${countryCode.text} ${contact.text}"} ',
                            comment: comment.text,
                            date: formatedDate,
                            expectedDate: expectedDateFormated,
                            tripType: selectedTrip,
                            numberOfHorses: selectedNumber,
                            time: timePicked?.text,
                            expectedTime: expectedTimePicked?.text,
                          );
                          if (selectedTrip == "No Return") {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LocalSummary(
                                          formData: fromData,
                                        )));
                          } else if ((selectedTrip == "Other day return" &&
                              expectedPickDate.isBefore(pickDate))) {
                            RebiMessage.error(
                                msg: "please enter the correct expected Date",
                                context: context);
                          } else if ((selectedTrip == "Same day return" &&
                                  expectedTime!.isAfter(time!) &&
                                  isOneHourAfter) ||
                              (selectedTrip == "Other day return" &&
                                  expectedPickDate.isAfter(pickDate))) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LocalSummary(
                                          formData: fromData,
                                        )));
                          } else {
                            RebiMessage.error(
                                msg: "please enter the correct expected Time",
                                context: context);
                          }
                        } else {
                          RebiMessage.error(
                              msg: "please fill all fields correctly",
                              context: context);
                        }
                      },
                      backgroundColor:
                          AppSharedPreferences.getTheme == 'ThemeCubitMode.dark'
                              ? AppColors.white
                              : AppColors.backgroundColor,
                      child: const Text("Book")),
                ),
                const SizedBox(
                  height: 40,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget buildDropDownField({
  required String text,
  required VoidCallback onClick,
  required BuildContext context,
}) =>
    Theme(
        data: Theme.of(context).copyWith(
          timePickerTheme: TimePickerTheme.of(context).copyWith(),
          primaryColor: AppColors.gold, //color you want at header
          buttonTheme: ButtonTheme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
                secondary: AppColors
                    .gold // Color you want for action buttons (CANCEL and OK)
                ),
          ),
        ),
        child: Builder(
            builder: (context) => InkWell(
                onTap: () {
                  onClick();
                },
                child: ListTile(
                  title: Text(text),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: kPadding),
                  selectedColor: AppColors.gold,
                  iconColor: AppColors.gold,
                  trailing: const Icon(Icons.arrow_drop_down),
                ))));
