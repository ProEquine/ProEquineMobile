import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:proequine/core/constants/images/app_images.dart';
import 'package:proequine/core/constants/thems/app_styles.dart';
import 'package:proequine/core/widgets/rebi_button.dart';
import 'package:sizer/sizer.dart';

import '../constants/colors/app_colors.dart';
import 'chose_picture_bottom_sheet.dart';

class ProfileHeaderWidget extends StatefulWidget {
  String? userName;
  Function? onTapSave;
  String? name;
  bool isFromEditing = false;
  bool isEditingPressed = false;

  ProfileHeaderWidget(
      {Key? key,
      this.onTapSave,
      this.userName,
      this.name,
      this.isFromEditing = false,
      this.isEditingPressed = false})
      : super(key: key);

  @override
  State<ProfileHeaderWidget> createState() => _ProfileHeaderWidgetState();
}

class _ProfileHeaderWidgetState extends State<ProfileHeaderWidget> {
  final picker = ImagePicker();
  File? profilePic;

  Future getImage(ImageSource src, BuildContext? context) async {
    XFile? image = await picker.pickImage(source: src);
    setState(() {
      if (image != null) {
        profilePic = File(image.path);
      } else {}
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: widget.isFromEditing
          ? Row(
              children: [
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    profilePic == null
                        ? Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Color(0xFFDFD9C9),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Center(
                              child: SvgPicture.asset(
                                AppIcons.subtract,
                                // color: Color(0xFFDFD9C9),
                              ),
                            ),
                          )
                        : Container(
                            width: 62,
                            height: 62,
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              image: DecorationImage(
                                  image: FileImage(profilePic!),
                                  fit: BoxFit.cover),
                            ),
                          ),
                    Positioned(
                      child: Transform.translate(
                          offset: const Offset(5, 5),
                          child: GestureDetector(
                              onTap: () {
                                showChosePictureBottomSheet(
                                  context: context,
                                  onTapCamera: () {
                                    setState(() {
                                      getImage(ImageSource.camera, context);
                                      setState(() {
                                        widget.isEditingPressed = true;
                                      });
                                      Navigator.pop(context);
                                    });
                                  },
                                  onTapGallery: () async {
                                    await getImage(
                                        ImageSource.gallery, context);

                                    setState(() {
                                      widget.isEditingPressed = true;
                                    });
                                    if(mounted){
                                      Navigator.of(context).pop();
                                    }


                                  },
                                  title: "Chose the horse picture",
                                );
                              },
                              child: SvgPicture.asset(AppIcons.takePic))),
                    )
                  ],
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      textAlign: TextAlign.start,
                      '${widget.name}',
                      style: const TextStyle(
                          color: AppColors.blackLight,
                          fontWeight: FontWeight.w700,
                          fontSize: 16),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${widget.userName}",
                          textAlign: TextAlign.start,
                          style: const TextStyle(
                              color: AppColors.formsHintFontLight ,
                              fontWeight: FontWeight.w400,
                              fontSize: 12),
                        ),
                        SizedBox(
                          width: 25.0.w,
                        ),
                        Visibility(
                          visible: widget.isEditingPressed,
                          child: GestureDetector(
                            onTap: () {
                              widget.onTapSave!();
                            },
                            child: Container(
                              width: 87,
                              height: 20,
                              decoration: ShapeDecoration(
                                color: const Color(0xFFE0AD25),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4)),
                              ),
                              child: const Center(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 2),
                                  child: Text(
                                    'Save',
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: AppColors.white,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: 'notosan'),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                )
              ],
            )
          : Row(
              children: [
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Color(0xFFDFD9C9),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      AppIcons.subtract,
                      // color: Color(0xFFDFD9C9),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      textAlign: TextAlign.start,
                      "Hi ${widget.name}",
                      style: const TextStyle(
                          color: AppColors.blackLight,
                          fontWeight: FontWeight.w700,
                          fontSize: 16),
                    ),
                    Text(
                      "${widget.userName}",
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                          color: AppColors.formsHintFontLight,
                          fontWeight: FontWeight.w400,
                          fontSize: 12),
                    ),
                  ],
                )
              ],
            ),
    );
  }
}
