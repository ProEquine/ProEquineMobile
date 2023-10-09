import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:proequine/core/constants/constants.dart';
import 'package:proequine/core/utils/extensions.dart';
import 'package:proequine/core/widgets/global_bottom_sheet.dart';
import 'package:proequine/core/widgets/rebi_button.dart';
import 'package:proequine/features/home/domain/cubits/local_horse_cubit.dart';
import 'package:proequine/features/home/domain/repo/local_storage_repository.dart';
import 'package:proequine/features/nav_bar/presentation/screens/bottomnavigation.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/constants/colors/app_colors.dart';
import '../../../../core/constants/images/app_images.dart';
import '../../../../core/constants/thems/app_styles.dart';
import '../../../../core/global_functions/global_statics_drop_down.dart';
import '../../../../core/utils/Printer.dart';
import '../../../../core/utils/sharedpreferences/SharedPreferencesHelper.dart';
import '../../../../core/utils/validator.dart';
import '../../../../core/widgets/custom_header.dart';
import '../../../../core/widgets/divider.dart';
import '../../../../core/widgets/drop_down_menu_widget.dart';
import '../../../../core/widgets/privacy_checkbox.dart';
import '../../../../core/widgets/rebi_input.dart';
import '../../data/local_trip.dart';
import '../../data/shipping_service_model.dart';

class ConfirmHorsesScreen extends StatefulWidget {
  final List<String> horsesNames;
  final List<bool> isNewHorses;
  final ShippingServiceModel? serviceModel;

  const ConfirmHorsesScreen(
      {super.key,
      required this.horsesNames,
      required this.isNewHorses,
      this.serviceModel});

  @override
  State<ConfirmHorsesScreen> createState() => _ConfirmHorsesScreenState();
}

class _ConfirmHorsesScreenState extends State<ConfirmHorsesScreen> {
  LocalStorageRepository localStorageRepository = LocalStorageRepository();
  TextEditingController horseName = TextEditingController();
  TextEditingController yearOfBirth = TextEditingController();
  TextEditingController note = TextEditingController();
  TextEditingController name = TextEditingController(text: "Abdalla Al Sharif");
  TextEditingController type = TextEditingController(text: "Shipping");
  TextEditingController requestType =
      TextEditingController(text: "Update Request");
  String? selectedGender;
  String? selectedBreed;
  String? selectedColor;
  String? selectedDiscipline;
  String? selectedBloodLine;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool privacyValue = false;

