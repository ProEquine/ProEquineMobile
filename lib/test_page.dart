import 'package:flutter/material.dart';
import 'package:proequine/core/utils/rebi_message.dart';

class TestPage extends StatelessWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(onPressed: (){
            RebiMessage.error(msg: "dassdasdfsdfdsfdfdsfdsfdfsdsfdsfdfsdfdsfdfsdfdsfdsfsdfdsf", context: context);
          }, child: Text("Error")),
          TextButton(onPressed: (){
            RebiMessage.success(msg: "dassda", context: context);
          }, child: Text("Success")),
          TextButton(onPressed: (){
            RebiMessage.warning(msg: "dassda", context: context);
          }, child: Text("Warning")),
        ],
      ),
    );
  }
}
