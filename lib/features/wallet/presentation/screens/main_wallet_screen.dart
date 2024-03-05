import 'package:flutter/material.dart';

class MainWalletScreen extends StatefulWidget {
  const MainWalletScreen({super.key});

  @override
  State<MainWalletScreen> createState() => _MainWalletScreenState();
}

class _MainWalletScreenState extends State<MainWalletScreen> {
  @override
  Widget build(BuildContext context) {
    return  const Scaffold(
      body: Column(
        children: [
          Text("Wallet"),
        ],
      ),
    );
  }
}