  String selectedOwner = '';
  String selectedStaying = '';
  LocalHorseCubit localHorseCubit =
      LocalHorseCubit(localStorageRepository: LocalStorageRepository());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final f = DateFormat('dd/MM/yy');
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(20.0.h),
        child: CustomHeader(
          title: "Confirmation",
          isThereBackButton: false,
          isThereThirdOption: true,
          isItShowOptionBottomSheet: true,
          onPressThirdOption: () {
            showGlobalBottomSheet(
                context: context,
                title: "Help-Shipping",
                content: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 7,
                      ),
                      child: RebiInput(
                        hintText: '',
                        controller: type,
                        keyboardType: TextInputType.multiline,
                        maxLines: 1,
                        textInputAction: TextInputAction.done,
                        autoValidateMode: AutovalidateMode.onUserInteraction,
                        isOptional: false,
                        readOnly: true,
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 13),
                        obscureText: false,
                        validator: (value) {
                          return Validator.requiredValidator(type.text);
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 7,
                      ),
                      child: RebiInput(
                        hintText: 'Request',
                        controller: requestType,
                        keyboardType: TextInputType.multiline,
                        maxLines: 1,
                        textInputAction: TextInputAction.done,
                        autoValidateMode: AutovalidateMode.onUserInteraction,
                        isOptional: false,
                        readOnly: true,
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 13),
                        obscureText: false,
                        validator: (value) {
                          return Validator.requiredValidator(requestType.text);
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 7,
                      ),
                      child: RebiInput(
                        hintText: 'Name',
                        controller: name,
                        keyboardType: TextInputType.multiline,
                        maxLines: 1,
                        textInputAction: TextInputAction.done,
                        autoValidateMode: AutovalidateMode.onUserInteraction,
                        isOptional: false,
                        readOnly: true,
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 13),
                        obscureText: false,
                        validator: (value) {
                          return Validator.requiredValidator(name.text);
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 7,
                      ),
                      child: RebiInput(
                        hintText: 'Note',
                        controller: note,
                        keyboardType: TextInputType.multiline,
                        maxLines: 5,
                        textInputAction: TextInputAction.done,
                        autoValidateMode: AutovalidateMode.onUserInteraction,
                        isOptional: false,
                        readOnly: false,
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 13),
                        obscureText: false,
                        validator: (value) {
                          return Validator.requiredValidator(note.text);
                        },
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    RebiButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("Submit")),
                  ],
                ));
          },

          // onPressBack: (){
          //   Navigator.pop(context);
          //   Navigator.pop(context);
          // },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kPadding, vertical: 10),
        child: BlocConsumer<LocalHorseCubit, LocalHorseState>(
          bloc: localHorseCubit..getAllHorses(widget.serviceModel!.tripId),
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            if (state is GetHorsesSuccessfully) {
              return Column(
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
                          padding: const EdgeInsets.symmetric(
                              horizontal: 25, vertical: 19),
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
                                        widget.serviceModel?.serviceType ==
                                                'Export'
                                            ? "UAE"
                                            : widget
                                                .serviceModel!.selectedCountry,
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
                                        widget.serviceModel?.serviceType ==
                                                'Export'
                                            ? widget
                                                .serviceModel!.selectedCountry
                                            : "UAE",
                                        style: AppStyles.bookingContent,
                                      ),
                                      const Spacer(),
                                      Text(
                                        f.format(widget.serviceModel!
                                            .shipmentEstimatedDate),
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
                                    Print(
                                        'staying ${state.items[index].staying}');
                                    return GestureDetector(
                                      onTap: () {
                                        if (state.items[index].horseName !=
                                            "Add New Horse") {
                                          selectedStaying =
                                              state.items[index].staying;
                                          selectedOwner =
                                              state.items[index].ownership;
                                          showModalBottomSheet(
                                            isScrollControlled: true,
                                            backgroundColor:
                                                AppSharedPreferences.getTheme ==
                                                        'ThemeCubitMode.dark'
                                                    ? AppColors.formsBackground
                                                    : AppColors
                                                        .backgroundColorLight,
                                            useSafeArea: false,
                                            context: context,
                                            shape: const RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.vertical(
                                                      top: Radius.circular(10)),
                                            ),
                                            builder: (BuildContext context) {
                                              return Wrap(children: [
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      bottom:
                                                          MediaQuery.of(context)
                                                              .viewInsets
                                                              .bottom),
                                                  child: SizedBox(
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: kPadding,
                                                              left: kPadding,
                                                              right: kPadding),
                                                      child: StatefulBuilder(
                                                          builder: (context,
                                                              setState) {
                                                        return SingleChildScrollView(
                                                          child: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  const SizedBox(
                                                                    width: 20,
                                                                  ),
                                                                  Center(
                                                                    child: Text(
                                                                        state
                                                                            .items[
                                                                                index]
                                                                            .horseName,
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                17,
                                                                            fontFamily:
                                                                                "notosan",
                                                                            fontWeight: FontWeight
                                                                                .w600,
                                                                            color: AppSharedPreferences.getTheme == 'ThemeCubitMode.dark'
                                                                                ? Colors.white
                                                                                : AppColors.blackLight)),
                                                                  ),
                                                                  IconButton(
                                                                    icon:
                                                                        const Icon(
                                                                      Icons
                                                                          .close,
                                                                      size: 18,
                                                                      color: AppColors
                                                                          .yellow,
                                                                    ),
                                                                    onPressed:
                                                                        () {
                                                                      Navigator.pop(
                                                                          context);
                                                                    },
                                                                  ),
                                                                ],
                                                              ),
                                                              const SizedBox(
                                                                height:
                                                                    kPadding,
                                                              ),
                                                              Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    "Details",
                                                                    style: AppStyles
                                                                        .summaryTitleStyle,
                                                                  ),
                                                                  const SizedBox(
                                                                    height: 10,
                                                                  ),
                                                                  Text(
                                                                    'Name: ${state.items[index].horseName}',
                                                                    style: AppStyles
                                                                        .summaryDesStyle,
                                                                  ),
                                                                  const SizedBox(
                                                                    height: 10,
                                                                  ),
                                                                  const Padding(
                                                                    padding:
                                                                        EdgeInsets.all(
                                                                            5.0),
                                                                    child:
                                                                        CustomDivider(),
                                                                  ),
                                                                  Text(
                                                                    "Ownership",
                                                                    style: AppStyles
                                                                        .summaryTitleStyle,
                                                                  ),
                                                                  const SizedBox(
                                                                    height: 10,
                                                                  ),
                                                                  Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: [
                                                                      GestureDetector(
                                                                        onTap:
                                                                            () {
                                                                          setState(
                                                                              () {
                                                                            selectedOwner =
                                                                                'New Purchase';
                                                                          });
                                                                        },
                                                                        child:
                                                                            Container(
                                                                          padding: const EdgeInsets
                                                                              .symmetric(
                                                                              horizontal: 45,
                                                                              vertical: 10),
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            border:
                                                                                Border.all(
                                                                              color: selectedOwner == 'New Purchase' ? AppColors.yellow : AppColors.borderColor,
                                                                            ),
                                                                            borderRadius: const BorderRadius.only(
                                                                                topLeft: Radius.circular(20.5),
                                                                                topRight: Radius.circular(20.5),
                                                                                bottomLeft: Radius.circular(20.5),
                                                                                bottomRight: Radius.circular(20.5)),
                                                                            color: selectedOwner == 'New Purchase'
                                                                                ? AppColors.yellow
                                                                                : AppColors.backgroundColorLight,
                                                                          ),
                                                                          child:
                                                                              Text(
                                                                            "New Purchase",
                                                                            style:
                                                                                TextStyle(
                                                                              color: selectedOwner == 'New Purchase' ? AppColors.backgroundColorLight : AppColors.blackLight,
                                                                              fontSize: 15,
                                                                              fontWeight: FontWeight.w500,
                                                                              fontFamily: "notosan",
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      GestureDetector(
                                                                        onTap:
                                                                            () {
                                                                          setState(
                                                                              () {
                                                                            selectedOwner =
                                                                                'Returning';
                                                                          });
                                                                        },
                                                                        child:
                                                                            Container(
                                                                          padding: const EdgeInsets
                                                                              .symmetric(
                                                                              horizontal: 45,
                                                                              vertical: 10),
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            border:
                                                                                Border.all(
                                                                              color: selectedOwner == 'Returning' ? AppColors.yellow : AppColors.borderColor,
                                                                            ),
                                                                            borderRadius: const BorderRadius.only(
                                                                                topLeft: Radius.circular(20.5),
                                                                                topRight: Radius.circular(20.5),
                                                                                bottomLeft: Radius.circular(20.5),
                                                                                bottomRight: Radius.circular(20.5)),
                                                                            color: selectedOwner == 'Returning'
                                                                                ? AppColors.yellow
                                                                                : AppColors.backgroundColorLight,
                                                                          ),
                                                                          child:
                                                                              Text(
                                                                            "Returning",
                                                                            style:
                                                                                TextStyle(
                                                                              color: selectedOwner == 'Returning' ? AppColors.backgroundColorLight : AppColors.blackLight,
                                                                              fontSize: 15,
                                                                              fontWeight: FontWeight.w500,
                                                                              fontFamily: "notosan",
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  const SizedBox(
                                                                    height: 10,
                                                                  ),
                                                                  const Padding(
                                                                    padding:
                                                                        EdgeInsets.all(
                                                                            5.0),
                                                                    child:
                                                                        CustomDivider(),
                                                                  ),
                                                                  Text(
                                                                    "Staying",
                                                                    style: AppStyles
                                                                        .summaryTitleStyle,
                                                                  ),
                                                                  const SizedBox(
                                                                    height: 10,
                                                                  ),
                                                                  Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: [
                                                                      GestureDetector(
                                                                        onTap:
                                                                            () {
                                                                          setState(
                                                                              () {
                                                                            selectedStaying =
                                                                                'Permanent';
                                                                          });
                                                                        },
                                                                        child:
                                                                            Container(
                                                                          padding: const EdgeInsets
                                                                              .symmetric(
                                                                              horizontal: 45,
                                                                              vertical: 10),
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            border:
                                                                                Border.all(
                                                                              color: selectedStaying == 'Permanent' ? AppColors.yellow : AppColors.borderColor,
                                                                            ),
                                                                            borderRadius: const BorderRadius.only(
                                                                                topLeft: Radius.circular(20.5),
                                                                                topRight: Radius.circular(20.5),
                                                                                bottomLeft: Radius.circular(20.5),
                                                                                bottomRight: Radius.circular(20.5)),
                                                                            color: selectedStaying == 'Permanent'
                                                                                ? AppColors.yellow
                                                                                : AppColors.backgroundColorLight,
                                                                          ),
                                                                          child:
                                                                              Text(
                                                                            "Permanent",
                                                                            style:
                                                                                TextStyle(
                                                                              color: selectedStaying == 'Permanent' ? AppColors.backgroundColorLight : AppColors.blackLight,
                                                                              fontSize: 15,
                                                                              fontWeight: FontWeight.w500,
                                                                              fontFamily: "notosan",
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      GestureDetector(
                                                                        onTap:
                                                                            () {
                                                                          setState(
                                                                              () {
                                                                            selectedStaying =
                                                                                'Temporary';
                                                                          });
                                                                        },
                                                                        child:
                                                                            Container(
                                                                          padding: const EdgeInsets
                                                                              .symmetric(
                                                                              horizontal: 45,
                                                                              vertical: 10),
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            border:
                                                                                Border.all(
                                                                              color: selectedStaying == 'Temporary' ? AppColors.yellow : AppColors.borderColor,
                                                                            ),
                                                                            borderRadius: const BorderRadius.only(
                                                                                topLeft: Radius.circular(20.5),
                                                                                topRight: Radius.circular(20.5),
                                                                                bottomLeft: Radius.circular(20.5),
                                                                                bottomRight: Radius.circular(20.5)),
                                                                            color: selectedStaying == 'Temporary'
                                                                                ? AppColors.yellow
                                                                                : AppColors.backgroundColorLight,
                                                                          ),
                                                                          child:
                                                                              Text(
                                                                            "Temporary",
                                                                            style:
                                                                                TextStyle(
                                                                              color: selectedStaying == 'Temporary' ? AppColors.backgroundColorLight : AppColors.blackLight,
                                                                              fontSize: 15,
                                                                              fontWeight: FontWeight.w500,
                                                                              fontFamily: "notosan",
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  const SizedBox(
                                                                    height: 40,
                                                                  ),
                                                                  RebiButton(
                                                                      onPressed:
                                                                          () async {
                                                                        if (selectedOwner.isNotEmpty &&
                                                                            selectedStaying.isNotEmpty) {
                                                                          await localStorageRepository.editSpecificHorse(
                                                                              state.tripId,
                                                                              state.items[index].horseId,
                                                                              Horse(horseId: state.items[index].horseId, horseName: state.items[index].horseName, color: '', yearOfBirth: 2000, gender: '', bloodline: '', breed: '', discipline: '', ownership: selectedOwner, staying: selectedStaying));
                                                                          if (context
                                                                              .mounted) {
                                                                            await localHorseCubit.getAllHorses(state.tripId);
                                                                            Navigator.pop(context,
                                                                                localHorseCubit.getAllHorses(state.tripId));
                                                                          }
                                                                        }
                                                                      },
                                                                      child: const Text(
                                                                          "Save")),
                                                                ],
                                                              ),
                                                              const SizedBox(
                                                                height: 50,
                                                              ),
                                                            ],
                                                          ),
                                                        );
                                                      }),
                                                    ),
                                                  ),
                                                ),
                                              ]);
                                            },
                                          );
                                        } else {
                                          showModalBottomSheet(
                                            isScrollControlled: true,
                                            backgroundColor:
                                                AppSharedPreferences.getTheme ==
                                                        'ThemeCubitMode.dark'
                                                    ? AppColors.formsBackground
                                                    : AppColors
                                                        .backgroundColorLight,
                                            useSafeArea: false,
                                            context: context,
                                            shape: const RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.vertical(
                                                      top: Radius.circular(10)),
                                            ),
                                            builder: (BuildContext context) {
                                              if (state.items[index].yearOfBirth.toString().isNotEmpty &&
                                                  state.items[index].discipline.isNotEmpty &&
                                                  state.items[index].gender.isNotEmpty &&
                                                  state.items[index].staying.isNotEmpty &&
                                                  state.items[index].ownership.isNotEmpty &&
                                                  state.items[index].bloodline.isNotEmpty &&
                                                  state.items[index].breed.isNotEmpty &&
                                                  state.items[index].color.isNotEmpty &&
                                                  state
                                                      .items[index].horseName.isNotEmpty) {
                                                horseName.text = state
                                                    .items[index].horseName;
                                                selectedColor =
                                                    state.items[index].color;
                                                selectedOwner = state
                                                    .items[index].ownership;
                                                yearOfBirth.text=state.items[index].yearOfBirth.toString();
                                                selectedStaying =
                                                    state.items[index].staying;
                                                selectedBloodLine = state
                                                    .items[index].bloodline;
                                                selectedGender =
                                                    state.items[index].gender;
                                                selectedDiscipline = state
                                                    .items[index].discipline;
                                                selectedBreed =
                                                    state.items[index].breed;
                                              }else{

                                              }

                                              return Wrap(children: [
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      bottom:
                                                          MediaQuery.of(context)
                                                              .viewInsets
                                                              .bottom),
                                                  child: SizedBox(
                                                    height: 80.0.h,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: kPadding,
                                                              left: kPadding,
                                                              right: kPadding),
                                                      child: StatefulBuilder(
                                                          builder: (context,
                                                              setState) {
                                                        return SingleChildScrollView(
                                                          child: Form(
                                                            key: _formKey,
                                                            child: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    const SizedBox(
                                                                      width: 20,
                                                                    ),
                                                                    Center(
                                                                      child: Text(
                                                                          "Add New Horse",
                                                                          style: TextStyle(
                                                                              fontSize: 17,
                                                                              fontFamily: "notosan",
                                                                              fontWeight: FontWeight.w600,
                                                                              color: AppSharedPreferences.getTheme == 'ThemeCubitMode.dark' ? Colors.white : AppColors.blackLight)),
                                                                    ),
                                                                    IconButton(
                                                                      icon:
                                                                          const Icon(
                                                                        Icons
                                                                            .close,
                                                                        size:
                                                                            18,
                                                                        color: AppColors
                                                                            .yellow,
                                                                      ),
                                                                      onPressed:
                                                                          () {
                                                                        Navigator.pop(
                                                                            context);
                                                                      },
                                                                    ),
                                                                  ],
                                                                ),
                                                                const SizedBox(
                                                                  height:
                                                                      kPadding,
                                                                ),
                                                                Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                          .symmetric(
                                                                          vertical:
                                                                              7),
                                                                      child:
                                                                          RebiInput(
                                                                        hintText:
                                                                            'Horse Name'.tra,
                                                                        controller:
                                                                            horseName,
                                                                        keyboardType:
                                                                            TextInputType.name,
                                                                        textInputAction:
                                                                            TextInputAction.done,
                                                                        autoValidateMode:
                                                                            AutovalidateMode.onUserInteraction,
                                                                        isOptional:
                                                                            false,
                                                                        color: AppColors
                                                                            .formsLabel,
                                                                        readOnly:
                                                                            false,
                                                                        contentPadding: const EdgeInsets
                                                                            .symmetric(
                                                                            horizontal:
                                                                                20,
                                                                            vertical:
                                                                                13),
                                                                        obscureText:
                                                                            false,
                                                                        validator:
                                                                            (value) {
                                                                          return Validator.requiredValidator(
                                                                              horseName.text);
                                                                        },
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                          .symmetric(
                                                                          vertical:
                                                                              7),
                                                                      child:
                                                                          DropDownWidget(
                                                                        items:
                                                                            color,
                                                                        selected:
                                                                            selectedColor,
                                                                        onChanged:
                                                                            (color) {
                                                                          setState(
                                                                              () {
                                                                            selectedColor =
                                                                                color;
                                                                          });
                                                                        },
                                                                        validator:
                                                                            (value) {
                                                                          return Validator.requiredValidator(
                                                                              selectedColor);
                                                                        },
                                                                        hint:
                                                                            'Color',
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                          .symmetric(
                                                                          vertical:
                                                                              7),
                                                                      child:
                                                                          RebiInput(
                                                                        hintText:
                                                                            'Year of Birth'.tra,
                                                                        controller:
                                                                            yearOfBirth,
                                                                        keyboardType:
                                                                            TextInputType.number,
                                                                        textInputAction:
                                                                            TextInputAction.done,
                                                                        onTap:
                                                                            () {},
                                                                        autoValidateMode:
                                                                            AutovalidateMode.onUserInteraction,
                                                                        isOptional:
                                                                            false,
                                                                        color: AppColors
                                                                            .formsLabel,
                                                                        readOnly:
                                                                            false,
                                                                        contentPadding: const EdgeInsets
                                                                            .symmetric(
                                                                            horizontal:
                                                                                20,
                                                                            vertical:
                                                                                13),
                                                                        obscureText:
                                                                            false,
                                                                        validator:
                                                                            (value) {
                                                                          return Validator.requiredValidator(
                                                                              yearOfBirth.text);
                                                                        },
                                                                      ),
                                                                    ),
                                                                    const Text(
                                                                      "Gender",
                                                                      textAlign:
                                                                          TextAlign
                                                                              .start,
                                                                      style:
                                                                          TextStyle(
                                                                        color: AppColors
                                                                            .formsHintFontLight,
                                                                        fontSize:
                                                                            14,
                                                                        fontFamily:
                                                                            'notosan',
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                          .symmetric(
                                                                          vertical:
                                                                              7.0),
                                                                      child:
                                                                          Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceBetween,
                                                                        children: [
                                                                          GestureDetector(
                                                                            onTap:
                                                                                () {
                                                                              setState(() {
                                                                                selectedGender = 'Mare';
                                                                              });
                                                                            },
                                                                            child:
                                                                                Container(
                                                                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                                                              decoration: BoxDecoration(
                                                                                border: Border.all(
                                                                                  color: selectedGender == 'Mare' ? AppColors.yellow : AppColors.borderColor,
                                                                                ),
                                                                                borderRadius: const BorderRadius.only(topLeft: Radius.circular(20.5), topRight: Radius.circular(20.5), bottomLeft: Radius.circular(20.5), bottomRight: Radius.circular(20.5)),
                                                                                color: selectedGender == 'Mare' ? AppColors.yellow : AppColors.backgroundColorLight,
                                                                              ),
                                                                              child: Text(
                                                                                "Mare",
                                                                                style: TextStyle(
                                                                                  color: selectedGender == 'Mare' ? AppColors.backgroundColorLight : AppColors.blackLight,
                                                                                  fontSize: 14,
                                                                                  fontWeight: FontWeight.w500,
                                                                                  fontFamily: "notosan",
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          GestureDetector(
                                                                            onTap:
                                                                                () {
                                                                              setState(() {
                                                                                selectedGender = 'Gelding';
                                                                              });
                                                                            },
                                                                            child:
                                                                                Container(
                                                                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                                                              decoration: BoxDecoration(
                                                                                border: Border.all(
                                                                                  color: selectedGender == 'Gelding' ? AppColors.yellow : AppColors.borderColor,
                                                                                ),
                                                                                borderRadius: const BorderRadius.only(topLeft: Radius.circular(20.5), topRight: Radius.circular(20.5), bottomLeft: Radius.circular(20.5), bottomRight: Radius.circular(20.5)),
                                                                                color: selectedGender == 'Gelding' ? AppColors.yellow : AppColors.backgroundColorLight,
                                                                              ),
                                                                              child: Text(
                                                                                "Gelding",
                                                                                style: TextStyle(
                                                                                  color: selectedGender == 'Gelding' ? AppColors.backgroundColorLight : AppColors.blackLight,
                                                                                  fontSize: 14,
                                                                                  fontWeight: FontWeight.w500,
                                                                                  fontFamily: "notosan",
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          GestureDetector(
                                                                            onTap:
                                                                                () {
                                                                              setState(() {
                                                                                selectedGender = 'Stallion';
                                                                              });
                                                                            },
                                                                            child:
                                                                                Container(
                                                                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                                                              decoration: BoxDecoration(
                                                                                border: Border.all(
                                                                                  color: selectedGender == 'Stallion' ? AppColors.yellow : AppColors.borderColor,
                                                                                ),
                                                                                borderRadius: const BorderRadius.only(topLeft: Radius.circular(20.5), topRight: Radius.circular(20.5), bottomLeft: Radius.circular(20.5), bottomRight: Radius.circular(20.5)),
                                                                                color: selectedGender == 'Stallion' ? AppColors.yellow : AppColors.backgroundColorLight,
                                                                              ),
                                                                              child: Text(
                                                                                "Stallion",
                                                                                style: TextStyle(
                                                                                  color: selectedGender == 'Stallion' ? AppColors.backgroundColorLight : AppColors.blackLight,
                                                                                  fontSize: 14,
                                                                                  fontWeight: FontWeight.w500,
                                                                                  fontFamily: "notosan",
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                          .symmetric(
                                                                          vertical:
                                                                              7),
                                                                      child:
                                                                          DropDownWidget(
                                                                        items:
                                                                            bloodLine,
                                                                        selected:
                                                                            selectedBloodLine,
                                                                        onChanged:
                                                                            (blood) {
                                                                          setState(
                                                                              () {
                                                                            selectedBloodLine =
                                                                                blood;
                                                                          });
                                                                        },
                                                                        validator:
                                                                            (value) {
                                                                          return Validator.requiredValidator(
                                                                              selectedBloodLine);
                                                                        },
                                                                        hint:
                                                                            'Bloodline',
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                          .symmetric(
                                                                          vertical:
                                                                              7),
                                                                      child:
                                                                          DropDownWidget(
                                                                        items:
                                                                            breed,
                                                                        selected:
                                                                            selectedBreed,
                                                                        onChanged:
                                                                            (breed) {
                                                                          setState(
                                                                              () {
                                                                            selectedBreed =
                                                                                breed;
                                                                          });
                                                                        },
                                                                        validator:
                                                                            (value) {
                                                                          return Validator.requiredValidator(
                                                                              selectedBreed);
                                                                        },
                                                                        hint:
                                                                            'Breed',
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                          .symmetric(
                                                                          vertical:
                                                                              7),
                                                                      child:
                                                                          DropDownWidget(
                                                                        items:
                                                                            discipline,
                                                                        selected:
                                                                            selectedDiscipline,
                                                                        onChanged:
                                                                            (disc) {
                                                                          setState(
                                                                              () {
                                                                            selectedDiscipline =
                                                                                disc;
                                                                          });
                                                                        },
                                                                        validator:
                                                                            (value) {
                                                                          return Validator.requiredValidator(
                                                                              selectedDiscipline);
                                                                        },
                                                                        hint:
                                                                            'Discipline',
                                                                      ),
                                                                    ),
                                                                    const Padding(
                                                                      padding:
                                                                          EdgeInsets.all(
                                                                              5.0),
                                                                      child:
                                                                          CustomDivider(),
                                                                    ),
                                                                    Text(
                                                                      "Ownership",
                                                                      style: AppStyles
                                                                          .summaryTitleStyle,
                                                                    ),
                                                                    const SizedBox(
                                                                      height:
                                                                          10,
                                                                    ),
                                                                    Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      children: [
                                                                        GestureDetector(
                                                                          onTap:
                                                                              () {
                                                                            setState(() {
                                                                              selectedOwner = 'New Purchase';
                                                                            });
                                                                          },
                                                                          child:
                                                                              Container(
                                                                            padding:
                                                                                const EdgeInsets.symmetric(horizontal: 45, vertical: 10),
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              border: Border.all(
                                                                                color: selectedOwner == 'New Purchase' ? AppColors.yellow : AppColors.borderColor,
                                                                              ),
                                                                              borderRadius: const BorderRadius.only(topLeft: Radius.circular(20.5), topRight: Radius.circular(20.5), bottomLeft: Radius.circular(20.5), bottomRight: Radius.circular(20.5)),
                                                                              color: selectedOwner == 'New Purchase' ? AppColors.yellow : AppColors.backgroundColorLight,
                                                                            ),
                                                                            child:
                                                                                Text(
                                                                              "New Purchase",
                                                                              style: TextStyle(
                                                                                color: selectedOwner == 'New Purchase' ? AppColors.backgroundColorLight : AppColors.blackLight,
                                                                                fontSize: 15,
                                                                                fontWeight: FontWeight.w500,
                                                                                fontFamily: "notosan",
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        GestureDetector(
                                                                          onTap:
                                                                              () {
                                                                            setState(() {
                                                                              selectedOwner = 'Returning';
                                                                            });
                                                                          },
                                                                          child:
                                                                              Container(
                                                                            padding:
                                                                                const EdgeInsets.symmetric(horizontal: 45, vertical: 10),
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              border: Border.all(
                                                                                color: selectedOwner == 'Returning' ? AppColors.yellow : AppColors.borderColor,
                                                                              ),
                                                                              borderRadius: const BorderRadius.only(topLeft: Radius.circular(20.5), topRight: Radius.circular(20.5), bottomLeft: Radius.circular(20.5), bottomRight: Radius.circular(20.5)),
                                                                              color: selectedOwner == 'Returning' ? AppColors.yellow : AppColors.backgroundColorLight,
                                                                            ),
                                                                            child:
                                                                                Text(
                                                                              "Returning",
                                                                              style: TextStyle(
                                                                                color: selectedOwner == 'Returning' ? AppColors.backgroundColorLight : AppColors.blackLight,
                                                                                fontSize: 15,
                                                                                fontWeight: FontWeight.w500,
                                                                                fontFamily: "notosan",
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    const SizedBox(
                                                                      height:
                                                                          10,
                                                                    ),
                                                                    const Padding(
                                                                      padding:
                                                                          EdgeInsets.all(
                                                                              5.0),
                                                                      child:
                                                                          CustomDivider(),
                                                                    ),
                                                                    Text(
                                                                      "Staying",
                                                                      style: AppStyles
                                                                          .summaryTitleStyle,
                                                                    ),
                                                                    const SizedBox(
                                                                      height:
                                                                          10,
                                                                    ),
                                                                    Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      children: [
                                                                        GestureDetector(
                                                                          onTap:
                                                                              () {
                                                                            setState(() {
                                                                              selectedStaying = 'Permanent';
                                                                            });
                                                                          },
                                                                          child:
                                                                              Container(
                                                                            padding:
                                                                                const EdgeInsets.symmetric(horizontal: 45, vertical: 10),
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              border: Border.all(
                                                                                color: selectedStaying == 'Permanent' ? AppColors.yellow : AppColors.borderColor,
                                                                              ),
                                                                              borderRadius: const BorderRadius.only(topLeft: Radius.circular(20.5), topRight: Radius.circular(20.5), bottomLeft: Radius.circular(20.5), bottomRight: Radius.circular(20.5)),
                                                                              color: selectedStaying == 'Permanent' ? AppColors.yellow : AppColors.backgroundColorLight,
                                                                            ),
                                                                            child:
                                                                                Text(
                                                                              "Permanent",
                                                                              style: TextStyle(
                                                                                color: selectedStaying == 'Permanent' ? AppColors.backgroundColorLight : AppColors.blackLight,
                                                                                fontSize: 15,
                                                                                fontWeight: FontWeight.w500,
                                                                                fontFamily: "notosan",
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        GestureDetector(
                                                                          onTap:
                                                                              () {
                                                                            setState(() {
                                                                              selectedStaying = 'Temporary';
                                                                            });
                                                                          },
                                                                          child:
                                                                              Container(
                                                                            padding:
                                                                                const EdgeInsets.symmetric(horizontal: 45, vertical: 10),
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              border: Border.all(
                                                                                color: selectedStaying == 'Temporary' ? AppColors.yellow : AppColors.borderColor,
                                                                              ),
                                                                              borderRadius: const BorderRadius.only(topLeft: Radius.circular(20.5), topRight: Radius.circular(20.5), bottomLeft: Radius.circular(20.5), bottomRight: Radius.circular(20.5)),
                                                                              color: selectedStaying == 'Temporary' ? AppColors.yellow : AppColors.backgroundColorLight,
                                                                            ),
                                                                            child:
                                                                                Text(
                                                                              "Temporary",
                                                                              style: TextStyle(
                                                                                color: selectedStaying == 'Temporary' ? AppColors.backgroundColorLight : AppColors.blackLight,
                                                                                fontSize: 15,
                                                                                fontWeight: FontWeight.w500,
                                                                                fontFamily: "notosan",
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    const SizedBox(
                                                                      height:
                                                                          40,
                                                                    ),
                                                                    RebiButton(
                                                                        onPressed:
                                                                            () async {
                                                                          if (_formKey.currentState!.validate() &&
                                                                              selectedDiscipline != null &&
                                                                              selectedGender != null &&
                                                                              selectedBreed != null &&
                                                                              selectedBloodLine != null &&
                                                                              selectedColor != null &&
                                                                              selectedOwner.isNotEmpty &&
                                                                              selectedStaying.isNotEmpty) {
                                                                            await localStorageRepository.editSpecificHorse(
                                                                                state.tripId,
                                                                                state.items[index].horseId,
                                                                                Horse(horseId: state.items[index].horseId, horseName: state.items[index].horseName, color: selectedColor!, yearOfBirth: int.parse(yearOfBirth.text), gender: selectedGender!, bloodline: selectedBloodLine!, breed: selectedBreed!, discipline: selectedDiscipline!, ownership: selectedOwner, staying: selectedStaying));
                                                                            if (context.mounted) {
                                                                              await localHorseCubit.getAllHorses(state.tripId);
                                                                              Navigator.pop(context);
                                                                            }
                                                                          }
                                                                        },
                                                                        child: const Text(
                                                                            "Save")),
                                                                  ],
                                                                ),
                                                                const SizedBox(
                                                                  height: 50,
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        );
                                                      }),
                                                    ),
                                                  ),
                                                ),
                                              ]);
                                            },
                                          );
                                        }
                                      },
                                      child: Row(
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Horse ${index + 1}",
                                                style: state.items[index]
                                                        .staying.isNotEmpty
                                                    ? AppStyles
                                                        .summaryTitleStyle
                                                    : const TextStyle(
                                                        color: AppColors.grey),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                state.items[index].horseName,
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
                                  itemCount: state.items.length),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Transform.translate(
                      offset: const Offset(-10.0, 0.0),
                      child: PrivacyCheckBox(
                          isTherePrivacy: true,
                          value: privacyValue,
                          isItForShipping: true,
                          onChanged: (value) {
                            setState(() {
                              privacyValue = value!;
                            });
                          }),
                    ),
                    const Spacer(),
                    RebiButton(
                        backgroundColor: privacyValue
                            ? AppColors.yellow
                            : AppColors.formsHintFontLight,
                        onPressed: () {
                          Print(state.items.length);
                          for (int i = 0; i < state.items.length; i++) {
                            Print('Owner ship ${state.items[i].ownership}');
                            Print('staying ${state.items[i].staying}');
                            Print(' gender ${state.items[i].gender}');
                            Print('name ${state.items[i].horseName}');
                            Print('Dec ${state.items[i].discipline}');
                          }

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
                  ]);
            }
            return Container(
              color: Colors.grey,
            );
          },
        ),
      ),
    );
  }
}
