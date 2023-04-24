import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:proequine/features/events/data/eventandtransport_model.dart';


class EventSummary extends StatelessWidget {
  // static const routeName = '/summry';
  EventSummary({Key? key, required this.eventDetails}) : super(key: key);
  EventDetailsModel eventDetails;

  @override
  Widget build(BuildContext context) {
    final routeArgu =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    return Scaffold(
      appBar: AppBar(
        title: Text("Event Summary"),
        backgroundColor: const Color.fromRGBO(91, 90, 86, 1),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Row(
              children: <Widget>[
                const Icon(
                  Icons.lock_clock,
                  color: Color.fromRGBO(196, 134, 54, 1),
                  size: 30,
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Date & Time',
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(height: 10),
                    Text(
                      DateFormat(
                        DateFormat.YEAR_ABBR_MONTH_WEEKDAY_DAY,
                      ).format(eventDetails.date),
                      style: TextStyle(fontSize: 15, color: Colors.grey),
                    ),
                    Text(
                      DateFormat("h:mma").format(eventDetails.time),
                      style: TextStyle(fontSize: 15, color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),

            Divider(
              thickness: 1, // thickness of the line
              indent: 20, // empty space to the leading edge of divider.
              endIndent: 10, // empty space to the trailing edge of the divider.
              color:
                  Colors.grey[200], // The color to use when painting the line.
              height: 20,
            ), // The divider's height extent.),
            Row(
              children: <Widget>[
                const Icon(
                  Icons.location_on,
                  color: Color.fromRGBO(196, 134, 54, 1),
                  size: 30,
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Location',
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(height: 10),
                    RichText(
                      text: TextSpan(
                        style: DefaultTextStyle.of(context).style,
                        children: <TextSpan>[
                          const TextSpan(
                              text: 'From',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          TextSpan(text: eventDetails.origin),
                        ],
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        style: DefaultTextStyle.of(context).style,
                        children: <TextSpan>[
                          const TextSpan(
                              text: 'TO',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          TextSpan(text: eventDetails.destination),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),

            Divider(
              thickness: 1, // thickness of the line
              indent: 20, // empty space to the leading edge of divider.
              endIndent: 10, // empty space to the trailing edge of the divider.
              color:
                  Colors.grey[200], // The color to use when painting the line.
              height: 20,
            ),
            Row(
              children: <Widget>[
                const Icon(
                  Icons.fire_truck_rounded,
                  color: Color.fromRGBO(196, 134, 54, 1),
                  size: 30,
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Service Type',
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(height: 10),
                    Text(
                      eventDetails.serviceType,
                      style: TextStyle(fontSize: 15, color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
            Divider(
              thickness: 1, // thickness of the line
              indent: 20, // empty space to the leading edge of divider.
              endIndent: 10, // empty space to the trailing edge of the divider.
              color:
                  Colors.grey[200], // The color to use when painting the line.
              height: 20,
            ),
            Row(
              children: <Widget>[
                const Icon(
                  Icons.hive_rounded,
                  color: Color.fromRGBO(196, 134, 54, 1),
                  size: 30,
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Number Of Hourses',
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(height: 10),
                    Text(
                      eventDetails.noofhorse,
                      style: TextStyle(fontSize: 15, color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
            Divider(
              thickness: 1, // thickness of the line
              indent: 20, // empty space to the leading edge of divider.
              endIndent: 10, // empty space to the trailing edge of the divider.
              color:
                  Colors.grey[200], // The color to use when painting the line.
              height: 20,
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
                width: double.infinity,
                height: 40,
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text('Confirm'),
                  style: ElevatedButton.styleFrom(
                      primary: Color.fromRGBO(61, 61, 61, 1)),
                )),
            const SizedBox(
              height: 20,
            ),

            Container(
              width: double.infinity,
              color: Colors.transparent,
              child: OutlinedButton(
                onPressed: () {},
                child: const Text(
                  'Edit',
                  style: TextStyle(color: Color.fromRGBO(61, 61, 61, 1)),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
