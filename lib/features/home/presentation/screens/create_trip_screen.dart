import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:proequine/core/constants/colors/app_colors.dart';
import 'package:proequine/core/constants/constants.dart';
import 'package:proequine/core/constants/images/app_images.dart';
import 'package:proequine/core/constants/routes/routes.dart';
import 'package:proequine/core/utils/extensions.dart';
import 'package:proequine/core/utils/rebi_message.dart';
import 'package:proequine/features/home/presentation/screens/local_summary.dart';
import 'package:proequine/features/home/presentation/widgets/create_trip_header.dart';

import '../../../../core/global_functions/date_time_picker.dart';
import '../../../../core/utils/Printer.dart';
import '../../../../core/utils/sharedpreferences/SharedPreferencesHelper.dart';
import '../../../../core/utils/validator.dart';
import '../../../../core/widgets/rebi_button.dart';
import '../../../../core/widgets/rebi_input.dart';
import '../../../../core/widgets/verify_dialog.dart';
import '../../../profile/data/verify_email_route.dart';
import '../../../profile/presentation/widgets/drop_down_menu_widget.dart';

class CreateTripScreen extends StatefulWidget {
  String? type;

  CreateTripScreen({super.key, this.type});

  @override
  _CreateTripScreenState createState() => _CreateTripScreenState();
}

