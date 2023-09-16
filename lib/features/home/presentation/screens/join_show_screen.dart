import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:proequine/core/constants/colors/app_colors.dart';
import 'package:proequine/core/constants/constants.dart';
import 'package:proequine/core/utils/extensions.dart';
import 'package:proequine/core/utils/rebi_message.dart';
import 'package:proequine/core/widgets/phone_number_field_widget.dart';
import 'package:proequine/features/home/presentation/widgets/select_date_time_widget.dart';
import 'package:proequine/features/home/presentation/widgets/select_place_form_widget.dart';

import '../../../../core/global_functions/global_statics_drop_down.dart';
import '../../../../core/utils/Printer.dart';
import '../../../../core/utils/sharedpreferences/SharedPreferencesHelper.dart';
import '../../../../core/utils/validator.dart';
import '../../../../core/widgets/rebi_button.dart';
import '../../../../core/widgets/rebi_input.dart';
import '../../../../core/widgets/drop_down_menu_widget.dart';
import '../../data/join_show_request_model.dart';
import '../widgets/select_place_widget.dart';
import 'chose_horses_shows_screen.dart';

class JoinShowScreen extends StatefulWidget {
  final String? type;

  const JoinShowScreen({super.key, this.type});

  @override
  JoinShowScreenState createState() => JoinShowScreenState();
}

class JoinShowScreenState extends State<JoinShowScreen>
    with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController pickUpLocation = TextEditingController();
  TextEditingController pickUpContactName = TextEditingController();
  TextEditingController dropContactName = TextEditingController();
  TextEditingController pickUpContactNumber = TextEditingController();
  TextEditingController pickUpCountryCode = TextEditingController(text: '+971');
  DateTime focusedDay = DateTime.now();
  TextEditingController? date;
  late DateTime dateTime;

  late DateTime pickDate;

  String convertToTime(DateTime dateTime) {
    final time = DateFormat.Hm().format(dateTime);
    return time;
  }

  DateTime? time;
  late TextEditingController? timePicked;

  String? selectedTrip;
  String? selectedHospital;
  String? selectedPlace;

  @override
  void initState() {
    initializeDateFormatting();
    pickDate = DateTime.now();
    dateTime = DateTime.now();
    date = TextEditingController();
    timePicked = TextEditingController();
    time = DateTime.utc(0, 0, 0, 15, 0);
    selectedTrip = "Other day return";

    super.initState();
  }

  String selectedFilter = "All";

  @override
  void dispose() {
    date?.dispose();
    timePicked?.dispose();
    super.dispose();
  }

  String? selectedNumber;
  String? pickupPhoneNumber;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("Show Transport",
            style: TextStyle(
                fontSize: 17,
                fontFamily: "notosan",
                fontWeight: FontWeight.w600,
                color: AppSharedPreferences.getTheme == 'ThemeCubitMode.dark'
                    ? Colors.white
                    : AppColors.blackLight)),
        centerTitle: true,
        backgroundColor: AppSharedPreferences.getTheme == 'ThemeCubitMode.dark'
            ? Colors.transparent
            : AppColors.backgroundColorLight,
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: kPadding),
          child: Align(
              alignment: Alignment.centerLeft,
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.arrow_back_ios_new,
                  color: AppSharedPreferences.getTheme == 'ThemeCubitMode.dark'
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
                        SelectPlaceWidget(
                          showingList: placesList,
                          location: pickUpLocation,
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
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: kPadding, vertical: 6),
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
                      ],
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: kPadding),
                      child: RebiButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate() &&
                                selectedNumber != null) {
                              pickupPhoneNumber = pickUpCountryCode.text +
                                  pickUpContactNumber.text;
                              JoinShowTransportRequestModel joinShowModel =
                                  JoinShowTransportRequestModel(
                                pickupContactName: pickUpContactName.text,
                                pickupContactNumber: pickupPhoneNumber!,
                                trip: 'Show Transport',
                                showingDate: date!.text,
                                horsesNumber: selectedNumber!,
                                tripType: 'On Way',
                                pickupDate: pickDate,
                                pickupTime: timePicked!.text,
                                pickupLocation: pickUpLocation.text,
                              );
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ChoseShowsHorseScreen(
                                            joinShowTransportRequestModel:
                                                joinShowModel,
                                          )));
                            } else {
                              RebiMessage.error(
                                  msg: "please fill all fields correctly",
                                  context: context);
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
    );
  }
}
