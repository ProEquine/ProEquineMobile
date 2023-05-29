import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:proequine/core/constants/routes/routes.dart';
import 'package:proequine/core/utils/extensions.dart';
import 'package:proequine/core/utils/printer.dart';

import '../../../../core/constants/colors/app_colors.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/constants/images/app_images.dart';
import '../../../../core/global_functions/date_time_picker.dart';
import '../../../../core/utils/sharedpreferences/SharedPreferencesHelper.dart';
import '../../../../core/utils/validator.dart';
import '../../../../core/widgets/rebi_button.dart';
import '../../../../core/widgets/rebi_input.dart';
import '../../../../core/widgets/verify_dialog.dart';
import '../../../profile/data/verify_email_route.dart';
import '../../../profile/presentation/widgets/drop_down_menu_widget.dart';
import '../widgets/create_trip_header.dart';
import 'local_summary.dart';

class CreateEventScreen extends StatefulWidget {
  @override
  _CreateEventScreenState createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends State<CreateEventScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController origin = TextEditingController();
  TextEditingController eventLocation = TextEditingController();
  TextEditingController eventTitle = TextEditingController();
  TextEditingController contact = TextEditingController();
  TextEditingController? date;
  late DateTime dateTime;
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
  late TextEditingController? timePicked;
  DateTime? time;
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
            Navigator.pushNamed(context, verifyEmail,arguments: VerifyEmailRoute(type: 'createEvent',email: AppSharedPreferences.userEmailAddress))
                .then((value) {});
          },);
        });
      }
    });
    date = TextEditingController();
    timePicked = TextEditingController();
    time = DateTime.utc(0, 0, 0, 15, 0);
    super.initState();
  }

  String? selectedNumber;
  String? selectedTrip;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CreateTripHeader(image: AppImages.eventTransport),
                const SizedBox(
                  height: 10,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: kPadding, vertical: 10),
                  child: Text(
                    "Event Request Transport",
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'notosan',
                        color: AppColors.white),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: kPadding, vertical: 10),
                  child: Text(
                    "Request an event that we aren’t covering",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'notosan',
                        color: Color(0xffD0D3D6)),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: kPadding, vertical: 10),
                  child: RebiInput(
                    hintText: 'Origin Location'.tra,
                    controller: origin,
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.done,
                    autoValidateMode: AutovalidateMode.onUserInteraction,
                    isOptional: false,
                    color: AppColors.formsLabel,
                    readOnly: false,
                    contentPadding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
                    obscureText: false,
                    validator: (value) {
                      return Validator.requiredValidator(origin.text);
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: kPadding, vertical: 10),
                  child: RebiInput(
                    hintText: 'Event Location'.tra,
                    controller: eventLocation,
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.done,
                    autoValidateMode: AutovalidateMode.onUserInteraction,
                    isOptional: false,
                    color: AppColors.formsLabel,
                    readOnly: false,
                    contentPadding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
                    obscureText: false,
                    validator: (value) {
                      return Validator.requiredValidator(eventLocation.text);
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: kPadding, vertical: 10),
                  child: RebiInput(
                    hintText: 'Event Title'.tra,
                    controller: eventTitle,
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.done,
                    autoValidateMode: AutovalidateMode.onUserInteraction,
                    isOptional: false,
                    color: AppColors.formsLabel,
                    readOnly: false,
                    contentPadding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
                    obscureText: false,
                    validator: (value) {
                      return Validator.requiredValidator(eventTitle.text);
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
                          autoValidateMode: AutovalidateMode.onUserInteraction,
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
                              // helpText: StringKeys.selectTime.tr(),
                              // errorInvalidText:StringKeys.timeError.tr(),
                              // hourLabelText: StringKeys.hour.tr(),
                              // minuteLabelText: StringKeys.minute.tr(),
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
                  padding: EdgeInsets.symmetric(
                      horizontal: kPadding, vertical: 10),
                  child: DropDownWidget(
                    items: numberOfHorses,
                    selected: selectedNumber,
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
                    items: tripType,
                    selected: selectedTrip,
                    validator: (value) {
                      // return Validator.requiredValidator(selectedNumber);
                    },
                    hint: 'Trip type',
                  ),
                ),
                Padding(
                  padding:
                  const EdgeInsets.symmetric(
                      vertical: kPadding, horizontal: kPadding),
                  child: RebiButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LocalSummary()));
                        } else {
                          Print("not verified");
                        }
                      },
                      backgroundColor: AppColors.white,
                      child: const Text("Book")),
                )
              ],
            ),
          ),
        ),
      );
    }
  }
