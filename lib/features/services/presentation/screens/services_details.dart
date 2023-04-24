import 'package:flutter/material.dart';

import '../../data/dummy_data.dart';
import '../widgets/carditems.dart';


class ServicesDetails extends StatelessWidget {
  const ServicesDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Services"),
        backgroundColor: const Color.fromRGBO(91, 90, 86, 1),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children:
                  DUMMY_CARD.map((e) => CardItems(e.title, e.link)).toList()),
        ),
      ),
    );
  }
}
