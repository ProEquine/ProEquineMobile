// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:flutter/material.dart';
//
// class LostConnectionScreen extends StatefulWidget {
//   @override
//   _LostConnectionScreenState createState() => _LostConnectionScreenState();
// }
//
// class _LostConnectionScreenState extends State<LostConnectionScreen> {
//   var _connectionStatus = 'Unknown';
//
//   @override
//   void initState() {
//     super.initState();
//     Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
//       setState(() {
//         _connectionStatus = result.toString();
//       });
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('My App'),
//       ),
//       body: StreamBuilder<ConnectivityResult>(
//         stream: Connectivity().onConnectivityChanged,
//         builder: (BuildContext context, AsyncSnapshot<ConnectivityResult> snapshot) {
//           if (snapshot.hasData && snapshot.data != ConnectivityResult.none) {
//             return Center(
//               child: Text(
//                 'Connected to ${snapshot.data}',
//                 style: TextStyle(fontSize: 20),
//               ),
//             );
//           } else {
//             return Center(
//               child: Text(
//                 'No Internet Connection',
//                 style: TextStyle(fontSize: 20),
//               ),
//             );
//           }
//         },
//       ),
//     );
//   }
// }
