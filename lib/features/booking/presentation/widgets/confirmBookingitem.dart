import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/constants/colors/app_colors.dart';
import '../../../../core/constants/images/app_images.dart';

class ConfirmBookingItem extends StatelessWidget {
  final String ? bookingId;
  final String? date;
  final String? transport;
  final int? horsesCount;
   const ConfirmBookingItem({super.key,this.bookingId,this.transport,this.date,this.horsesCount});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      color: const Color.fromRGBO(12, 12, 12, 1),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  flex: 7,
                  child: Container(
                    height: 14.h,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(15),bottomLeft: Radius.circular(15)),
                      image: DecorationImage(
                          image: NetworkImage(
                              "https://images.unsplash.com/photo-1579202673506-ca3ce28943ef"),
                          fit: BoxFit.fill),
                    ),
                  ),
                ),
                const Spacer(
                  flex: 1,
                ),
                Expanded(
                  flex: 14,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10,),
                      Row(
                        children: [
                          Container(
                            height: 14,
                            width: 14,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color:  Colors.yellow),
                          ),
                          const SizedBox(
                            width: 6,
                          ),
                          const Text(
                            'Pending',
                            style: TextStyle(
                              fontSize: 14,
                              color: AppColors.lightGrey,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const Spacer(),
                          Text(bookingId!,style: const TextStyle(color: AppColors.lightGrey,),),
                        ],
                      ),

                      const SizedBox(
                        height: 10,
                      ),
                     Transform.translate(offset: const Offset(-5,0.0),child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: SizedBox(
                              height: 20,
                              width: 20,
                              child: SvgPicture.asset(
                                AppIcons.date,
                                color: AppColors.grey,
                              ),
                            ),
                          ),

                          Expanded(
                            flex: 14,
                            child: Text(
                              date!,
                              style:const TextStyle(
                                  fontSize: 12,
                                  color: AppColors.grey),
                            ),
                          ),
                        ],
                      ),
                     ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Image.asset(
                              AppImages.greyTrans,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                              flex: 14,
                              child: Text(transport!,
                                  style: const TextStyle(
                                    color: AppColors.grey,
                                    fontSize: 12,
                                  )))
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: SvgPicture.asset(
                              AppIcons.horse,
                              color: AppColors.grey,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            flex: 5,
                            child: Text(
                              horsesCount.toString(),
                              style: const TextStyle(
                                  fontSize: 12,
                                  color: AppColors.grey),
                            ),
                          ),
                          const Spacer(),
                           TextButton(
                              style: TextButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                              ),
                              onPressed: () {},
                              child: const Text(
                                "Modify",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),

                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
