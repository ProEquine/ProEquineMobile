import 'dart:convert';
import 'package:http/http.dart' as http;

// class EventDetailsModel {
//   final String fullName;
//   final String email;
//   final String number;
//   final String origin;
//   final String destination;
//   final String noofhorse;
//   final String serviceType;
//   final DateTime date;
//   final DateTime time;
//   final bool? returnevent;

//   EventDetailsModel(
//     this.fullName,
//     this.email,
//     this.number,
//     this.origin,
//     this.destination,
//     this.noofhorse,
//     this.serviceType,
//     this.date,
//     this.time,
//     this.returnevent,
//   );

class EventDetailsModel {
  late String fullName;
  late String email;
  late String number;
  late String origin;
  late String destination;
  late String noofhorse;
  late String serviceType;
  late DateTime date;
  late DateTime time;
  late bool? returnevent;

  EventDetailsModel({
    required this.fullName,
    required this.email,
    required this.number,
    required this.origin,
    required this.destination,
    required this.noofhorse,
    required this.serviceType,
    required this.date,
    required this.time,
    required this.returnevent,
  });

  factory EventDetailsModel.fromJson(Map<String, dynamic> json) =>
      EventDetailsModel(
        fullName: json["fullName"],
        email: json["email"],
        number: json["number"],
        origin: json["origin"],
        destination: json["destination"],
        noofhorse: json["noofhorse"],
        serviceType: json["serviceType"],
        date: DateTime.parse(json["date"]),
        time: DateTime.parse(json["time"]),
        returnevent: json["returnevent"],
      );
}

// Future<List<EventDetailsModel>> getEventList() async {
//   final response = await http.get(
//     Uri.parse('https://jsonplaceholder.typicode.com/users'),
//   );
//   if (response.statusCode == 200) {
//     var jsonResponse = json.decode(response.body);

//     List<EventDetailsModel> events = [];
//     for (var e in jsonResponse) {
//       EventDetailsModel event = EventDetailsModel(
//         fullName: e['name'],
//         email: e['email'],
//         number: e['phone'],
//         origin: e['website'],
//         destination: e["name"],
//         noofhorse: e["email"],
//         serviceType: e["phone"],
//         date: DateTime.now(),
//         time: DateTime.now(),
//         returnevent: e[false],
//       );
//       events.add(event);
//     }
//     return events;
//   } else {
//     throw Exception('Failed to load post');
//   }
// }
