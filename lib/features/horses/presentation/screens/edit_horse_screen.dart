import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:country_picker/country_picker.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:proequine/core/constants/constants.dart';
import 'package:proequine/core/constants/images/app_images.dart';
import 'package:proequine/core/constants/thems/app_styles.dart';
import 'package:proequine/core/global_functions/global_statics_drop_down.dart';
import 'package:proequine/core/utils/extensions.dart';
import 'package:proequine/core/utils/rebi_message.dart';
import 'package:proequine/core/widgets/loading_widget.dart';
import 'package:proequine/core/widgets/rebi_input.dart';
import 'package:proequine/features/horses/data/remove_horse_request_model.dart';
import 'package:proequine/features/horses/data/update_horse_request_model.dart';
import 'package:proequine/features/horses/domain/horse_cubit.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/constants/colors/app_colors.dart';
import '../../../../core/utils/Printer.dart';
import '../../../../core/utils/validator.dart';
import '../../../../core/widgets/base_64_image.dart';
import '../../../../core/widgets/chose_picture_bottom_sheet.dart';
import '../../../../core/widgets/custom_header.dart';
import '../../../../core/widgets/date_time_picker.dart';
import '../../../../core/widgets/rebi_button.dart';
import '../../../../core/widgets/drop_down_menu_widget.dart';
import '../../../nav_bar/presentation/screens/bottomnavigation.dart';
import '../../../user/presentation/widgets/selectable_type_container.dart';
import '../widgets/delete_horse_bottom_sheet.dart';

class EditHorseScreen extends StatefulWidget {
  final String? image;
  final int? horseId;
  final String? selectedGender;
  final int? selectedYear;
  final String? placeOfBirth;
  final String? horseName;
  final String? selectedColor;
  final String? selectedBreed;
  final String? selectedBloodLine;
  final String? birthOfDate;

  const EditHorseScreen(
      {super.key,
      this.selectedColor,
      this.horseId,
      this.selectedBloodLine,
      this.selectedBreed,
      this.selectedGender,
      this.horseName,
      this.placeOfBirth,
      this.image,
      this.birthOfDate,
      this.selectedYear});

  @override
  EditHorseScreenState createState() => EditHorseScreenState();
}

class EditHorseScreenState extends State<EditHorseScreen> {
  final picker = ImagePicker();
  File? horseImage;
  late String image;
  final TextEditingController? horseName = TextEditingController();
  late DateTime dateTime;

  var now = DateTime.now();
  List<bool> isGenderSelected = [false, false, false];
  String? interest;
  int? firstDay = 1;
  int? firstMonth = 1;
  int? firstYear = 1;
  int? lastDay = 30;
  int? lastMonth = 1;
  int? lastYear = 1;
  final GlobalKey<FormState> _yearKey = GlobalKey<FormState>();
  DateTime _selectedDay = DateTime.utc(2000);
  final DateTime _focusedDay = DateTime.now();
  final TextEditingController _dateOfBirth = TextEditingController();
  final TextEditingController placeOfBirth = TextEditingController();
  final TextEditingController year = TextEditingController();
  late int _selectedYear;
  late TextEditingController _yearController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future getImage(ImageSource src, BuildContext? context) async {
    XFile? image = await picker.pickImage(source: src);
    setState(() {
      if (image != null) {
        horseImage = File(image.path);
      } else {}
    });
  }

  @override
  void initState() {
    initializeDateFormatting();
    _yearController = TextEditingController(text: _selectedDay.year.toString());
    image = AppIcons.horse;
    horseName!.text = widget.horseName!;
    placeOfBirth.text = widget.placeOfBirth!;
    _dateOfBirth.text = widget.birthOfDate!;
    selectedGender = widget.selectedGender;
    selectedColor = widget.selectedColor;
    selectedBloodLine = widget.selectedBloodLine;
    selectedBreed = widget.selectedBreed;
    _selectedYear = _selectedDay.year;
    if (selectedGender == 'Mare') {
      isGenderSelected = [true, false, false];
    } else if (selectedGender == 'Gelding') {
      isGenderSelected = [false, true, false];
    } else if (selectedGender == 'Stallion') {
      isGenderSelected = [false, false, true];
    }

    super.initState();
  }

