// import 'package:awesome_dialog/awesome_dialog.dart';
// import 'package:flutter/material.dart';
// import 'package:sizer/sizer.dart';
//
// import '../../../../core/constants/colors/app_colors.dart';
//
// class UpdateAwsomeDialog {
//   static Future<dynamic> updateDialog(context, onTapUpdate, onTapIgnore,bool isImportant) {
//     return AwesomeDialog(
//             context: context,
//             animType: AnimType.topSlide,
//             padding: EdgeInsets.symmetric(horizontal: 2.0.w, vertical: 2.0.h),
//             headerAnimationLoop: true,
//             bodyHeaderDistance: 100,
//             dialogType:isImportant? DialogType.error:DialogType.warning,
//             body: Center(
//               child: isImportant? Text(
//                 'You need to update the app to the\n latest version to continue using FYT.',
//                 style: TextStyle(fontSize:12.sp ),
//               ):Text(
//                 'We have a new update!',
//                 style: TextStyle(fontSize:12.sp ),
//               ),
//             ),
//             btnOkOnPress: () {
//               onTapUpdate();
//             },
//             // closeIcon: Icon(Icons.close,color: Colors.red,),
//             btnOkText: "Update",
//             btnOkColor: AppColors.gold,
//             // btnCancel: Container(color: AppColors.yellow,),
//             btnCancelColor:isImportant? Colors.red:AppColors.yellow,
//             btnCancelOnPress: () {
//               onTapIgnore();
//             },
//             btnCancelText: isImportant?"Close":'Ignore')
//         .show();
//   }
// }
