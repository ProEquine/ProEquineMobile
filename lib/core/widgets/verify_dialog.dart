// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:proequine/core/utils/secure_storage/secure_storage_helper.dart';
// import 'package:proequine/core/utils/sharedpreferences/SharedPreferencesHelper.dart';
//
// import '../../core/utils/extensions.dart';
// import '../constants/colors/app_colors.dart';
// import '../constants/images/app_images.dart';
// import 'rebi_button.dart';
//
// bool showUncompletedAccountDialog(BuildContext context, {Function()? onComplete}) {
//   if (!AppSharedPreferences.getEmailVerified!) {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return Dialog(
//           shape: const RoundedRectangleBorder(
//             borderRadius: BorderRadius.all(
//               Radius.circular(24.0),
//             ),
//           ),
//           child: Container(
//             padding: const EdgeInsets.only(
//               right: 20.0,
//               left: 20.0,
//               top: 20.0,
//               bottom: 10.0,
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               mainAxisSize: MainAxisSize.min,
//               children: [eight: 80.0,
//                 ),
//                 const SizedBox(
//                   height: 30.0,
//                 ),
//                 RichText(
//                   text: TextSpan(
//                     text: 'Login is'.tra,
//                     style: AppStyles.headTitleStyle.copyWith(
//                       color: AppColors.mainTextColor,
//                       fontSize: 16.0,
//                       height: 1.55,
//                       fontWeight: FontWeight.w600,
//                     ),
//                     children: <TextSpan>[
//                       const TextSpan(text: ' '),
//                       TextSpan(
//                         text: 'required'.tra,
//                         style: const TextStyle(
//                           color: AppColors.alt,
//                         ),
//                       ),
//                       const TextSpan(text: ' !'),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 10.0,
//                 ),
//                 Text(
//                   'You need to login to continue'.tra,
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     fontSize: 15.0,
//                     color: AppColors.main.withOpacity(0.65),
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 20.0,
//                 ),
//                 RebiButton(
//                   onPressed: () {
//                     Navigator.pop(context);
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => LoginPage(
//                           comeFromNavigationBar: true,
//                         ),
//                       ),
//                     ).then((value) {
//                       if (onComplete != null) {
//                         onComplete();
//                       }
//                     });
//                   },
//                   child: Text('Login'.tra),
//                 ),
//                 const SizedBox(
//                   height: 20.0,
//                 ),
//                 TextButton(
//                   onPressed: () {
//                     Navigator.pop(context);
//                   },
//                   child: Text(
//                     'Later'.tra,
//                     style:  TextStyle(color: AppColors.gold, decoration: TextDecoration.underline),
//                   ),
//                 ),
//               ],
//             ),
//
//         );
//       },
//     );
//     return true;
//   }
//   return false;
// }
//
// bool showUnverifiedAccountDialog(BuildContext context) {
//   if (!AppSharedPreferences.isVerified) {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return Dialog(
//           shape: const RoundedRectangleBorder(
//             borderRadius: BorderRadius.all(
//               Radius.circular(24.0),
//             ),
//           ),
//           child: Container(
//             padding: const EdgeInsets.only(
//               right: 20.0,
//               left: 20.0,
//               top: 20.0,
//               bottom: 10.0,
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 SvgPicture.asset(
//                   AppIcons.phoneVerification,
//                   height: 80.0,
//                 ),
//                 const SizedBox(
//                   height: 30.0,
//                 ),
//                 RichText(
//                   text: TextSpan(
//                     text: 'Verify your'.tra,
//                     style: AppStyles.headTitleStyle.copyWith(
//                       color: AppColors.mainTextColor,
//                       fontSize: 16.0,
//                       height: 1.55,
//                       fontWeight: FontWeight.w600,
//                     ),
//                     children: <TextSpan>[
//                       const TextSpan(text: ' '),
//                       TextSpan(
//                         text: 'account'.tra,
//                         style: const TextStyle(
//                           color: AppColors.alt,
//                         ),
//                       ),
//                       const TextSpan(text: ' !'),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 10.0,
//                 ),
//                 Text(
//                   'We noticed your phone number has not been verified. You need to verify to continue'.tra,
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     fontSize: 15.0,
//                     color: AppColors.main.withOpacity(0.65),
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 20.0,
//                 ),
//                 RebiButton(
//                   onPressed: () {
//                     Navigator.pop(context);
//
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => VerificationPage(
//                           isFromDialog: true,
//                         ),
//                       ),
//                     ).then((value) => null);
//                   },
//                   child: Text('Verify your mobile'.tra),
//                 ),
//                 const SizedBox(
//                   height: 20.0,
//                 ),
//                 TextButton(
//                   onPressed: () {
//                     Navigator.pop(context);
//                   },
//                   child: Text(
//                     'Later'.tra,
//                     style: const TextStyle(color: AppColors.alt, decoration: TextDecoration.underline),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//     return true;
//   }
//   return false;
// }
//
// bool checkIfNotLogIn(BuildContext context) {
//   if (AppSharedPreferences.accessToken.isEmpty) {
//     return true;
//   }
//   return false;
// }
