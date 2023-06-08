import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:proequine/core/widgets/rebi_button.dart';
import 'package:sizer/sizer.dart';
import 'package:table_calendar/table_calendar.dart';

import '../constants/colors/app_colors.dart';
import '../utils/Printer.dart';
import '../utils/sharedpreferences/SharedPreferencesHelper.dart';

void selectDate({
  BuildContext? context,
  bool isSupportChangingYears = false,
  int? selectedYear,
  required DateTime selectedOurDay,
  required DateTime focusDay,
  required DateTime from,
  required DateTime to,
  TextEditingController? yearController,
   final GlobalKey<FormState>? yearKey,
  required final TextEditingController controller,
}) async {
  showDialog<DateTime>(
      context: context!,
      builder: (BuildContext context) {
        return StatefulBuilder(
          // You need this, notice the parameters below:
          builder: (BuildContext context, StateSetter setState) {
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 21.0.h),
                child: Dialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  insetPadding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  backgroundColor: AppColors.formsBackground,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      isSupportChangingYears
                          ? SizedBox(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.keyboard_arrow_left,
                                        color: Colors.white),
                                    onPressed: () {
                                      setState(() {
                                        int minYear = 1950;
                                        int maxYear = 2010;
                                        if (selectedYear! - 1 >= minYear &&
                                            selectedYear! - 1 <= maxYear) {
                                          setState(() {
                                            selectedYear = selectedYear! - 1;
                                            selectedOurDay = DateTime(
                                                selectedYear!,
                                                selectedOurDay.month,
                                                selectedOurDay.day);
                                          });
                                        } // update `_focusedDay` here as well
                                      });
                                    },
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              backgroundColor:
                                                  AppColors.formsBackground,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12)),
                                              insetPadding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 15,
                                                      vertical: 15),
                                              elevation: 5,
                                              title: const Text(
                                                'Edit Year',
                                                style: TextStyle(
                                                    color: AppColors.gold),
                                              ),
                                              content: Form(
                                                key: yearKey,
                                                child: TextFormField(
                                                  keyboardAppearance:
                                                      Brightness.dark,
                                                  autovalidateMode:
                                                      AutovalidateMode
                                                          .onUserInteraction,
                                                  controller: yearController,
                                                  keyboardType:
                                                      TextInputType.number,
                                                  validator: (value) {
                                                    if (value != null ||
                                                        value != '') {
                                                      int? inputtedYear =
                                                          value != null ||
                                                                  value != ''
                                                              ? int.tryParse(
                                                                  value!)
                                                              : 2;
                                                      if (value == '' ||
                                                          inputtedYear! <
                                                              1950 ||
                                                          inputtedYear > 2010) {
                                                        return 'Enter your correct age';
                                                      }
                                                    }
                                                  },
                                                  onChanged: (text) {
                                                    int minYear = 1950;
                                                    int maxYear = 2010;
                                                    if (text.isNotEmpty) {
                                                      final year =
                                                          int.tryParse(text);
                                                      if (year != null &&
                                                          year >= minYear &&
                                                          year <= maxYear) {
                                                        setState(() {
                                                          selectedOurDay =
                                                              DateTime(
                                                                  year,
                                                                  selectedOurDay
                                                                      .month,
                                                                  selectedOurDay
                                                                      .day);
                                                        });
                                                      }
                                                    }
                                                  },
                                                  style: const TextStyle(
                                                    color: AppColors.white,
                                                    fontFamily: "notosan",
                                                    // fontFamily: AppStyles.montserrat,
                                                    decoration:
                                                        TextDecoration.none,

                                                    ///todo
                                                  ),
                                                  decoration: InputDecoration(
                                                    errorStyle: const TextStyle(
                                                        color: AppColors.red,
                                                        fontSize: 11,
                                                        height: 1.0,
                                                        fontFamily: 'notosan'),
                                                    errorMaxLines: 4,
                                                    errorBorder:
                                                        OutlineInputBorder(
                                                      borderSide:
                                                          const BorderSide(
                                                              color:
                                                                  AppColors.red,
                                                              width: 1.0),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                        10.0,
                                                      ),
                                                    ),
                                                    labelText: 'Select Year',
                                                  ),
                                                ),
                                              ),
                                              actions: [
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: const Text(
                                                    'Cancel',
                                                    style: TextStyle(
                                                        color: AppColors.white),
                                                  ),
                                                ),
                                                TextButton(
                                                  onPressed: () {
                                                    if (yearKey!.currentState!
                                                        .validate()) {
                                                      setState(() {
                                                        final year =
                                                            int.tryParse(
                                                                yearController!
                                                                    .text);
                                                        if (year != null) {
                                                          selectedOurDay =
                                                              DateTime(
                                                                  year,
                                                                  selectedOurDay
                                                                      .month,
                                                                  selectedOurDay
                                                                      .day);
                                                          selectedYear = year;
                                                        }
                                                      });
                                                    }

                                                    Navigator.pop(
                                                        context, selectedYear);
                                                  },
                                                  child: const Text(
                                                    'Confirm',
                                                    style: TextStyle(
                                                        color: AppColors.gold),
                                                  ),
                                                ),
                                              ],
                                            );
                                          },
                                        ); // update `_focusedDay` here as well
                                      });
                                    },
                                    child: Text(
                                      '$selectedYear',
                                      style: const TextStyle(
                                          fontSize: 20, color: Colors.white),
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.keyboard_arrow_right,
                                        color: Colors.white),
                                    onPressed: () {
                                      setState(() {
                                        int minYear = 1950;
                                        int maxYear = 2010;
                                        if (selectedYear! + 1 >= minYear &&
                                            selectedYear! + 1 <= maxYear) {
                                          setState(() {
                                            selectedYear = selectedYear! + 1;
                                            selectedOurDay = DateTime(
                                                selectedYear!,
                                                selectedOurDay.month,
                                                selectedOurDay.day);
                                          });
                                        } // update `_focusedDay` here as well
                                      });
                                    },
                                  ),
                                ],
                              ),
                            )
                          : const SizedBox(
                              height: 0.1,
                            ),
                      TableCalendar(
                        onPageChanged: (date) {
                          selectedYear =
                              date.year; // update `_focusedDay` here as well
                        },
                        shouldFillViewport: false,
                        headerStyle: HeaderStyle(
                          formatButtonVisible: false,
                          rightChevronMargin: const EdgeInsets.only(right: 10),
                          //
                          leftChevronIcon: const Icon(
                            Icons.chevron_left,
                            color: AppColors.gold,
                          ),
                          rightChevronIcon: const Icon(
                            Icons.chevron_right,
                            color: AppColors.gold,
                          ),

                          titleCentered: true,
                          titleTextStyle: const TextStyle(
                            color: AppColors.white,
                            fontSize: 20,
                            fontFamily: 'notosan',
                          ),
                          titleTextFormatter: (date, locale) {
                            return DateFormat(
                                    'MMMM-yyyy', AppSharedPreferences.lang)
                                .format(date);
                          },
                        ),
                        daysOfWeekHeight: 40,
                        calendarBuilders: CalendarBuilders(
                            outsideBuilder: (context, date, newDate) {
                          return Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          );
                        }),
                        calendarStyle: CalendarStyle(
                          tableBorder: TableBorder(
                              borderRadius: BorderRadius.circular(12)),
                          selectedTextStyle: const TextStyle(
                            color: Colors.white,
                            fontFamily: 'notosan',
                            fontSize: 13,
                          ),
                          selectedDecoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.gold,
                          ),
                          todayDecoration: const BoxDecoration(
                              color: AppColors.formsBackground,
                              shape: BoxShape.circle),
                          weekendTextStyle: const TextStyle(
                            color: AppColors.white,
                            fontFamily: 'notosan',
                            fontSize: 14,
                          ),
                          outsideDaysVisible: false,
                          defaultTextStyle: const TextStyle(
                            color: AppColors.white,
                            fontFamily: 'notosan',
                            fontSize: 14,
                          ),
                        ),
                        daysOfWeekStyle: const DaysOfWeekStyle(
                          weekdayStyle: TextStyle(
                            fontSize: 15,
                            color: AppColors.lightGrey,
                            fontFamily: 'notosan',
                          ),
                          weekendStyle: TextStyle(
                              fontSize: 15,
                              color: AppColors.lightGrey,
                              fontFamily: 'notosan',
                              inherit: false),
                          // dowTextFormatter:(date, locale) =>  DateFormat(days['d']).format(date),
                        ),
                        focusedDay: selectedOurDay ?? focusDay,
                        firstDay: from,
                        startingDayOfWeek: StartingDayOfWeek.monday,
                        lastDay: to,
                        selectedDayPredicate: (day) {
                          return isSameDay(selectedOurDay, day);
                        },
                        onDaySelected: (selectedDay, focusedDay) {
                          setState(() {
                            selectedOurDay = selectedDay;
                            selectedYear = selectedDay.year;

                            focusDay = focusedDay;
                            controller.text = selectedOurDay.toString();
                            DateFormat formatter = DateFormat('dd MMM yyyy');
                            final String formatted =
                                formatter.format(selectedOurDay);
                            controller.text =
                                formatted; // update `_focusedDay` here as well
                          });
                        },
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: RebiButton(
                            width: 75,
                            height: 45,
                            backgroundColor: AppColors.gold,
                            onPressed: () {
                             Print('selectedOurDay $selectedOurDay');
                              Navigator.pop(context, selectedOurDay);

                             controller.text = selectedOurDay.toString();
                             DateFormat formatter = DateFormat('dd MMM yyyy');
                             final String formatted =
                             formatter.format(selectedOurDay);
                             controller.text =
                                 formatted; // update `_focusedDay` here as well

                            },
                            child: const Text(
                              'Confirm',
                              style: TextStyle(
                                  color: AppColors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      });
}
