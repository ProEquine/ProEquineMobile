import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:proequine/core/constants/colors/app_colors.dart';
import 'package:proequine/core/constants/constants.dart';
import 'package:proequine/core/utils/rebi_message.dart';
import 'package:proequine/features/horses/presentation/widgets/upload_file_widget.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/utils/Printer.dart';
import '../../../../core/widgets/custom_header.dart';
import '../../../../core/widgets/rebi_button.dart';

class HorseVerificationScreen extends StatefulWidget {
  const HorseVerificationScreen({Key? key}) : super(key: key);

  @override
  State<HorseVerificationScreen> createState() =>
      _HorseVerificationScreenState();
}

class _HorseVerificationScreenState extends State<HorseVerificationScreen> {
  String? horseProfOwnerShip = '';
  String? horsePassport = '';
  String? horseFEIPassport = '';

  uploadFile(String title) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc'],
    );

    if (result != null) {
      File file = File(result.files.single.path!);
      String fileName = file.path.split('/').last;
      String filePath = file.path;
      setState(() {
        if (title == 'owner ship') {
          horseProfOwnerShip = fileName;
        } else if (title == 'passport') {
          horsePassport = fileName;
        } else if (title == 'FEI') {
          horseFEIPassport = fileName;
        }

        Print('file name $fileName');
        Print('file name $filePath');
        Print('title $title');
      });
    } else {
      // User canceled the picker
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(20.0.h),
        child: CustomHeader(
          title: "Horse Verification",
          isThereBackButton: true,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(kPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Horse Proof Ownership',
              style: TextStyle(
                color: AppColors.formsHintFontLight,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            UploadFileWidget(
              onPressUpload: () {
                setState(() {
                  uploadFile('owner ship');
                });
              },
              title: horseProfOwnerShip != '' ? horseProfOwnerShip : 'No file uploaded',
            ),
            const SizedBox(
              height: 15,
            ),
            const Text(
              'Horse National Passport',
              style: TextStyle(
                color: AppColors.formsHintFontLight,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            UploadFileWidget(
              onPressUpload: () {
                Print("Upload pressed");
                setState(() {
                  uploadFile('passport');
                });
              },
              title: horsePassport != '' ? horsePassport : 'No file uploaded',
            ),
            const SizedBox(
              height: 15,
            ),
            const Text(
              'Horse FEI Passport',
              style: TextStyle(
                color: AppColors.formsHintFontLight,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            UploadFileWidget(
              onPressUpload: () {
                setState(() {
                  uploadFile('FEI');
                });
              },
              title: horseFEIPassport != '' ? horseFEIPassport : 'No file uploaded',
            ),
            const Spacer(),
            Align(
              alignment: Alignment.bottomCenter,
              child: RebiButton(
                backgroundColor: (horseFEIPassport == '' ||
                        horsePassport == '' ||
                        horseProfOwnerShip == '')
                    ? AppColors.formsHintFontLight
                    : AppColors.yellow,
                onPressed: () {
                  if (horseFEIPassport == '' ||
                      horsePassport == '' ||
                      horseProfOwnerShip == '') {
                    RebiMessage(msg: "Please upload all fiels before verify");
                  } else {}
                },
                child: const Text("Verify"),
              ),
            ),
            const SizedBox(height: 20,)
          ],
        ),
      ),
    );
  }
}
