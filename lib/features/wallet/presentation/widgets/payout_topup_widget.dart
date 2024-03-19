import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:proequine/core/utils/extensions.dart';

import '../../../../core/constants/colors/app_colors.dart';

class CardAndBankWidget extends StatelessWidget {
  final Function onTap;
  final String title;
  final String icon;
  final Color color;

  const CardAndBankWidget(
      {Key? key,
      required this.onTap,
      required this.title,
      required this.icon,
      required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        onTap();
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: const Color(0xFFDFD9C9)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xFFDFD9C9)),
                    borderRadius: BorderRadius.circular(10),
                    color: color),
                child: SvgPicture.asset(
                  icon,
                  height: 15,
                ),
              ),
              const SizedBox(width: 5,),
              Text(
                title.tra,
                style: const TextStyle(
                  color: Color(0xFF111111),
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