  HorseCubit cubit = HorseCubit();
  String? selectedGender;
  String? selectedBreed;
  String? selectedColor;
  String? selectedDiscipline;
  String? selectedStable;
  String? selectedBloodLine;
  String? selectedOwner;
  String? selectedStatus;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(20.h),
        child: CustomHeader(
          title: "Edit Horse",
          isThereBackButton: true,
          isThereChangeWithNavigate: false,
          isThereThirdOption: true,
          thirdOptionTitle: 'Remove',
          isThereThirdOptionDelete: true,
          onPressThirdOption: () {
            showDeleteHorseBottomSheet(
              context: context,
              title: 'Remove Horse ',
              content: Column(
                children: [
                  Text(
                    "For verified horses a removal request must submitted ",
                    style: AppStyles.descriptions,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  BlocConsumer<HorseCubit, HorseState>(
                    bloc: cubit,
                    listener: (context, state) {
                      if (state is RemoveHorseError) {
                        RebiMessage.error(
                            msg: state.message!, context: context);
                      } else if (state is RemoveHorseSuccessfully) {
                        RebiMessage.success(
                            msg: state.message, context: context);
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const BottomNavigation(
                                      selectedIndex: 2,
                                    )));
                      }
                    },
                    builder: (context, state) {
                      if (state is RemoveHorseLoading) {
                        return const LoadingCircularWidget(
                          isDeleteButton: true,
                        );
                      }
                      return MaterialButton(
                        onPressed: () {
                          cubit.removeHorse(
                              RemoveHorseRequestModel(horseId: widget.horseId));
                        },
                        child: const Text(
                          "Submit",
                          style: TextStyle(color: AppColors.red),
                        ),
                      );
                    },
                  )
                ],
              ),
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              horseImage == null
                  ? SizedBox(
                      height: 17.5.h,
                      child: Stack(
                        children: [
                          // Container(
                          //   height: 15.0.h,
                          //   margin: EdgeInsets.symmetric(horizontal: kPadding),
                          //   decoration: ShapeDecoration(
                          //     color: Colors.white,
                          //     image: DecorationImage(
                          //         image: AssetImage(widget.image!),
                          //         fit: BoxFit.cover),
                          //     shape: RoundedRectangleBorder(
                          //       side: const BorderSide(
                          //         width: 0.50,
                          //         strokeAlign: BorderSide.strokeAlignCenter,
                          //         color: Color(0xFFDFD9C9),
                          //       ),
                          //       borderRadius: BorderRadius.circular(8),
                          //     ),
                          //   ),
                          // ),
                          widget.image == ''
                              ? Container(
                                  width: 340,
                                  height: 130,
                                  decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(8),
                                          topLeft: Radius.circular(8))),
                                  child: SvgPicture.asset(AppIcons.horse))
                              : ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                      topRight: Radius.circular(8),
                                      topLeft: Radius.circular(8)),
                                  child: Base64Image(
                                    width: 340,
                                    height: 130,
                                    base64Image: widget.image!,
                                  ),
                                ),
                          Positioned(
                              top: 115.5,
                              left: 77.5.w,
                              child: GestureDetector(
                                onTap: () {
                                  showChosePictureBottomSheet(
                                    context: context,
                                    onTapCamera: () {
                                      setState(() {
                                        getImage(ImageSource.camera, context);
                                        Navigator.of(context).pop();
                                      });
                                    },
                                    onTapGallery: () async {
                                      await getImage(
                                          ImageSource.gallery, context);
                                      if (mounted) {
                                        Navigator.of(context).pop();
                                      }
                                    },
                                    title: "Chose the horse picture",
                                  );
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors.yellow,
                                  ),
                                  child: const Center(
                                    child: Icon(
                                      Icons.edit,
                                      size: 13,
                                      color: AppColors.backgroundColorLight,
                                    ),
                                  ),
                                ),
                              ))
                        ],
                      ),
                    )
                  : SizedBox(
                      height: 17.5.h,
                      child: Stack(
                        children: [
                          Container(
                            width: 340,
                            height: 130,
                            margin: const EdgeInsets.symmetric(
                                horizontal: kPadding),
                            decoration: ShapeDecoration(
                              image: DecorationImage(
                                  image: FileImage(horseImage!),
                                  fit: BoxFit.cover),
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                side: const BorderSide(
                                  width: 0.50,
                                  strokeAlign: BorderSide.strokeAlignCenter,
                                  color: Color(0xFFDFD9C9),
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                          Positioned(
                              top: 115.5,
                              left: 77.5.w,
                              child: GestureDetector(
                                onTap: () {
                                  showChosePictureBottomSheet(
                                    context: context,
                                    onTapCamera: () {
                                      setState(() {
                                        getImage(ImageSource.camera, context);
                                        Navigator.of(context).pop();
                                      });
                                    },
                                    onTapGallery: () async {
                                      await getImage(
                                          ImageSource.gallery, context);
                                      if (mounted) {
                                        Navigator.of(context).pop();
                                      }
                                    },
                                    title: "Chose the horse picture",
                                  );
                                },
                                child: Container(
                                  padding: EdgeInsets.all(8),
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors.yellow,
                                  ),
                                  child: const Center(
                                    child: Icon(
                                      Icons.edit,
                                      size: 13,
                                      color: AppColors.backgroundColorLight,
                                    ),
                                  ),
                                ),
                              ))
                        ],
                      ),
                    ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: kPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 7),
                      child: RebiInput(
                        hintText: 'Horse Name'.tra,
                        controller: horseName,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.done,
                        autoValidateMode: AutovalidateMode.onUserInteraction,
                        isOptional: false,
                        color: AppColors.formsLabel,
                        readOnly: false,
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 13),
                        obscureText: false,
                        validator: (value) {
                          return Validator.requiredValidator(horseName?.text);
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 7),
                      child: RebiInput(
                        hintText: 'Place of birth'.tra,
                        controller: placeOfBirth,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.done,
                        onTap: () {
                          showCountryPicker(
                            context: context,
                            showPhoneCode: true,
                            countryListTheme: CountryListThemeData(
                              flagSize: 25,
                              backgroundColor: AppColors.backgroundColorLight,
                              textStyle: const TextStyle(
                                  fontSize: 16, color: AppColors.blackLight),
                              bottomSheetHeight: 85.0.h,
                              // Optional. Country list modal height
                              //Optional. Sets the border radius for the bottomsheet.
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(20.0),
                                topRight: Radius.circular(20.0),
                              ),
                              //Optional. Styles the search field.
                              inputDecoration: const InputDecoration(
                                hintText: 'Search by name or code',
                                hintStyle: TextStyle(
                                  color: AppColors.formsHintFontLight,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                                prefixIcon: Icon(
                                  Icons.search,
                                  color: AppColors.formsHintFontLight,
                                ),
                                filled: true,
                                fillColor: AppColors.whiteLight,
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8)),
                                  borderSide: BorderSide(
                                    color: Color(0xFFDBD4C3),
                                    width: 0.50,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8)),
                                  borderSide: BorderSide(
                                    color: Color(0xFFDBD4C3),
                                    width: 0.50,
                                  ),
                                ),
                              ),
                            ),
                            onSelect: (Country country) =>
                                placeOfBirth.text = country.name,
                          );
                        },
                        autoValidateMode: AutovalidateMode.onUserInteraction,
                        isOptional: false,
                        color: AppColors.formsLabel,
                        readOnly: true,
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 13),
                        obscureText: false,
                        validator: (value) {},
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 7),
                      child: DropDownWidget(
                        items: color,
                        selected: selectedColor,
                        onChanged: (color) {
                          setState(() {
                            selectedColor = color;
                          });
                        },
                        validator: (value) {
                          return Validator.requiredValidator(selectedColor);
                        },
                        hint: 'Color',
                      ),
                    ),
                    const Text(
                      "Gender",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: AppColors.formsHintFontLight,
                        fontSize: 14,
                        fontFamily: 'notosan',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 7.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SelectableTypeContainer(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 35, vertical: 10),
                            label: 'Mare',
                            index: 0,
                            isSelected: isGenderSelected[0],
                            onSelected: (bool value) {
                              _handleSelected(0, value, isGenderSelected);
                              selectedGender = 'Mare';
                              Print("Selected gender $selectedGender");
                            },
                          ),
                          SelectableTypeContainer(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 35, vertical: 10),
                            label: 'Gelding',
                            index: 1,
                            isSelected: isGenderSelected[1],
                            onSelected: (bool value) {
                              _handleSelected(1, value, isGenderSelected);
                              selectedGender = 'Gelding';
                              Print("Selected type $selectedGender");
                            },
                          ),
                          SelectableTypeContainer(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 35, vertical: 10),
                            label: 'Stallion',
                            index: 2,
                            isSelected: isGenderSelected[2],
                            onSelected: (bool value) {
                              _handleSelected(2, value, isGenderSelected);
                              selectedGender = 'Stallion';
                              Print("Selected type $selectedGender");
                            },
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 7),
                      child: DropDownWidget(
                        items: bloodLine,
                        selected: selectedBloodLine,
                        onChanged: (blood) {
                          setState(() {
                            selectedBloodLine = blood;
                          });
                        },
                        validator: (value) {
                          return Validator.requiredValidator(selectedBloodLine);
                        },
                        hint: 'Bloodline',
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 7),
                      child: DropDownWidget(
                        items: breed,
                        selected: selectedBreed,
                        onChanged: (breed) {
                          setState(() {
                            selectedBreed = breed;
                          });
                        },
                        validator: (value) {
                          return Validator.requiredValidator(selectedBreed);
                        },
                        hint: 'Breed',
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: kPadding),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: BlocConsumer<HorseCubit, HorseState>(
                    bloc: cubit,
                    listener: (context, state) {
                      if (state is UpdateHorseSuccessfully) {
                        RebiMessage.success(
                            msg: state.message, context: context);
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const BottomNavigation(
                                      selectedIndex: 2,
                                    )));
                      } else if (state is UpdateHorseError) {
                        RebiMessage.error(
                            msg: state.message!, context: context);
                      }
                    },
                    builder: (context, state) {
                      if (state is UpdateHorseLoading) {
                        return LoadingCircularWidget();
                      }
                      return RebiButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _onPressUpdate();
                            Print("Saved");
                          } else {}
                        },
                        child: const Text("Save"),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleSelected(int index, bool value, var _isSelected) {
    setState(() {
      for (int i = 0; i < _isSelected.length; i++) {
        _isSelected[i] = false;
      }
      _isSelected[index] = value;
    });
  }

  _onPressUpdate() {
    cubit.updateHorse(
        UpdateHorseRequestModel(
            horseName: horseName!.text,
            horseColor: selectedColor,
            horseDOB: widget.birthOfDate,
            horseCOB: placeOfBirth.text,
            breed: selectedBreed,
            bloodline: selectedBloodLine,
            horseImage: widget.image,
            horseGender: selectedGender,
            horseID: widget.horseId),
        horseImage == null ? widget.image! : horseImage!.path);
  }
}
