import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/constants/colors/app_colors.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/constants/images/app_images.dart';
import '../../../../core/utils/rebi_message.dart';
import '../../../../core/widgets/divider.dart';

class ProEquineBankDetailsWidget extends StatefulWidget {
  const ProEquineBankDetailsWidget({super.key});

  @override
  State<ProEquineBankDetailsWidget> createState() =>
      _ProEquineBankDetailsWidgetState();
}

class _ProEquineBankDetailsWidgetState
    extends State<ProEquineBankDetailsWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kPadding, vertical: 10),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          border: Border.all(
            color: AppColors.borderColor,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: kPadding, vertical: 20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Bank Account Name",
                        style: TextStyle(
                            color: Color(0xFF6B7280),
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'notosan'),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "PROEQUINE SERVICES",
                        style: TextStyle(
                            color: Color(0xFF232F39),
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'notosan'),
                      ),
                    ],
                  ),
                  InkWell(
                      onTap: () async {
                        await Clipboard.setData(
                            const ClipboardData(text: "PROEQUINE SERVICES"));

                        // copied successfully
                        RebiMessage.success(
                            msg: "copied successfully", context: context);
                      },
                      child: SvgPicture.asset(AppIcons.copyIcon)),
                ],
              ),
              const Padding(
                  padding: EdgeInsets.all(2.0), child: CustomDivider()),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Swift Code",
                        style: TextStyle(
                            color: Color(0xFF6B7280),
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'notosan'),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "ENBDAEAA",
                        style: TextStyle(
                            color: Color(0xFF232F39),
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'notosan'),
                      ),
                    ],
                  ),
                  InkWell(
                      onTap: () async {
                        await Clipboard.setData(
                            const ClipboardData(text: "ENBDAEAA"));

                        // copied successfully
                        RebiMessage.success(
                            msg: "copied successfully", context: context);
                      },
                      child: SvgPicture.asset(AppIcons.copyIcon)),
                ],
              ),
              const Padding(
                  padding: EdgeInsets.all(2.0), child: CustomDivider()),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Iban",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: Color(0xFF6B7280),
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'notosan'),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "AE123456732412341890",
                        style: TextStyle(
                            color: Color(0xFF232F39),
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'notosan'),
                      ),
                    ],
                  ),
                  InkWell(
                      onTap: () async {
                        await Clipboard.setData(
                            const ClipboardData(text: "AE123456732412341890"));

                        // copied successfully
                        RebiMessage.success(
                            msg: "copied successfully", context: context);
                      },
                      child: SvgPicture.asset(AppIcons.copyIcon)),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