class _CreateTripScreenState extends State<CreateTripScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController origin = TextEditingController();
  TextEditingController destination = TextEditingController();
  TextEditingController contact = TextEditingController();
  TextEditingController comment = TextEditingController();
  TextEditingController? date;
  TextEditingController? expectedDate;
  bool isWithoutReturn = false;
  bool isInSameDay = false;
  late DateTime dateTime;
  late DateTime expectedDateTime;
  List<DropdownMenuItem<String>> tripType = [
    const DropdownMenuItem(
      value: "No Return",
      child: Text("No return"),
    ),
    const DropdownMenuItem(
      value: "Same day return",
      child: Text("Same day return"),
    ),
    const DropdownMenuItem(
      value: "Other day return",
      child: Text("Other day return"),
    ),
  ];
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
    if(AppSharedPreferences.getEmailVerified!){
      return true;
    }else{
      await Future.delayed(const Duration(milliseconds: 50)); // Simulating an asynchronous call
      return false;
    }
  }

  @override
  void initState() {
    checkVerificationStatus().then((verified) {
      if (!verified) {
        // If the account is not verified, show a dialog after a delay.
        Future.delayed(const Duration(milliseconds: 50), () {
          showUnverifiedAccountDialog(context: context, isThereNavigationBar: true,onPressVerify: () {
            Navigator.pushNamed(context, verifyEmail, arguments: VerifyEmailRoute(type: 'createTrip',email: AppSharedPreferences.userEmailAddress))
                .then((value) {});
          },);
        });
      }
    });
    date = TextEditingController();
    expectedDate = TextEditingController();
    timePicked = TextEditingController();
    expectedTimePicked = TextEditingController();
    time = DateTime.utc(0, 0, 0, 15, 0);
    expectedTime = DateTime.utc(0, 0, 0, 15, 0);
    //set the initial value of text field
    // timePicked?.text=convertToTime(time!);
    super.initState();
  }

  String? selectedNumber;
  String? selectedTrip;

  @override
  Widget build(BuildContext context) {

      return Scaffold(
        body: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CreateTripHeader(
                  image: widget.type == 'hospital'
                      ? AppImages.hospitalTransport
                      : AppImages.localTransport),
              SizedBox(
                height: 360.0, //Your custom height
                child: SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: kPadding, vertical: 10),
                          child: Text(
                            widget.type == 'hospital'
                                ? "Hospital Transport"
                                : "Local Transport",
                            style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'notosan',
                                color: AppColors.white),
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
                            autoValidateMode: AutovalidateMode
                                .onUserInteraction,
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
                            autoValidateMode: AutovalidateMode
                                .onUserInteraction,
                            isOptional: false,
                            color: AppColors.formsLabel,
                            readOnly: false,
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 13),
                            obscureText: false,
                            validator: (value) {
                              return Validator.requiredValidator(
                                  destination.text);
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
                                    showDate(context, (value) {
                                      setState(() {
                                        dateTime = value!;

                                        final DateFormat formatter =
                                        DateFormat('dd MMM yyyy');
                                        final String formatted =
                                        formatter.format(dateTime);
                                        date?.text = formatted;
                                      });
                                    });
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
                                    if (dateTime.isBefore(DateTime.now()) &&
                                        !dateTime.isSameDate(DateTime.now())) {
                                      return 'correct date please';
                                    }
                                    return Validator.requiredValidator(
                                        date?.text);
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
                                      // helpText: StringKeys.selectTime.tr(),
                                      // errorInvalidText:StringKeys.timeError.tr(),
                                      // hourLabelText: StringKeys.hour.tr(),
                                      // minuteLabelText: StringKeys.minute.tr(),
                                      initialEntryMode: TimePickerEntryMode
                                          .dial,
                                      initialTime: TimeOfDay.fromDateTime(
                                          DateTime.utc(0, 0, 0, 15, 0)),
                                    );

                                    Print(pickedTime);

                                    if (pickedTime != null) {
                                      time = pickedTime.toDateTime();
                                      //output 10:51 PM
                                      String parsedTime =
                                      pickedTime.format(context);

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
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: kPadding, vertical: 10),
                          child: DropDownWidget(
                            onChanged: (tripType) {
                              setState(() {
                                selectedTrip = tripType;
                                Print('selected trip$selectedTrip');
                              });
                            },
                            items: tripType,
                            selected: selectedTrip,
                            validator: (value) {},
                            hint: 'Trip type',
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
                                TimeOfDay? pickedTime =
                                await showTimePicker(
                                  confirmText: "Confirm".tra,
                                  context: context,
                                  cancelText: "Cancel".tra,
                                  // helpText: StringKeys.selectTime.tr(),
                                  // errorInvalidText:StringKeys.timeError.tr(),
                                  // hourLabelText: StringKeys.hour.tr(),
                                  // minuteLabelText: StringKeys.minute.tr(),
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
                                    expectedDateTime.isSameDate(dateTime) &&
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
                                      showDate(context, (value) {
                                        setState(() {
                                          expectedDateTime = value!;

                                          final DateFormat formatter =
                                          DateFormat('dd MMM yyyy');
                                          final String formatted = formatter
                                              .format(expectedDateTime);
                                          expectedDate?.text = formatted;
                                        });
                                      });
                                    },
                                    autoValidateMode:
                                    AutovalidateMode.onUserInteraction,
                                    isOptional: false,
                                    color: AppColors.formsLabel,
                                    readOnly: true,
                                    contentPadding:
                                    const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 13),
                                    obscureText: false,
                                    validator: (value) {
                                      if (value!.isNotEmpty &&
                                          expectedDateTime
                                              .isBefore(dateTime)) {
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
                                    hintText:
                                    expectedTimePicked!.text.isEmpty
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
                                        horizontal: 20, vertical: 13),
                                    isOptional: false,
                                    readOnly: true,
                                    validator: (value) {
                                      if (value!.isNotEmpty &&
                                          expectedDateTime
                                              .isSameDate(dateTime) &&
                                          expectedTime!.isBefore(time!)) {
                                        return 'Correct time please';
                                      }
                                      // return  Validator.requiredValidator(expectedTimePicked?.text);
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
                          child: RebiInput(
                            hintText: 'Contact number'.tra,
                            controller: contact,
                            keyboardType: TextInputType.phone,
                            textInputAction: TextInputAction.done,
                            autoValidateMode: AutovalidateMode
                                .onUserInteraction,
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
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: kPadding, vertical: 10),
                          child: RebiInput(
                            hintText: 'Comment'.tra,
                            controller: comment,
                            keyboardType: TextInputType.phone,
                            textInputAction: TextInputAction.done,
                            autoValidateMode: AutovalidateMode
                                .onUserInteraction,
                            isOptional: true,
                            color: AppColors.formsLabel,
                            readOnly: false,
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 13),
                            obscureText: false,
                            validator: (value) {},
                          ),
                        ),
                      ]),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: kPadding, horizontal: kPadding),
                child: RebiButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate() &&
                          selectedTrip != null &&
                          selectedNumber != null) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LocalSummary()));
                      } else {
                        RebiMessage.error(msg: "please fill all fields",context: context);
                      }
                    },
                    backgroundColor: AppColors.white,
                    child: const Text("Book")),
              )
            ],
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

