import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:proequine/core/constants/constants.dart';
import 'package:proequine/core/constants/images/app_images.dart';
import 'package:proequine/core/utils/extensions.dart';
import 'package:proequine/core/widgets/rebi_input.dart';
import 'package:proequine/features/profile/presentation/widgets/drop_down_menu_widget.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/constants/colors/app_colors.dart';
import '../../../../core/utils/Printer.dart';
import '../../../../core/utils/validator.dart';
import '../../../../core/widgets/custom_header.dart';
import '../../../../core/widgets/rebi_button.dart';

class AddHorseScreen extends StatefulWidget {
  const AddHorseScreen({super.key});

  @override
  _AddHorseScreenState createState() => _AddHorseScreenState();
}

class _AddHorseScreenState extends State<AddHorseScreen> {
  final picker = ImagePicker();
  File? _frontImage;
  late String image;
  late DateTime dateTime;
  TextEditingController? horseName;
  TextEditingController? date;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  List<DropdownMenuItem<String>> gender = [
    const DropdownMenuItem(
      value: "Male",
      child: Text("Male"),
    ),
    const DropdownMenuItem(
      value: "Female",
      child: Text("Female"),
    ),
  ];
  List<DropdownMenuItem<String>> owner = [
    const DropdownMenuItem(
      value: "Own Horse",
      child: Text("Own Horse"),
    ),
    const DropdownMenuItem(
      value: "Friend Horse",
      child: Text("Friend Horse"),
    ),
  ];
  List<DropdownMenuItem<String>> breed = [
    const DropdownMenuItem(
      value: "Arabian",
      child: Text("Arabian"),
    ),
    const DropdownMenuItem(
      value: "Shire",
      child: Text("Shire"),
    ),
    const DropdownMenuItem(
      value: "Appaloosa",
      child: Text("Appaloosa"),
    ),
    const DropdownMenuItem(
      value: "Mustang",
      child: Text("Mustang"),
    ),
  ];
  List<DropdownMenuItem<String>> status = [
    const DropdownMenuItem(
      value: "Active",
      child: Text("Active"),
    ),
    const DropdownMenuItem(
      value: "inActive",
      child: Text("inActive"),
    ),
  ];

