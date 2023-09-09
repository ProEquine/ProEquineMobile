import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:proequine/core/constants/constants.dart';
import 'package:proequine/core/widgets/rebi_button.dart';
import 'package:proequine/features/nav_bar/presentation/screens/bottomnavigation.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/constants/colors/app_colors.dart';
import '../../../../core/constants/images/app_images.dart';
import '../../../../core/constants/thems/app_styles.dart';
import '../../../../core/widgets/custom_header.dart';
import '../../../../core/widgets/divider.dart';
import '../../data/shipping_service_model.dart';

class ConfirmHorsesScreen extends StatefulWidget {
  final List<String> horsesNames;
  final List<bool> isNewHorses;
  ShippingServiceModel? serviceModel;

  ConfirmHorsesScreen(
      {super.key,
      required this.horsesNames,
      required this.isNewHorses,
      this.serviceModel});

  @override
  State<ConfirmHorsesScreen> createState() => _ConfirmHorsesScreenState();
}

class _ConfirmHorsesScreenState extends State<ConfirmHorsesScreen> {
  @override
  Widget build(BuildContext context) {
    final f = DateFormat('dd/MM/yy');
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(20.0.h),
        child: CustomHeader(
          title: "Confirmation",
          isThereBackButton: true,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kPadding, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                  "Confirm your horses details before submitting your horse's shipment ",
                  style: AppStyles.descriptions),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              width: double.infinity,
              constraints: BoxConstraints(
                  minHeight: 100, minWidth: 100, maxHeight: 55.0.h),
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  side: const BorderSide(
                      width: 0.50, color: AppColors.borderColor),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: SingleChildScrollView(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 19),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Shipment Details",
                            style: AppStyles.summaryTitleStyle,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            widget.serviceModel?.serviceType == 'Export'
                                ? "Export Shipment"
                                : "Import Shipment",
                            style: AppStyles.summaryDesStyle,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Text(
                                widget.serviceModel?.serviceType == 'Export'
                                    ? "UAE"
                                    : widget.serviceModel!.selectedCountry,
                                style: AppStyles.bookingContent,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              SvgPicture.asset(
                                AppIcons.directArrow,
                                height: 20,
                                width: 40,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                widget.serviceModel?.serviceType == 'Export'
                                    ? widget.serviceModel!.selectedCountry
                                    : "UAE",
                                style: AppStyles.bookingContent,
                              ),
                              const Spacer(),
                              Text(
                                f.format(
                                    widget.serviceModel!.shipmentEstimatedDate),
                                style: AppStyles.bookingContent,
                              ),
                            ],
                          ),
                        ],
                      ),
                      const CustomDivider(),
                      ListView.separated(
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {},
                              child: Row(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Horse ${index + 1}",
                                        style: AppStyles.summaryTitleStyle,
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        widget.horsesNames[index],
                                        style: AppStyles.bookingContent,
                                      ),
                                    ],
                                  ),
                                  const Spacer(),
                                  const Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    color: AppColors.blackLight,
                                    size: 12,
                                  ),
                                ],
                              ),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return const CustomDivider();
                          },
                          itemCount: widget.horsesNames.length)
                    ],
                  ),
                ),
              ),
            ),
            const Spacer(),
            RebiButton(
                //
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const BottomNavigation(
                              selectedIndex: 1,
                            )),
                  );
                },
                child: const Text("Submit")),
            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}
