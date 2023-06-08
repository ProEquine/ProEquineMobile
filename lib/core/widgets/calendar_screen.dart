// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_slidable/flutter_slidable.dart';
// import 'package:hafllah/core/constants/constants.dart';
// import 'package:hafllah/core/utils/extensions.dart';
// import 'package:hafllah/core/utils/sharedpreferences/SharedPreferencesHelper.dart';
// import 'package:hafllah/features/calendar/domain/calendar_cubit.dart';
// import 'package:hafllah/features/calendar/presentation/screens/add_calendar_event.dart';
// import 'package:hafllah/features/calendar/presentation/widgets/calendar_event_box.dart';
// import 'package:sizer/sizer.dart';
// import 'package:table_calendar/table_calendar.dart';
//
// import '../../../../core/constants/colors/app_colors.dart';
// import '../../../../core/constants/themes/app_themes.dart';
// import '../../../../core/utils/rebi_message.dart';
// import '../../../../core/widgets/custom_error_widget.dart';
// import '../../../../core/widgets/custom_header.dart';
// import '../../../../core/widgets/loading_widget.dart';
// import '../../data/calendar_count_response_model.dart';
//
// class CalendarScreen extends StatefulWidget {
//   DateTime? selectDay;
//
//   CalendarScreen({super.key, this.selectDay});
//
//   @override
//   _CalendarScreenState createState() => _CalendarScreenState();
// }
//
// class _CalendarScreenState extends State<CalendarScreen> {
//   Map<int, Color> color = {
//     50: const Color.fromRGBO(165, 141, 82, .1),
//     100: const Color.fromRGBO(165, 141, 82, .2),
//     200: const Color.fromRGBO(165, 141, 82, .3),
//     300: const Color.fromRGBO(165, 141, 82, .4),
//     400: const Color.fromRGBO(165, 141, 82, .5),
//     500: const Color.fromRGBO(165, 141, 82, .6),
//     600: const Color.fromRGBO(165, 141, 82, .7),
//     700: const Color.fromRGBO(165, 141, 82, .8),
//     800: const Color.fromRGBO(165, 141, 82, .9),
//     900: const Color.fromRGBO(165, 141, 82, 1),
//   };
//   CalendarCubit cubit = CalendarCubit();
//   DateTime _focusDay = DateTime.now();
//   var now = DateTime.now();
//   late DateTime _selectedDay;
//
//   int? firstDay = 1;
//   int? firstMonth = 1;
//   int? firstYear = 1;
//   int? lastDay = 30;
//   int? lastMonth = 1;
//   int? lastYear = 1;
//   DateFormat format = DateFormat('EEEE, MMM d, yyyy',AppSharedPreferences.lang);
//
//   List<CalendarCountResponseModel> _getEventsForDay(DateTime day) {
//     return cubit.eventDayMap[day] ?? [];
//   }
//
//   @override
//   void initState() {
//
//     _selectedDay = widget.selectDay ?? DateTime.now();
//     cubit.getRangeCalendarEvents(
//         startDate:
//             '${firstYear.toString()}-${firstMonth.toString()}-${firstDay.toString()}',
//         endDate:
//             '${firstYear.toString()}-${firstMonth.toString()}-${lastDay.toString()}');
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.backgroundColor,
//       appBar: PreferredSize(
//         preferredSize: Size.fromHeight(20.0.h),
//         child: CustomHeader(
//           title: "Calendar".tra,
//           isThereBackButton: true,
//           isThereAddButton: true,
//           onPressAddButton: () {
//             Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                     builder: (context) => AddCalendarEventScreen(
//                           date: _selectedDay,
//                         ))).then((value) {
//               cubit.getAllCalendarEvents(_selectedDay.toString());
//             });
//           },
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           // mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Center(
//               child: Container(
//                 height: 50.0.h,
//                 width: 90.0.w,
//                 decoration: BoxDecoration(
//                   color: const Color(0xFF29383b).withOpacity(0.06),
//                   borderRadius: BorderRadius.circular(15),
//                 ),
//                 child: Theme(
//                   data: ThemeData(
//                     primarySwatch: MaterialColor(0xFFa58d52, color),
//                     scaffoldBackgroundColor:
//                         const Color(0xFF29383b).withOpacity(0.06),
//                   ),
//                   child: BlocConsumer<CalendarCubit, CalendarState>(
//                     bloc: cubit,
//                     builder: (context, state) {
//                       return TableCalendar<CalendarCountResponseModel>(
//                         eventLoader: _getEventsForDay,
//                         locale: context.locale.languageCode,
//                         onPageChanged: (date) {
//                           firstMonth = date.month;
//                           firstYear = date.year;
//                           context.read<CalendarCubit>().getRangeCalendarEvents(
//                               startDate:
//                                   '${firstYear.toString()}-${firstMonth.toString()}-${firstDay.toString()}',
//                               endDate:
//                                   '${firstYear.toString()}-${firstMonth.toString()}-${lastDay.toString()}');
//                         },
//                         rowHeight: 40,
//                         shouldFillViewport: true,
//                         headerStyle: HeaderStyle(
//                             formatButtonVisible: false,
//                             titleCentered: true,
//                             titleTextStyle: const TextStyle(
//                               color: AppColors.darkBlue,
//                               fontFamily: AppThemes.montserratBold,
//                             ),
//                             titleTextFormatter: (date, locale) {
//                               firstMonth = date.month;
//                               firstYear = date.year;
//                               lastDay =
//                                   DateTime(date.year, date.month + 1, 0).day;
//                               return DateFormat('MMMM',AppSharedPreferences.lang).format(date);
//                             },
//                         ),
//                         daysOfWeekHeight: 30,
//                         onDaySelected:
//                             (DateTime focusDay, DateTime selectedDay) {
//                           setState(() {
//                             _focusDay = focusDay;
//                             _selectedDay = selectedDay;
//                             widget.selectDay = selectedDay;
//                             cubit.getAllCalendarEvents(_selectedDay.toString());
//                           });
//                         },
//                         calendarBuilders: CalendarBuilders(
//                           singleMarkerBuilder: (context, date,
//                               CalendarCountResponseModel events) {
//                             return Container(
//                               decoration: BoxDecoration(
//                                   shape: BoxShape.circle, color: events.color),
//                               width: 7.0,
//                               height: 7.0,
//                               margin:
//                                   const EdgeInsets.symmetric(horizontal: 1.5),
//                             );
//                           },
//                         ),
//                         calendarStyle: const CalendarStyle(
//                           selectedTextStyle: TextStyle(
//                             color: Colors.white,
//                             fontFamily: AppThemes.montserrat,
//                             fontSize: 13,
//                           ),
//                           cellPadding: EdgeInsets.all(0),
//                           tablePadding: EdgeInsets.symmetric(horizontal: 10),
//                           selectedDecoration: BoxDecoration(
//                             borderRadius: BorderRadius.all(Radius.circular(8)),
//                             color: AppColors.gold,
//                           ),
//                           todayDecoration: BoxDecoration(
//                               borderRadius:
//                                   BorderRadius.all(Radius.circular(8)),
//                               color: AppColors.darkBlue,
//                               shape: BoxShape.rectangle),
//                           weekendTextStyle: TextStyle(
//                             color: AppColors.darkBlue,
//                             fontFamily: AppThemes.montserrat,
//                             fontSize: 12,
//                           ),
//                           outsideDaysVisible: false,
//                           defaultTextStyle: TextStyle(
//                             color: AppColors.darkBlue,
//                             fontFamily: AppThemes.montserrat,
//                             fontSize: 12,
//                           ),
//                         ),
//                         daysOfWeekStyle: DaysOfWeekStyle(
//                             weekdayStyle: TextStyle(
//                               fontSize: 12,
//                               color: AppColors.darkBlueWithOpacity50,
//                               fontFamily: AppThemes.montserrat,
//                             ),
//                             weekendStyle: TextStyle(
//                                 fontSize: 12,
//                                 color: AppColors.darkBlueWithOpacity50,
//                                 fontFamily: AppThemes.montserrat,
//                                 inherit: false),
//                             // dowTextFormatter:(date, locale) =>  DateFormat(days['d']).format(date),
//                             decoration: BoxDecoration(
//                               color: AppColors.backgroundColor,
//                               borderRadius: BorderRadius.circular(30),
//                             )),
//                         focusedDay: _focusDay,
//                         firstDay: DateTime.utc(2023),
//                         lastDay: DateTime.utc(2025),
//                         selectedDayPredicate: (DateTime date) {
//                           return isSameDay(_selectedDay, date);
//                         },
//                       );
//                     },
//                     listener: (context, state) {
//                       cubit.selectedDay = _selectedDay;
//                     },
//                   ),
//                 ),
//               ),
//             ),
//             const SizedBox(
//               height: 30,
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: kPadding),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     "Events".tra,
//                     style: const TextStyle(
//                         color: AppColors.darkBlue, fontSize: 14),
//                   ),
//                   Text(
//                     format.format(_selectedDay),
//                     style: const TextStyle(
//                         color: AppColors.gold,
//                         fontFamily: AppThemes.montserrat,
//                         fontSize: 14),
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(
//               height: 10,
//             ),
//             BlocConsumer<CalendarCubit, CalendarState>(
//                 bloc: cubit..getAllCalendarEvents(_selectedDay.toString()),
//                 builder: (context, state) {
//                   if (state is AllCalendarEventsSuccessful) {
//                     if (state.responseModel!.isEmpty) {
//                       return Text(
//                         "Empty".tra,
//                         style: AppThemes.headLine,
//                       );
//                     }
//                     return Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 30),
//                         child: ListView.builder(
//                             shrinkWrap: true,
//                             physics: const ScrollPhysics(),
//                             itemCount: state.responseModel?.length,
//                             itemBuilder: (context, index) {
//                               return Padding(
//                                 padding:
//                                     const EdgeInsets.symmetric(vertical: 10),
//                                 child: Slidable(
//                                   enabled: state.responseModel?[index].type ==
//                                           'Personal' || state.responseModel?[index].type ==
//                                       'شخصي'
//                                       ? true
//                                       : false,
//                                   endActionPane: ActionPane(
//                                       motion: const ScrollMotion(),
//                                       extentRatio: 0.25,
//                                       children: [
//                                         Expanded(
//                                           flex: 1,
//                                           child: Container(
//                                             margin: const EdgeInsets.only(
//                                               left: 8,
//                                               right: 8,
//                                             ),
//                                             decoration: BoxDecoration(
//                                                 borderRadius:
//                                                     BorderRadius.circular(16),
//                                                 color: AppColors.red),
//                                             child: Column(
//                                               children: [
//                                                 Expanded(
//                                                     child: _deleteEventConsumer(
//                                                         state
//                                                             .responseModel![
//                                                                 index]
//                                                             .id)),
//                                               ],
//                                             ),
//                                           ),
//                                         ),
//                                       ]),
//                                   child: CalendarEventBox(
//                                     title: state.responseModel?[index].title,
//                                     // date: state.responseModel?[index].date,
//                                     startAt:
//                                         state.responseModel?[index].startAt,
//                                     type: state.responseModel?[index].type
//                                         .toString(),
//                                   ),
//                                 ),
//                               );
//                             }));
//                   } else if (state is AllCalendarEventsLoading) {
//                     return const LoadingCircularWidget();
//                   } else if (state is AllCalendarEventsError) {
//                     return CustomErrorWidget(
//                         errorMessage: "error ! please try again".tra,
//                         onRetry: () {
//                           cubit.getAllCalendarEvents(_selectedDay.toString());
//                         });
//                   }
//                   return Container();
//                 },
//                 listener: (context, state) {
//                   if (state is AllCalendarEventsError) {
//                     RebiMessage.error(msg: state.message!);
//                   } else if (state is DeleteCalendarEventSuccessful) {
//
//                     RebiMessage.success(msg: state.message!);
//                   }
//                 }),
//           ],
//         ),
//       ),
//     );
//   }
//
//   _deleteEventConsumer(int? id) {
//     return BlocConsumer<CalendarCubit, CalendarState>(
//       bloc: cubit,
//       builder: (context, state) {
//         if (state is DeleteCalendarEventLoading) {
//           return const LoadingCircularWidget();
//         } else {
//           return InkWell(
//             child: SizedBox(
//               width: double.infinity,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: const [
//                   Icon(Icons.delete, color: AppColors.backgroundColor),
//                 ],
//               ),
//             ),
//             onTap: () {
//               _onTapDelete(id);
//               cubit.getAllCalendarEvents(_selectedDay.toString());
//             },
//           );
//         }
//       },
//       listener: (context, state) {
//         if (state is DeleteCalendarEventError) {
//           RebiMessage.error(msg: state.message!);
//         } else if (state is DeleteCalendarEventSuccessful) {
//           RebiMessage.success(msg: state.message!);
//
//           cubit.getAllCalendarEvents(_selectedDay.toString());
//           // Navigator.pushReplacement(context,
//           //     MaterialPageRoute(builder: (context) => CalendarScreen()));
//         }
//       },
//     );
//   }
//
//   _onTapDelete(int? id) {
//     cubit.deleteCalendarEvent(id!);
//   }
// }