  void _showDatePicker() {
    showDatePicker(
            context: context,
            builder: (context, child) {
              return Theme(
                  data: Theme.of(context).copyWith(
                    colorScheme: const ColorScheme.light(
                      primary: AppColors.gold, // <-- SEE HERE
                      onPrimary: AppColors.white, // <-- SEE HERE
                      onSurface: Colors.white, // <-- SEE HERE
                    ),
                    dialogTheme: const DialogTheme(
                      backgroundColor: AppColors.formsBackground,
                      contentTextStyle: TextStyle(fontFamily: 'notosan'),
                    ),
                    textButtonTheme: TextButtonThemeData(
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.white, // button text color
                      ),
                    ),
                  ),
                  child: SizedBox(
                    height: 100,
                    width: 100,
                    child: child!,
                  ));
            },
            initialDate: DateTime.now(),
            firstDate: DateTime(2023),
            lastDate: DateTime(2025))
        .then((value) {
      setState(() {
        dateTime = value!;

        final DateFormat formatter = DateFormat('dd MMM yyyy');
        final String formatted = formatter.format(dateTime);
        date?.text = formatted;
      });
    });
  }

  Future getImage(ImageSource src, BuildContext? context) async {
    XFile? image = await picker.pickImage(source: src);
    setState(() {
      if (image != null) {
        _frontImage = File(image.path);
      } else {}
    });
  }

  @override
  void initState() {
    image = AppIcons.horse;
    horseName = TextEditingController();
    date = TextEditingController();
    // selectedGender='male';
    super.initState();
  }

  String? selectedGender;
  String? selectedBreed;
  String? selectedOwner;
  String? selectedStatus;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(20.0.h),
        child: CustomHeader(
          title: "Add your Horse",
          isThereBackButton: true,
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: kPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 30,
                ),
                Stack(
                    alignment: Alignment.bottomRight,
                    clipBehavior: Clip.none,
                    children: [
                      _frontImage == null
                          ? CircleAvatar(
                              radius: 65,
                              backgroundColor: AppColors.formsBackground,
                              child: SvgPicture.asset(
                                AppIcons.horse,
                                height: 50,
                                width: 60,
                                fit: BoxFit.contain,
                              ))
                          : CircleAvatar(
                              radius: 65,
                              backgroundColor: AppColors.formsBackground,
                              backgroundImage: FileImage(_frontImage!),
                            ),

                      Positioned(
                        bottom: -0.5.h,
                        right: 1.0.w,
                        child: InkWell(
                          onTap: () {
                            AwesomeDialog(
                                    context: context,
                                    animType: AnimType.topSlide,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 2.0.w, vertical: 2.0.h),
                                    customHeader: Image.asset(AppImages.logo),
                                    headerAnimationLoop: true,
                                    bodyHeaderDistance: 100,
                                    dialogType: DialogType.info,
                                    body: const Center(
                                      child: Text(
                                        'please choose a picture from :',
                                        style: TextStyle(fontFamily: 'notosan'),
                                      ),
                                    ),
                                    btnOkOnPress: () {
                                      getImage(ImageSource.camera, context);
                                      // Navigator.of(context).pop();
                                    },
                                    btnOkIcon: Icons.camera_alt,
                                    showCloseIcon: true,
                                    // closeIcon: Icon(Icons.close,color: Colors.red,),
                                    btnOkText: "Camera",
                                    btnCancelIcon: Icons.image,
                                    btnOkColor: AppColors.gold,
                                    // btnCancel: Container(color: AppColors.yellow,),
                                    btnCancelColor: AppColors.gold,
                                    btnCancelOnPress: () {
                                      getImage(ImageSource.gallery, context);
                                      // Navigator.of(context).pop();
                                    },
                                    btnCancelText: "Gallery")
                                .show();
                          },
                          child: const Icon(
                            Icons.camera_alt,
                            size: 30,
                          ),
                        ),
                      ),
                      // ),
                    ]),
                const SizedBox(
                  height: 20,
                ),
                DropDownWidget(
                  items: owner,
                  selected: selectedOwner,
                  validator: (value) {
                    return Validator.requiredValidator(selectedOwner);
                  },
                  hint: 'Own Horse',
                ),
                const SizedBox(
                  height: 10,
                ),
                RebiInput(
                  hintText: 'Name'.tra,
                  controller: horseName,
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.done,
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                  isOptional: false,
                  color: AppColors.formsLabel,
                  readOnly: false,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
                  obscureText: false,
                  validator: (value) {
                    return Validator.requiredValidator(horseName?.text);
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                RebiInput(
                  hintText: 'Date'.tra,
                  controller: date,
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.done,
                  onTap: () {
                    _showDatePicker();
                  },
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                  isOptional: false,
                  color: AppColors.formsLabel,
                  readOnly: true,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
                  obscureText: false,
                  validator: (value) {
                    return Validator.requiredValidator(date?.text);
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                DropDownWidget(
                  items: breed,
                  selected: selectedBreed,
                  validator: (value) {
                    return Validator.requiredValidator(selectedBreed);
                  },
                  hint: 'Breed',
                ),
                const SizedBox(
                  height: 10,
                ),
                DropDownWidget(
                  items: gender,
                  selected: selectedGender,
                  validator: (value) {
                  },
                  hint: 'Gender',
                ),
                const SizedBox(
                  height: 10,
                ),
                DropDownWidget(
                  items: status,
                  selected: selectedStatus,
                  validator: (value) {
                    return Validator.requiredValidator(selectedStatus);
                  },
                  hint: 'Status',
                ),
                const SizedBox(
                  height: 40,
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: RebiButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Print("Saved");
                      } else {}
                    },
                    child: const Text("Save"),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
