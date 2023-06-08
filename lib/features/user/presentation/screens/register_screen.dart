import 'package:flutter/material.dart';
import 'package:proequine/core/constants/constants.dart';
import 'package:proequine/core/constants/thems/app_styles.dart';
import 'package:proequine/core/utils/extensions.dart';
import 'package:proequine/core/utils/rebi_message.dart';
import 'package:proequine/core/widgets/privacy_checkbox.dart';
import 'package:proequine/features/user/presentation/screens/signup_screen.dart';


import 'package:table_calendar/table_calendar.dart';
import '../../../../core/constants/colors/app_colors.dart';
import '../../../../core/utils/validator.dart';
import '../../../../core/widgets/custom_logo_widget.dart';
import '../../../../core/widgets/date_time_picker.dart';
import '../../../../core/widgets/rebi_button.dart';
import '../../../../core/widgets/rebi_input.dart';
import '../widgets/register_header.dart';
import 'package:intl/date_symbol_data_local.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late final TextEditingController _firstName;
  late final TextEditingController _middleName;
  late final TextEditingController _lastName;
  late final TextEditingController _dateOfBirth;
  late final TextEditingController year;

  late DateTime dateTime;

  var now = DateTime.now();

  int? firstDay = 1;
  int? firstMonth = 1;
  int? firstYear = 1;
  int? lastDay = 30;
  int? lastMonth = 1;
  int? lastYear = 1;

  bool privacyValue = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _yearKey = GlobalKey<FormState>();
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _selectedDay = DateTime.utc(1950);
  DateTime _focusedDay = DateTime.now();
  late int _selectedYear;
  late TextEditingController _yearController;

  @override
  void initState() {
    initializeDateFormatting();
    _firstName = TextEditingController();
    _yearController = TextEditingController(text: _selectedDay.year.toString());
    _middleName = TextEditingController();
    _lastName = TextEditingController();
    _dateOfBirth = TextEditingController();
    year = TextEditingController();
    _selectedYear = _selectedDay.year;

    super.initState();
  }

  @override
  void dispose() {
    _firstName.dispose();
    _middleName.dispose();
    _lastName.dispose();
    _dateOfBirth.dispose();
    super.dispose();
  }

  // void _selectDate(
  //     {BuildContext? context,
  //     bool isSupportChangingYears=false,
  //     int? selectedYear,
  //      required DateTime selectedOurDay,
  //     }) async {
  //   showDialog<DateTime>(
  //       context: context!,
  //       builder: (BuildContext context) {
  //         void _onYearTextChanged(String text) {
  //           int minYear = 1950;
  //           int maxYear = 2010;
  //           if (text.isNotEmpty) {
  //             final year = int.tryParse(text);
  //             if (year != null && year >= minYear && year <= maxYear) {
  //               setState(() {
  //                 selectedOurDay = DateTime(year, selectedOurDay.month, selectedOurDay.day);
  //               });
  //             }
  //           }
  //         }
  //         void _selectYear(int year) {
  //           int minYear = 1950;
  //           int maxYear = 2010;
  //           if (year >= minYear && year <= maxYear) {
  //             setState(() {
  //               selectedYear = year;
  //               selectedOurDay = DateTime(year, selectedOurDay.month, selectedOurDay.day);
  //             });
  //           }
  //         }
  //         return StatefulBuilder(
  //           // You need this, notice the parameters below:
  //           builder: (BuildContext context, StateSetter setState) {
  //             return SingleChildScrollView(
  //               child: Padding(
  //                 padding:
  //                     EdgeInsets.symmetric(horizontal: 10, vertical: 21.0.h),
  //                 child: Dialog(
  //                   shape: RoundedRectangleBorder(
  //                       borderRadius: BorderRadius.circular(12)),
  //                   insetPadding: const EdgeInsets.symmetric(
  //                       horizontal: 15, vertical: 15),
  //                   backgroundColor: AppColors.formsBackground,
  //                   child: Column(
  //                     crossAxisAlignment: CrossAxisAlignment.center,
  //                     // mainAxisAlignment: MainAxisAlignment.center,
  //                     children: [
  //                      isSupportChangingYears? SizedBox(
  //                         child: Row(
  //                           mainAxisAlignment: MainAxisAlignment.spaceAround,
  //                           children: [
  //                             IconButton(
  //                               icon: Icon(Icons.keyboard_arrow_left,
  //                                   color: Colors.white),
  //                               onPressed: () {
  //                                 setState(() {
  //                                   _selectYear(selectedYear! -
  //                                       1); // update `_focusedDay` here as well
  //                                 });
  //                               },
  //                             ),
  //                             GestureDetector(
  //                               onTap: () {
  //                                 setState(() {
  //                                   showDialog(
  //                                     context: context,
  //                                     builder: (BuildContext context) {
  //                                       return AlertDialog(
  //                                         backgroundColor:
  //                                             AppColors.formsBackground,
  //                                         shape: RoundedRectangleBorder(
  //                                             borderRadius:
  //                                                 BorderRadius.circular(12)),
  //                                         insetPadding:
  //                                             const EdgeInsets.symmetric(
  //                                                 horizontal: 15, vertical: 15),
  //                                         elevation: 5,
  //                                         title: const Text(
  //                                           'Edit Year',
  //                                           style: TextStyle(
  //                                               color: AppColors.gold),
  //                                         ),
  //                                         content: Form(
  //                                           key: _yearKey,
  //                                           child: TextFormField(
  //                                             keyboardAppearance: Brightness.dark,
  //                                             autovalidateMode: AutovalidateMode.onUserInteraction,
  //                                             controller: _yearController,
  //                                             keyboardType: TextInputType.number,
  //                                             validator: (value) {
  //                                               if(value!=null || value != ''){
  //                                                 int? inputtedYear = value!=null || value!=''?
  //                                                 int.tryParse(value!):2;
  //                                                 if (value == '' ||
  //                                                     inputtedYear! < 1950 ||
  //                                                     inputtedYear > 2010) {
  //                                                   return 'Enter your correct age';
  //                                                 }
  //                                               }
  //
  //                                             },
  //                                             onChanged: _onYearTextChanged,
  //                                             style: const TextStyle(
  //                                               color: AppColors.white,
  //                                               fontFamily: "notosan",
  //                                               // fontFamily: AppStyles.montserrat,
  //                                               decoration: TextDecoration.none,
  //
  //                                               ///todo
  //                                             ),
  //                                             decoration:  InputDecoration(
  //                                               errorStyle: const TextStyle(color: AppColors.red,fontSize: 11,height: 1.0,fontFamily: 'notosan'),
  //                                               errorMaxLines: 4,
  //                                               errorBorder: OutlineInputBorder(
  //                                                 borderSide:
  //                                                  const BorderSide(color: AppColors.red, width: 1.0),
  //                                                 borderRadius: BorderRadius.circular(10.0,),
  //                                               ),
  //                                               labelText: 'Select Year',
  //                                             ),
  //                                           ),
  //                                         ),
  //                                         actions: [
  //                                           TextButton(
  //                                             onPressed: () {
  //                                               Navigator.pop(context);
  //                                             },
  //                                             child: const Text(
  //                                               'Cancel',
  //                                               style: TextStyle(
  //                                                   color: AppColors.white),
  //                                             ),
  //                                           ),
  //                                           TextButton(
  //                                             onPressed: () {
  //                                               if(_yearKey.currentState!.validate()){
  //                                                 setState(() {
  //                                                   final year = int.tryParse(
  //                                                       _yearController.text);
  //                                                   if (year != null) {
  //                                                     selectedOurDay = DateTime(
  //                                                         year,
  //                                                         selectedOurDay.month,
  //                                                         selectedOurDay.day);
  //                                                     selectedYear = year;
  //                                                   }
  //                                                 });
  //                                               }
  //
  //                                               Navigator.pop(
  //                                                   context, selectedYear);
  //                                             },
  //                                             child: const Text(
  //                                               'Confirm',
  //                                               style: TextStyle(
  //                                                   color: AppColors.gold),
  //                                             ),
  //                                           ),
  //                                         ],
  //                                       );
  //                                     },
  //                                   ); // update `_focusedDay` here as well
  //                                 });
  //                               },
  //                               child: Text(
  //                                 '$selectedYear',
  //                                 style: TextStyle(
  //                                     fontSize: 20, color: Colors.white),
  //                               ),
  //                             ),
  //                             IconButton(
  //                               icon: Icon(Icons.keyboard_arrow_right,
  //                                   color: Colors.white),
  //                               onPressed: () {
  //                                 setState(() {
  //                                   _selectYear(selectedYear! +
  //                                       1); // update `_focusedDay` here as well
  //                                 });
  //                               },
  //                             ),
  //                           ],
  //                         ),
  //                       ):const SizedBox(height: 0.1,),
  //                       TableCalendar(
  //                         // eventLoader: _getEventsForDay,
  //                         onFormatChanged: (format) {
  //                           setState(() {
  //                             _calendarFormat = format;
  //                             Print(format);
  //                           });
  //                         },
  //
  //                         onPageChanged: (date) {
  //                           firstMonth = date.month;
  //                           firstYear = date.year;
  //                           selectedYear =
  //                               date.year; // update `_focusedDay` here as well
  //                         },
  //
  //                         shouldFillViewport: false,
  //                         headerStyle: HeaderStyle(
  //                           formatButtonVisible: false,
  //                           rightChevronMargin:
  //                               const EdgeInsets.only(right: 10),
  //                           //
  //                           leftChevronIcon: const Icon(
  //                             Icons.chevron_left,
  //                             color: AppColors.gold,
  //                           ),
  //                           rightChevronIcon: const Icon(
  //                             Icons.chevron_right,
  //                             color: AppColors.gold,
  //                           ),
  //
  //                           titleCentered: true,
  //                           titleTextStyle: const TextStyle(
  //                             color: AppColors.white,
  //                             fontSize: 20,
  //                             fontFamily: 'notosan',
  //                           ),
  //                           titleTextFormatter: (date, locale) {
  //                             year.text = date.year.toString();
  //                             firstMonth = date.month;
  //                             firstYear = date.year;
  //                             lastDay =
  //                                 DateTime(date.year, date.month + 1, 0).day;
  //                             return DateFormat(
  //                                     'MMMM-yyyy', AppSharedPreferences.lang)
  //                                 .format(date);
  //                           },
  //                         ),
  //                         daysOfWeekHeight: 40,
  //                         calendarBuilders: CalendarBuilders(
  //                             outsideBuilder: (context, date, newDate) {
  //                           return Container(
  //                             decoration: BoxDecoration(
  //                               borderRadius: BorderRadius.circular(12),
  //                             ),
  //                           );
  //                         }),
  //                         calendarStyle: CalendarStyle(
  //                           tableBorder: TableBorder(
  //                               borderRadius: BorderRadius.circular(12)),
  //                           selectedTextStyle: const TextStyle(
  //                             color: Colors.white,
  //                             fontFamily: 'notosan',
  //                             fontSize: 13,
  //                           ),
  //                           selectedDecoration: const BoxDecoration(
  //                             shape: BoxShape.circle,
  //                             color: AppColors.gold,
  //                           ),
  //                           todayDecoration: const BoxDecoration(
  //                               color: AppColors.formsBackground,
  //                               shape: BoxShape.circle),
  //                           weekendTextStyle: const TextStyle(
  //                             color: AppColors.white,
  //                             fontFamily: 'notosan',
  //                             fontSize: 14,
  //                           ),
  //                           outsideDaysVisible: false,
  //                           defaultTextStyle: const TextStyle(
  //                             color: AppColors.white,
  //                             fontFamily: 'notosan',
  //                             fontSize: 14,
  //                           ),
  //                         ),
  //                         daysOfWeekStyle: const DaysOfWeekStyle(
  //                           weekdayStyle: TextStyle(
  //                             fontSize: 15,
  //                             color: AppColors.lightGrey,
  //                             fontFamily: 'notosan',
  //                           ),
  //                           weekendStyle: TextStyle(
  //                               fontSize: 15,
  //                               color: AppColors.lightGrey,
  //                               fontFamily: 'notosan',
  //                               inherit: false),
  //                           // dowTextFormatter:(date, locale) =>  DateFormat(days['d']).format(date),
  //                         ),
  //                         focusedDay: selectedOurDay ?? _focusedDay,
  //                         firstDay: DateTime.utc(1950),
  //                         startingDayOfWeek: StartingDayOfWeek.monday,
  //                         lastDay: DateTime.utc(2030),
  //                         selectedDayPredicate: (day) {
  //                           return isSameDay(selectedOurDay, day);
  //                         },
  //                         onDaySelected: (selectedDay, focusedDay) {
  //                           setState(() {
  //                             selectedOurDay = selectedDay;
  //                             selectedYear = selectedDay.year;
  //
  //                             _focusedDay = focusedDay;
  //                             _dateOfBirth.text = selectedOurDay
  //                                 .toString();
  //                             DateFormat formatter =
  //                             DateFormat('dd MMM yyyy');
  //                             final String formatted =
  //                             formatter.format(selectedOurDay);
  //                             _dateOfBirth.text = formatted;// update `_focusedDay` here as well
  //                           });
  //                         },
  //                       ),
  //                       SizedBox(
  //                         height: 5.0,
  //                       ),
  //                       Padding(
  //                         padding: const EdgeInsets.all(10.0),
  //                         child: Align(
  //                           alignment: Alignment.bottomRight,
  //                           child: RebiButton(
  //                             width: 75,
  //                             height: 45,
  //                             backgroundColor: AppColors.gold,
  //                             onPressed: () {
  //                               Navigator.pop(context, selectedOurDay);
  //                             },
  //                             child: const Text(
  //                               'Confirm',
  //                               style: TextStyle(
  //                                   color: AppColors.white,
  //                                   fontWeight: FontWeight.bold),
  //                             ),
  //                           ),
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //               ),
  //             );
  //           },
  //         );
  //       });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraint) {
            return Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraint.maxHeight),
                  child: IntrinsicHeight(
                    child: Column(
                      children: [
                        RegistrationHeader(isThereBackButton: true),
                        const CustomLogoWidget(),
                        const Spacer(),
                        Padding(
                          padding:
                              const EdgeInsets.symmetric(horizontal: kPadding),
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text("Sign up",
                                    style: AppStyles.registrationTitle),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Expanded(
                                    flex: 9,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10),
                                      child: RebiInput(
                                        hintText: 'First Name'.tra,
                                        controller: _firstName,
                                        keyboardType: TextInputType.name,
                                        textInputAction: TextInputAction.done,
                                        isOptional: false,
                                        color: AppColors.formsLabel,
                                        readOnly: false,
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 20, vertical: 13),
                                        obscureText: false,
                                        validator: (value) {
                                          return Validator.requiredValidator(
                                              _firstName.text);
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
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10),
                                      child: RebiInput(
                                        hintText: 'Middle Name'.tra,
                                        controller: _middleName,
                                        keyboardType: TextInputType.name,
                                        textInputAction: TextInputAction.done,
                                        isOptional: false,
                                        color: AppColors.formsLabel,
                                        readOnly: false,
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 20, vertical: 13),
                                        obscureText: false,
                                        validator: (value) {
                                          return Validator.requiredValidator(
                                              _middleName.text);
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: RebiInput(
                                  hintText: 'Last Name'.tra,
                                  controller: _lastName,
                                  keyboardType: TextInputType.name,
                                  textInputAction: TextInputAction.done,
                                  isOptional: false,
                                  color: AppColors.formsLabel,
                                  readOnly: false,
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 13),
                                  obscureText: false,
                                  validator: (value) {
                                    return Validator.requiredValidator(
                                        _lastName.text);
                                  },
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: RebiInput(
                                  hintText: 'Date Of Birth'.tra,
                                  controller: _dateOfBirth,
                                  keyboardType: TextInputType.name,
                                  textInputAction: TextInputAction.done,
                                  onTap: () {

                                    selectDate(
                                        context: context,
                                        isSupportChangingYears: true,
                                        selectedOurDay: _selectedDay,
                                        from: DateTime.utc(1950),
                                        to: DateTime.utc(2030),
                                        selectedYear: _selectedYear,
                                    yearController: _yearController,
                                    focusDay: _focusedDay,
                                    controller: _dateOfBirth,
                                    yearKey: _yearKey);
                                    // showDate(context, (value) {
                                    //   setState(() {
                                    //     dateTime = value!;
                                    //     final DateFormat formatter =
                                    //         DateFormat('dd MMM yyyy');
                                    //     final String formatted =
                                    //         formatter.format(dateTime);
                                    //     _dateOfBirth.text = formatted;
                                    //   });
                                    // });
                                  },
                                  isOptional: false,
                                  color: AppColors.formsLabel,
                                  readOnly: true,
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 13),
                                  obscureText: false,
                                  validator: (value) {
                                    return Validator.requiredValidator(
                                        _dateOfBirth.text);
                                  },
                                ),
                              ),
                              Transform.translate(
                                offset: const Offset(-10.0, 0.0),
                                child: PrivacyCheckBox(
                                    isTherePrivacy: true,
                                    value: privacyValue,
                                    onChanged: (value) {
                                      setState(() {
                                        privacyValue = value!;
                                      });
                                    }),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              privacyValue
                                  ? Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 20),
                                      child: RebiButton(
                                          onPressed: () {
                                            if (_formKey.currentState!
                                                .validate()) {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          SignUpScreen(
                                                            dob: _selectedDay
                                                                .toIso8601String(),
                                                            name:
                                                                '${"${_firstName.text} ${_middleName.text} ${_lastName.text}"} ',
                                                          )));
                                            } else {}
                                          },
                                          backgroundColor: AppColors.white,
                                          child: const Text("Sign up")),
                                    )
                                  : Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 20),
                                      child: RebiButton(
                                          onPressed: () {
                                            RebiMessage.error(
                                                msg:
                                                    "Please accept the privacy first"
                                                        .tra,
                                                context: context);
                                          },
                                          backgroundColor: AppColors.formsLabel,
                                          child: const Text("Sign up")),
                                    ),
                              const SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
