import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:proequine/core/constants/images/app_images.dart';
import 'package:proequine/core/constants/thems/app_styles.dart';
import 'package:proequine/core/utils/extensions.dart';
import 'package:proequine/core/utils/rebi_message.dart';
import 'package:proequine/core/widgets/base_64_image.dart';
import 'package:proequine/core/widgets/loading_widget.dart';
import 'package:proequine/core/widgets/rebi_button.dart';
import 'package:proequine/features/manage_account/domain/manage_account_cubit.dart';
import 'package:sizer/sizer.dart';

import '../../features/manage_account/data/basic_account_management_route.dart';
import '../constants/colors/app_colors.dart';
import '../constants/routes/routes.dart';
import '../utils/Printer.dart';
import 'chose_picture_bottom_sheet.dart';

class ProfileHeaderWidget extends StatefulWidget {
  String? userName;
  Function? onTapSave;
  String? pictureUrl;
  String? name;
  bool isFromEditing = false;
  bool isEditingPressed = false;

  ProfileHeaderWidget(
      {Key? key,
      this.onTapSave,
      this.userName,
      this.pictureUrl,
      this.name,
      this.isFromEditing = false,
      this.isEditingPressed = false})
      : super(key: key);

  @override
  State<ProfileHeaderWidget> createState() => _ProfileHeaderWidgetState();
}

class _ProfileHeaderWidgetState extends State<ProfileHeaderWidget> {
  ManageAccountCubit cubit = ManageAccountCubit();
  final picker = ImagePicker();
  File? profilePic;

  // Uint8List? imageToSend;

  // Future<Uint8List> loadImageData() async {
  //   ByteData data = await rootBundle.load('assets/image.png');
  //   Uint8List bytes = data.buffer.asUint8List();
  //   return bytes;
  // }
  String? profileUrl;

  Future getImage(ImageSource src, BuildContext? context) async {
    XFile? image = await picker.pickImage(source: src);
    // Uint8List imageBytes = await image!.readAsBytes();

    setState(() {
      if (image != null) {
        profilePic = File(image.path);
      } else {}
    });
  }

  @override
  void dispose() {
    cubit.close();
    super.dispose();
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
                        ? widget.pictureUrl != ''
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: CachedNetworkImage(
                                    width: 62,
                                    height: 62,
                                    imageUrl: widget.pictureUrl!),
                              )
                            : Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFDFD9C9),
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
                                    if (mounted) {
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
                              color: AppColors.formsHintFontLight,
                              fontWeight: FontWeight.w400,
                              fontSize: 12),
                        ),
                        SizedBox(
                          width: 25.0.w,
                        ),
                        Visibility(
                            visible: widget.isEditingPressed,
                            child: BlocConsumer<ManageAccountCubit,
                                ManageAccountState>(
                              bloc: cubit,
                              listener: (context, state) {
                                if (state is UploadFileSuccessful) {
                                  profileUrl = state.fileUrl!.url;
                                  _onPressUploadProfilePic(profileUrl);
                                } else if (state is UploadFileError) {
                                  RebiMessage.error(
                                      msg: state.message!, context: context);
                                }
                                if (state is UpdateImageError) {
                                  RebiMessage.error(
                                      msg: state.message!, context: context);
                                } else if (state is UpdateImageSuccessful) {
                                  Navigator.pushReplacementNamed(
                                      context, successScreen,
                                      arguments: BasicAccountManagementRoute(
                                          type: 'profileImage',
                                          title:
                                              "Profile picture has been added successfully"));
                                }
                              },
                              builder: (context, state) {
                                if (state is UpdateImageLoading ||
                                    state is UploadFileLoading) {
                                  return LoadingCircularWidget();
                                } else {
                                  return GestureDetector(
                                    onTap: () {
                                      _onPressUpload();
                                    },
                                    child: Container(
                                      width: 87,
                                      height: 20,
                                      decoration: ShapeDecoration(
                                        color: const Color(0xFFE0AD25),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(4)),
                                      ),
                                      child: const Center(
                                        child: Padding(
                                          padding:
                                              EdgeInsets.symmetric(vertical: 2),
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
                                  );
                                }
                              },
                            )),
                        // Visibility(
                        //   visible: widget.isEditingPressed,
                        //   child: BlocConsumer<ManageAccountCubit,
                        //       ManageAccountState>(
                        //     bloc: cubit,
                        //     listener: (context, state) {
                        //       if (state is UploadImageSuccessful) {
                        //         Navigator.pushReplacementNamed(
                        //             context, successScreen,
                        //             arguments: BasicAccountManagementRoute(
                        //                 type: 'profileImage',
                        //                 title:
                        //                     "Profile picture has been added successfully"));
                        //       } else if (state is UploadImageError) {
                        //         Print("Error State");
                        //         RebiMessage.error(
                        //             msg: state.message!, context: context);
                        //       }
                        //     },
                        //     builder: (context, state) {
                        //       if (state is UploadImageLoading) {
                        //         return const LoadingCircularWidget();
                        //       }
                        //       return GestureDetector(
                        //         onTap: () {
                        //           onPressUpload();
                        //         },
                        //         child: Container(
                        //           width: 87,
                        //           height: 20,
                        //           decoration: ShapeDecoration(
                        //             color: const Color(0xFFE0AD25),
                        //             shape: RoundedRectangleBorder(
                        //                 borderRadius: BorderRadius.circular(4)),
                        //           ),
                        //           child: const Center(
                        //             child: Padding(
                        //               padding:
                        //                   EdgeInsets.symmetric(vertical: 2),
                        //               child: Text(
                        //                 'Save',
                        //                 style: TextStyle(
                        //                     fontSize: 12,
                        //                     color: AppColors.white,
                        //                     fontWeight: FontWeight.w600,
                        //                     fontFamily: 'notosan'),
                        //               ),
                        //             ),
                        //           ),
                        //         ),
                        //       );
                        //     },
                        //   ),
                        // )
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

  _onPressUploadProfilePic(url) {
    cubit.updateProfileImage(url);
  }

  _onPressUpload() {
    cubit.uploadFile(profilePic!.path.toString());
  }
}
