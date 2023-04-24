import 'package:flutter/material.dart';

class ServiceHistory extends StatefulWidget {
  const ServiceHistory({super.key});

  @override
  State<ServiceHistory> createState() => _ServiceHistoryState();
}

class _ServiceHistoryState extends State<ServiceHistory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Service History"),
        backgroundColor: const Color.fromRGBO(91, 90, 86, 1),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: ExpansionTile(
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const <Widget>[
                    Text(
                      'Service Type',
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'From Place to place locally',
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Date Time',
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'From Place to place locally',
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ],
                ),
                children: const <Widget>[
                  ListTile(
                      title: Text(
                    'This is tile number 1',
                  )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
