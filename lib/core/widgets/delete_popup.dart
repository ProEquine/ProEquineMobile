// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:proequine/core/constants/colors/app_colors.dart';
// import 'package:proequine/core/constants/images/app_images.dart';
// import 'package:proequine/features/user/domain/user_cubit.dart';
//
// import '../../features/splash/presentation/screens/splash_screen.dart';
// import '../utils/rebi_message.dart';
// import '../utils/secure_storage/secure_storage_helper.dart';
// import '../utils/sharedpreferences/SharedPreferencesHelper.dart';
//
// class DeletePopup extends StatelessWidget {
//   final UserCubit cubit = UserCubit();
//
//   DeletePopup({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       backgroundColor: AppColors.formsBackground,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.all(
//           Radius.circular(12.5),
//         ),
//       ),
//       content: Padding(
//         padding: const EdgeInsets.only(
//           top: 10,
//           left: 10,
//           right: 10,
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisSize: MainAxisSize.min,
//           children: <Widget>[
//             SvgPicture.asset(AppIcons.info),
//             const SizedBox(
//               height: 20,
//             ),
//             const Text(
//               "Are you sure you want to delete",
//               style: TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.w500,
//                   color: Colors.white),
//             ),
//             const SizedBox(
//               height: 20,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [

//                 BlocConsumer<UserCubit, UserState>(
//                     bloc: cubit,
//                     builder: (context, state) {
//                       return Expanded(
//                         child: ElevatedButton(
//                           onPressed: () async {
//                             cubit.deleteAccount(
//                                 AppSharedPreferences.userPhoneNumber);
//                             if (context.mounted) {
//                               RebiMessage.success(
//                                   msg: "Account Deleted", context: context);
//                             }
//
//                             if (context.mounted) {
//                               Navigator.pushReplacement(
//                                   context,
//                                   MaterialPageRoute(
//                                       builder: (context) =>
//                                           const SplashScreen()));
//                             }
//                           },
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor:
//                                 const Color.fromRGBO(224, 173, 37, 1),
//                             shape: const RoundedRectangleBorder(
//                               borderRadius: BorderRadius.all(
//                                 Radius.circular(6.5),
//                               ),
//                             ),
//                           ),
//                           child: const Text('Confirm'),
//                         ),
//                       );
//                     },
//                     listener: (context, state) {
//                       if (state is DeleteAccountSuccessful) {}
//                     }),
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:proequine/core/constants/routes/routes.dart';
import 'package:proequine/core/widgets/rebi_button.dart';

import '../../../../core/constants/colors/app_colors.dart';
import '../../../../core/constants/images/app_images.dart';

void deleteDialog(
    {required BuildContext context,
      required Widget deleteButton,
      required String title}) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Padding(
          padding: const EdgeInsets.all(40),
          child: Dialog(
            backgroundColor: AppColors.whiteLight,
            insetPadding: const EdgeInsets.all(20),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(12.5),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 19, left: 19, right: 19, bottom: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  SvgPicture.asset(
                    AppIcons.info,
                    color: AppColors.red,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    title,
                    style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColors.blackLight),
                  ),
                  const SizedBox(height: 19),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => Navigator.pop(context, 'Close'),
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(
                              color: AppColors.blackLight,
                              width: 1,
                            ),
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(6.5),
                              ),
                            ),
                          ),
                          child: const Text(
                            "Close",
                            style: TextStyle(color: AppColors.blackLight),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(child: deleteButton),


                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}

