// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
//
// import '../../../../core/utils/Printer.dart';
// import '../../data/eventandtransport_model.dart';
// import 'eventlistitem.dart';
//
//
// class EventList extends StatefulWidget {
//   const EventList({Key? key}) : super(key: key);
//
//   @override
//   State<EventList> createState() => _EventListState();
// }
//
// class _EventListState extends State<EventList> {
//   late Future<List<EventDetailsModel>> event;
//   List<EventDetailsModel> eventslist = [];
//   late bool isLastPage;
//   late bool isLoading;
//   late int pageCount;
//   int numberOfPostsPerRequest = 5;
//   late ScrollController _scrollController;
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     isLastPage = false;
//     isLoading = false;
//     pageCount = 0;
//     numberOfPostsPerRequest = 5;
//     _scrollController = ScrollController();
//
//     event = getEventList(numberOfPostsPerRequest);
//     _scrollController.addListener(_scrollListener);
//   }
//
//   _scrollListener() {
//     if (_scrollController.offset >=
//             _scrollController.position.maxScrollExtent &&
//         !_scrollController.position.outOfRange) {
//       setState(() {
//         Print("comes to bottom $isLoading");
//         isLoading = true;
//
//         if (isLoading) {
//           Print("RUNNING LOAD MORE");
//
//           pageCount = pageCount + 1;
//           getEventList(numberOfPostsPerRequest);
//         }
//       });
//     }
//   }
//
//   @override
//   void dispose() {
//     _scrollController.dispose();
//     super.dispose();
//   }
//
//   Future<List<EventDetailsModel>> getEventList(
//       var numberOfPostsPerRequest) async {
//     Print("numberOfPostsPerRequest from futur");
//
//     final response = await http.get(
//       Uri.parse(
//           'https://jsonplaceholder.typicode.com/users?_page=$pageCount&_limit=$numberOfPostsPerRequest'),
//     );
//     if (response.statusCode == 200) {
//       var jsonResponse = json.decode(response.body);
//       for (var e in jsonResponse) {
//         EventDetailsModel event = EventDetailsModel(
//           fullName: e['name'],
//           email: e['email'],
//           number: e['phone'],
//           origin: e['website'],
//           destination: e["name"],
//           noofhorse: e["email"],
//           serviceType: e["phone"],
//           date: DateTime.now(),
//           time: DateTime.now(),
//           returnevent: e[false],
//         );
//         eventslist.add(event);
//       }
//       setState(() {
//         isLastPage = jsonResponse.length < numberOfPostsPerRequest;
//         isLoading = false;
//         pageCount = pageCount + 1;
//       });
//       return eventslist;
//     } else {
//       throw Exception('Failed to load post');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<List<EventDetailsModel>>(
//       future: event,
//       builder: (context, snapshot) {
//         if (snapshot.hasData) {
//           Print(snapshot.data);
//           return Expanded(
//             child: ListView.builder(
//               controller: _scrollController,
//               scrollDirection: Axis.vertical,
//               shrinkWrap: true,
//               // primary: false,
//
//               itemCount: snapshot.data!.length,
//               itemBuilder: (context, index) {
//                 return EventListItem('assets/images/eventitem.png',
//                     snapshot.data![index].fullName);
//               },
//             ),
//           );
//         } else if (snapshot.hasError) {
//           return Text(snapshot.error.toString());
//         } else {
//           return CircularProgressIndicator();
//         }
//       },
//     );
//   }
// }
