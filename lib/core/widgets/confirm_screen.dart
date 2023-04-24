import 'package:flutter/material.dart';

class ConfirmScreen extends StatelessWidget {
  const ConfirmScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/confirm.gif",
              height: 125.0,
              width: 125.0,
            ),
            Text(
              "Submitted",
              style: TextStyle(color: Color.fromRGBO(33, 33, 33, 1)),
            ),
            Text("We will follow up with confirmation"),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: Color.fromRGBO(61, 61, 61, 1)),
              onPressed: () {
                Navigator.of(context)
                    .pushNamedAndRemoveUntil('/homeRoute', (route) => false);
              },
              child: Text('View my schedule'),
            )
          ],
        ),
      ),
    );
  }
}
