import 'package:country_picker/country_picker.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:proequine/core/constants/colors/app_colors.dart';
import 'package:proequine/core/constants/constants.dart';
import 'package:proequine/core/utils/extensions.dart';
import 'package:proequine/core/utils/rebi_message.dart';
import 'package:proequine/features/home/presentation/widgets/hospital_bottom_sheet.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/global_functions/global_statics_drop_down.dart';
import '../../../../core/utils/Printer.dart';
import '../../../../core/utils/sharedpreferences/SharedPreferencesHelper.dart';
import '../../../../core/utils/validator.dart';
import '../../../../core/widgets/date_time_picker.dart';
import '../../../../core/widgets/divider.dart';
import '../../../../core/widgets/rebi_button.dart';
import '../../../../core/widgets/rebi_input.dart';
import '../../../../core/widgets/drop_down_menu_widget.dart';
import '../../data/join_show_request_model.dart';
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
  TextEditingController? expectedDate;
  late DateTime dateTime;

  late DateTime pickDate;


  String convertToTime(DateTime dateTime) {
    final time = DateFormat.Hm().format(dateTime);
    return time;
  }

  List<String> filteredEmirates = [
    'All',
    'AUD',
    'DXB',
    'SHJ',
    'AUJ',
    'UAQ',
    'RKT',
    'FJR',
  ];
  List<String> places = [
    'ADEC - Abu Dhabi Equestrian Club',
    'AESGC - Al Ain Equestrian',
    'ABEC - Al Bahiya Equestrian Club',
    'AFISR - AL Forsan International Sports Resort',
    'BEAC - Boudheib Equestrian Academy',
    'SCEC - Sustainable City Equestrian Club',
    'SERC - Sharjah Equestrian and Racing Club',
    'EEC - Emirates Equestrian Center',
    'FSEC - Fujairah Shooting and Equestrian Club Kalba',
    'SERC - Sharjah Equestrian and Racing Club',
  ];

  int selectedIndex = 0;

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
    expectedDate = TextEditingController();
    timePicked = TextEditingController();
    time = DateTime.utc(0, 0, 0, 15, 0);
    selectedTrip = "Other day return";

    super.initState();
  }


  String selectedFilter = "All";


  @override
  void dispose() {
    date?.dispose();
    expectedDate?.dispose();
    timePicked?.dispose();
    super.dispose();
  }

  String? selectedNumber;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
            "Show Transport",
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
                  Navigator.pop(context);
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
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: kPadding, vertical: 6),
                          child: RebiInput(
                            hintText: 'Pickup Location'.tra,
                            controller: pickUpLocation,
                            keyboardType: TextInputType.name,
                            textInputAction: TextInputAction.done,
                            autoValidateMode:
                            AutovalidateMode.onUserInteraction,
                            isOptional: false,
                            color: AppColors.formsLabel,
                            onTap: () {
                              showHospitalsAndPlacesBottomSheet(
                                  context: context,
                                  title: "Select Place",
                                  content: SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 25,
                                          child: StatefulBuilder(
                                              builder:
                                                  (context, setState) {
                                                return ListView.builder(
                                                  shrinkWrap: true,
                                                  scrollDirection:
                                                  Axis.horizontal,
                                                  itemCount:
                                                  filteredEmirates
                                                      .length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    bool isSelected =
                                                        filteredEmirates[
                                                        index] ==
                                                            selectedFilter;
                                                    return GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          selectedFilter =
                                                          filteredEmirates[
                                                          index];
                                                        });
                                                        print(
                                                            selectedFilter);
                                                        print(
                                                            filteredEmirates[
                                                            index]);
                                                      },
                                                      child: Container(
                                                        width: 70,
                                                        // Adjust the width as needed
                                                        margin:
                                                        const EdgeInsets
                                                            .symmetric(
                                                            horizontal:
                                                            10),
                                                        decoration:
                                                        ShapeDecoration(
                                                          color: isSelected
                                                              ? AppColors
                                                              .yellow
                                                              : AppColors
                                                              .backgroundColorLight,
                                                          shape:
                                                          RoundedRectangleBorder(
                                                            side: const BorderSide(
                                                                width: 0.50,
                                                                color: AppColors
                                                                    .borderColor),
                                                            borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                10),
                                                          ),
                                                        ),
                                                        child: Center(
                                                          child: Text(
                                                            filteredEmirates[
                                                            index],
                                                            style:
                                                            TextStyle(
                                                              color: isSelected
                                                                  ? AppColors
                                                                  .whiteLight
                                                                  : AppColors
                                                                  .yellow,
                                                              fontSize: 10,
                                                              fontWeight:
                                                              FontWeight
                                                                  .w500,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                );
                                              }),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        ListView.separated(
                                          shrinkWrap: true,
                                          physics:
                                          NeverScrollableScrollPhysics(),
                                          itemCount: places.length,
                                          separatorBuilder:
                                              (context, index) {
                                            return const CustomDivider();
                                          },
                                          itemBuilder:
                                              (context, index) {
                                            return GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  selectedPlace =
                                                  places[index];
                                                  pickUpLocation.text =
                                                  places[index];

                                                  Navigator.pop(
                                                      context);
                                                  Print(
                                                      "Selected Place ${places[index]}");
                                                  Print(
                                                      "Place Name $selectedPlace");
                                                });
                                              },
                                              child: ListTile(
                                                minVerticalPadding: 10,
                                                title:
                                                Text(places[index]),
                                              ),
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ));
                            },
                            readOnly: true,
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 13),
                            obscureText: false,
                            validator: (value) {
                              return Validator.requiredValidator(
                                  pickUpLocation.text);
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: kPadding, vertical: 6),
                          child: Row(
                            children: [
                              Expanded(
                                child: RebiInput(
                                  hintText: 'Pickup date'.tra,
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
                                      pickDate = setUpdatedDate;
                                    } else {
                                      return 'please select date';
                                    }

                                    if (dateTime.isBefore(DateTime.now()) &&
                                        !dateTime
                                            .isSameDate(DateTime.now())) {
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
                                      ? 'Pickup time'
                                      : timePicked?.text,
                                  controller: timePicked,
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
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: kPadding, vertical: 7),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: RebiInput(
                                  hintText: 'CC'.tra,
                                  controller: pickUpCountryCode,
                                  keyboardType: TextInputType.number,
                                  textInputAction: TextInputAction.done,
                                  autoValidateMode:
                                  AutovalidateMode.onUserInteraction,
                                  onTap: () {
                                    showCountryPicker(
                                      context: context,
                                      showPhoneCode: true,
                                      countryListTheme: CountryListThemeData(
                                        flagSize: 25,
                                        backgroundColor:
                                        AppColors.backgroundColorLight,
                                        textStyle: const TextStyle(
                                            fontSize: 16,
                                            color: AppColors.blackLight),
                                        bottomSheetHeight: 85.0.h,
                                        // Optional. Country list modal height
                                        //Optional. Sets the border radius for the bottomsheet.
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(20.0),
                                          topRight: Radius.circular(20.0),
                                        ),
                                        //Optional. Styles the search field.
                                        inputDecoration:
                                        const InputDecoration(
                                          hintText: 'Search by name or code',
                                          hintStyle: TextStyle(
                                            color:
                                            AppColors.formsHintFontLight,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                          ),
                                          prefixIcon: Icon(
                                            Icons.search,
                                            color:
                                            AppColors.formsHintFontLight,
                                          ),
                                          filled: true,
                                          fillColor: AppColors.whiteLight,
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(8)),
                                            borderSide: BorderSide(
                                              color: Color(0xFFDBD4C3),
                                              width: 0.50,
                                            ),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(8)),
                                            borderSide: BorderSide(
                                              color: Color(0xFFDBD4C3),
                                              width: 0.50,
                                            ),
                                          ),
                                        ),
                                      ),
                                      onSelect: (Country country) =>
                                      pickUpCountryCode.text =
                                      '+${country.phoneCode}',
                                    );
                                  },
                                  isOptional: false,
                                  color: AppColors.formsLabel,
                                  readOnly: true,
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 13),
                                  obscureText: false,
                                  validator: (value) {
                                    return Validator.countryCodeValidator(
                                        pickUpCountryCode.text);
                                  },
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                flex: 3,
                                child: RebiInput(
                                  hintText: 'Pickup Contact number'.tra,
                                  controller: pickUpContactNumber,
                                  keyboardType: TextInputType.phone,
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
                                    return Validator.phoneValidator(
                                        pickUpContactNumber.text);
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
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
                      padding:
                      const EdgeInsets.symmetric(horizontal: kPadding),
                      child: RebiButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate() &&
                                selectedNumber != null) {
                              JoinShowTransportRequestModel joinShowModel =
                              JoinShowTransportRequestModel(
                                pickupContactName: pickUpContactName.text,
                                pickupContactNumber:
                                pickUpContactNumber.text,
                                trip: 'Show Transport',
                                horsesNumber: selectedNumber!,
                                tripType: 'On Way',
                                pickupDate: date!.text,
                                pickupTime: timePicked!.text,
                                pickupLocation: pickUpLocation.text,
                              );
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) =>
                                      ChoseShowsHorseScreen(
                                        joinShowTransportRequestModel: joinShowModel,)));
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
