import 'package:flutter/material.dart';

class HeaderText extends StatelessWidget {
  final String title;
  final String subTitle;

  bool isThereProfileButton = false;
  bool whitStyle = true;

  HeaderText(this.title, this.subTitle, this.whitStyle, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(left: 15),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 24,
              fontWeight: whitStyle ?FontWeight.bold:FontWeight.w500,
              fontFamily: whitStyle ? "hemiHead" : 'notosan',
            ),
          ),
        ),
        whitStyle ?
        const SizedBox(
          height: 14,
        ):const SizedBox(
          height: 0,
        ),

        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.only(left: 15),
          child: Text(
            subTitle,
            style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                fontFamily: "Noto Sans",
                color: Color.fromRGBO(140, 140, 140, 1)),
          ),
        ),
      ],
    );
  }
}
