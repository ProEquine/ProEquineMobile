import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:proequine/core/constants/colors/app_colors.dart';
import 'package:proequine/core/constants/constants.dart';
import 'package:proequine/core/utils/extensions.dart';
import 'package:proequine/core/widgets/divider.dart';
import 'package:proequine/features/home/data/local_trip.dart';
import 'package:proequine/features/home/data/shipping_service_model.dart';
import 'package:proequine/features/home/domain/cubits/local_horse_cubit.dart';
import 'package:proequine/features/home/domain/repo/local_storage_repository.dart';
import 'package:proequine/features/home/presentation/screens/chose_horses_shipping_screen.dart';
import 'package:proequine/features/nav_bar/presentation/screens/bottomnavigation.dart';

import '../../../../core/global_functions/global_statics_drop_down.dart';
import '../../../../core/utils/Printer.dart';
import '../../../../core/utils/rebi_message.dart';
import '../../../../core/utils/sharedpreferences/SharedPreferencesHelper.dart';
import '../../../../core/utils/validator.dart';
import '../../../../core/widgets/date_time_picker.dart';
import '../../../../core/widgets/drop_down_menu_widget.dart';
import '../../../../core/widgets/phone_number_field_widget.dart';
import '../../../../core/widgets/rebi_button.dart';
import '../../../../core/widgets/rebi_input.dart';
import '../widgets/select_place_widget.dart';

class EditTripScreen extends StatefulWidget {
  final Trip trip;
  bool isFromEditing=false;

  EditTripScreen({
    required this.trip,
     this.isFromEditing=false,
    super.key,
  });

  @override
  EditTripScreenState createState() => EditTripScreenState();
}

class EditTripScreenState extends State<EditTripScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController pickUpLocation = TextEditingController();
  TextEditingController notes = TextEditingController();
  TextEditingController pickUpContactName = TextEditingController();
  TextEditingController pickupCountry = TextEditingController();
  TextEditingController dropOfLocationUrl = TextEditingController();
  TextEditingController numberOfHorses = TextEditingController();
  TextEditingController pickUpContactNumber = TextEditingController();
  TextEditingController pickUpCountryCode = TextEditingController();

  TextEditingController dropLocation = TextEditingController();
  TextEditingController dropContactName = TextEditingController();
  TextEditingController dropContactNumber = TextEditingController();
  TextEditingController dropCountryCode = TextEditingController();
  TextEditingController pickUpLocationUrl = TextEditingController();
  TextEditingController exportingCountry = TextEditingController();
  DateTime focusedDay = DateTime.now();
  TextEditingController? estimatedDate;

  late DateTime dateTime;
  late DateTime pickDate;

  String convertToTime(DateTime dateTime) {
    final time = DateFormat.Hm().format(dateTime);
    return time;
  }

  String? selectedTrip;
  String? selectedCountryIso2;
  LocalHorseCubit localHorseCubit =
      LocalHorseCubit(localStorageRepository: LocalStorageRepository());
  LocalStorageRepository local = LocalStorageRepository();

  @override
  void initState() {
    initializeDateFormatting();
    pickDate = DateTime.now();
    dateTime = DateTime.now();
    estimatedDate = TextEditingController();
    selectedTrip = "Other day return";

    super.initState();
  }

  bool? isEmailVerified = false;
  DateTime? currentBackPressTime;

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > const Duration(seconds: 0)) {
      currentBackPressTime = now;
      return Future.value(true);
    }
    return Future.value(true);
  }

  @override
  void dispose() {
    estimatedDate?.dispose();
    super.dispose();
  }

  String? selectedNumber;
  String? phoneNumber;
  String? selectedEquipment = '';
  bool equipmentValue = false;

  @override
  Widget build(BuildContext context) {
    isEmailVerified = ModalRoute.of(context)?.settings.arguments as bool?;
    isEmailVerified ??= false;
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text("Edit Shipping",
              style: TextStyle(
                  fontSize: 17,
                  fontFamily: "notosan",
                  fontWeight: FontWeight.w600,
                  color: AppSharedPreferences.getTheme == 'ThemeCubitMode.dark'
                      ? Colors.white
                      : AppColors.blackLight)),
          centerTitle: true,
          backgroundColor:
              AppSharedPreferences.getTheme == 'ThemeCubitMode.dark'
                  ? Colors.transparent
                  : AppColors.backgroundColorLight,
          leading: Padding(
            padding: const EdgeInsets.symmetric(horizontal: kPadding),
            child: Align(
                alignment: Alignment.centerLeft,
                child: InkWell(
                  onTap: () {
                    if (isEmailVerified!) {
                      Navigator.pop(context);
                      Navigator.pop(context);
                      Navigator.pop(context);
                    } else {
                      Navigator.pop(context);
                    }
                  },
                  child: Icon(
                    Icons.arrow_back_ios_new,
                    color:
                        AppSharedPreferences.getTheme == 'ThemeCubitMode.dark'
                            ? Colors.white
                            : AppColors.blackLight,
                  ),
                )),
          ),
          actions: [
            BlocConsumer<LocalHorseCubit, LocalHorseState>(
              bloc: localHorseCubit,
              listener: (context, state) {
                if (state is DeleteTripSuccessfully) {
                  Print(state);
                  RebiMessage.success(
                      msg: "Trip delete successfully", context: context);

                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const BottomNavigation(
                                selectedIndex: 1,
                              )));
                }
              },
              builder: (context, state) {
                return GestureDetector(
                  onTap: () {
                    _onPressDeleteTrip(widget.trip, context);
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: kPadding,vertical: 20),
                    child:  Text(
                        "Remove",
                        textAlign: TextAlign.end,
                        style: TextStyle(
                          color:  AppColors.red,
                          fontSize: 14,
                          fontFamily: 'notosan',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                  ),

                );
              },
            )
          ],
        ),
        body: LayoutBuilder(builder: (context, constraint) {
          return Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraint.maxHeight),
                child: IntrinsicHeight(
                  child: BlocConsumer<LocalHorseCubit, LocalHorseState>(
                    bloc: localHorseCubit..getTrip(widget.trip.tripId),
                    listener: (context, state) {
                      // TODO: implement listener
                    },
                    builder: (context, state) {
                      if (state is GetTripSuccessfully) {
                        estimatedDate!.text = state.trip.shippingEstimatedDate;
                        pickUpLocation.text = state.trip.pickupLocation;
                        numberOfHorses.text =
                            state.trip.numberOfHorses.toString();
                        pickUpContactName.text = state.trip.pickupContactName;
                        pickUpCountryCode.text = state.trip.pickupCountryCode;
                        pickUpContactNumber.text = state.trip.pickupPhoneNumber;
                        dropLocation.text = state.trip.dropLocation;
                        dropCountryCode.text = state.trip.dropCountryCode;
                        dropContactName.text = state.trip.dropContactName;
                        dropContactNumber.text = state.trip.dropPhoneNumber;
                        pickupCountry.text = state.trip.importingCountry;
                        selectedEquipment = state.trip.equipmentTask;
                        pickUpLocationUrl.text = state.trip.pickupLocation;
                        exportingCountry.text = state.trip.exportingCountry;

                        if (state.trip.type == "import") {
                          return Column(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: kPadding, vertical: 6),
                                    child: RebiInput(
                                      hintText: 'Shipping Estimated Date '.tra,
                                      controller: estimatedDate,
                                      keyboardType: TextInputType.text,
                                      textInputAction: TextInputAction.done,
                                      onTap: () {
                                        selectDate(
                                          context: context,
                                          from: DateTime.now(),
                                          to: DateTime(2025, 1, 1),
                                          isSupportChangingYears: false,
                                          selectedOurDay: dateTime,
                                          controller: estimatedDate!,
                                          focusDay: focusedDay,
                                        );
                                      },
                                      autoValidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      isOptional: false,
                                      color: AppColors.formsLabel,
                                      readOnly: true,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 13),
                                      obscureText: false,
                                      validator: (value) {
                                        if (value!.isNotEmpty) {
                                          DateFormat inputFormat =
                                              DateFormat("dd MMM yyyy");
                                          DateTime setUpdatedDate =
                                              inputFormat.parse(value);
                                          pickDate = setUpdatedDate;
                                        } else {
                                          return 'please select date';
                                        }

                                        if (dateTime.isBefore(DateTime.now()) &&
                                            !dateTime
                                                .isSameDate(DateTime.now())) {
                                          return 'correct date please';
                                        }
                                        return Validator.requiredValidator(
                                            estimatedDate?.text);
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: kPadding, vertical: 7),
                                    child: RebiInput(

                                      hintText: 'Importing country'.tra,
                                      controller: pickupCountry,
                                      keyboardType: TextInputType.text,
                                      textInputAction: TextInputAction.done,
                                      autoValidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      isOptional: false,
                                      color: AppColors.formsLabel,
                                      readOnly: true,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 13),
                                      obscureText: false,
                                      validator: (value) {
                                        return Validator.countryCodeValidator(
                                            pickUpCountryCode.text);
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: kPadding,
                                        right: kPadding,
                                        bottom: 6),
                                    child: RebiInput(
                                      hintText: 'Pickup Location'.tra,
                                      controller: pickUpLocation,
                                      keyboardType: TextInputType.text,
                                      textInputAction: TextInputAction.done,
                                      autoValidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      isOptional: false,
                                      color: AppColors.formsLabel,
                                      readOnly: false,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 13),
                                      obscureText: false,
                                      validator: (value) {
                                        return Validator.requiredValidator(
                                            pickUpLocation.text);
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: kPadding, vertical: 6),
                                    child: RebiInput(
                                      hintText: 'Pickup contact name'.tra,
                                      controller: pickUpContactName,
                                      keyboardType: TextInputType.text,
                                      textInputAction: TextInputAction.done,
                                      autoValidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      isOptional: false,
                                      color: AppColors.formsLabel,
                                      readOnly: false,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 13),
                                      obscureText: false,
                                      validator: (value) {
                                        return Validator.requiredValidator(
                                            pickUpContactName.text);
                                      },
                                    ),
                                  ),
                                  PhoneNumberFieldWidget(
                                      countryCode: pickUpCountryCode,
                                      phoneNumber: pickUpContactNumber),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: kPadding, vertical: 6),
                                    child: RebiInput(
                                      hintText: 'Number Of Horses'.tra,
                                      controller: numberOfHorses,
                                      keyboardType: TextInputType.number,
                                      textInputAction: TextInputAction.done,
                                      autoValidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      inputFormatters: [
                                        LengthLimitingTextInputFormatter(2),
                                        // Limit input to 2 characters
                                        FilteringTextInputFormatter.digitsOnly,
                                        // Only allow digits
                                      ],
                                      isOptional: false,
                                      color: AppColors.formsLabel,
                                      readOnly: false,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 13),
                                      obscureText: false,
                                      validator: (value) {
                                        return Validator.validateHorseNumber(
                                            numberOfHorses.text);
                                      },
                                    ),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: kPadding, vertical: 5),
                                    child: CustomDivider(),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: kPadding, vertical: 15),
                                    child: Text(
                                      'Delivery address in UAE',
                                      style: TextStyle(
                                        color: AppColors.formsHintFontLight,
                                        fontSize: 15,
                                        fontFamily: 'notosan',
                                        fontWeight: FontWeight.w500,
                                        height: 0.11,
                                      ),
                                    ),
                                  ),
                                  SelectPlaceWidget(
                                    location: dropLocation,
                                    showingList: placesList,
                                    title: "Drop Location",
                                    hintText: 'Place',
                                    newPlaceUrl: dropOfLocationUrl,
                                    type: "Shipping Import",
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: kPadding, vertical: 6),
                                    child: RebiInput(
                                      hintText: 'Drop contact name'.tra,
                                      controller: dropContactName,
                                      keyboardType: TextInputType.text,
                                      textInputAction: TextInputAction.done,
                                      autoValidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      isOptional: false,
                                      color: AppColors.formsLabel,
                                      readOnly: false,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 13),
                                      obscureText: false,
                                      validator: (value) {
                                        return Validator.requiredValidator(
                                            dropContactName.text);
                                      },
                                    ),
                                  ),
                                  PhoneNumberFieldWidget(
                                      countryCode: dropCountryCode,
                                      phoneNumber: dropContactNumber),
                                ],
                              ),
                              const Spacer(),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: kPadding),
                                child: RebiButton(
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        phoneNumber = pickUpCountryCode.text +
                                            pickUpContactNumber.text;
                                        Print(phoneNumber);
                                        local.editSpecificTrip(
                                            widget.trip.tripId,
                                            Trip(
                                              tripId: widget.trip.tripId,
                                              shippingEstimatedDate:
                                                  estimatedDate!.text,
                                              exportingCountry:
                                                  selectedCountryIso2 ??
                                                      state.trip
                                                          .exportingCountry,
                                              pickupLocation:
                                                  pickUpLocation.text,
                                              pickupContactName:
                                                  pickUpContactName.text,
                                              equipmentTask: selectedEquipment!,
                                              numberOfHorses: int.parse(
                                                  numberOfHorses.text),
                                              importingCountry:
                                                  selectedCountryIso2 ??
                                                      state.trip
                                                          .importingCountry,
                                              type: 'import',
                                              pickupCountryCode:
                                                  pickUpCountryCode.text,
                                              pickupPhoneNumber:
                                                  pickUpContactNumber.text,
                                              dropLocation: dropLocation.text,
                                              dropContactName:
                                                  dropContactName.text,
                                              dropCountryCode:
                                                  dropCountryCode.text,
                                              dropPhoneNumber:
                                                  dropContactNumber.text,
                                              horses: widget.trip.horses,
                                            ));
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ChoseShippingHorseScreen(
                                                      isItFromEditing: true,
                                                      serviceModel: ShippingServiceModel(
                                                          pickupContactName:
                                                              pickUpContactName
                                                                  .text,
                                                          pickupLocation:
                                                              pickUpLocation
                                                                  .text,
                                                          tripId: widget
                                                              .trip.tripId,
                                                          horsesNumber:
                                                              numberOfHorses
                                                                  .text,
                                                          pickupContactNumber:
                                                              phoneNumber!,
                                                          shipmentEstimatedDate:
                                                              pickDate,
                                                          selectedCountry:
                                                              selectedCountryIso2 ??
                                                                  state.trip.importingCountry,
                                                          serviceType:
                                                              'Import'),
                                                    )));
                                      }
                                    },
                                    child: const Text("Next")),
                              ),
                              const SizedBox(
                                height: 30,
                              )
                            ],
                          );
                        } else {
                          return Column(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: kPadding, vertical: 7),
                                    child: RebiInput(
                                      hintText: 'Shipping Estemated Date '.tra,
                                      controller: estimatedDate,
                                      keyboardType: TextInputType.text,
                                      textInputAction: TextInputAction.done,
                                      onTap: () {
                                        selectDate(
                                          context: context,
                                          from: DateTime.now(),
                                          to: DateTime(2025, 1, 1),
                                          isSupportChangingYears: false,
                                          selectedOurDay: dateTime,
                                          controller: estimatedDate!,
                                          focusDay: focusedDay,
                                        );
                                      },
                                      autoValidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      isOptional: false,
                                      color: AppColors.formsLabel,
                                      readOnly: true,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 13),
                                      obscureText: false,
                                      validator: (value) {
                                        if (value!.isNotEmpty) {
                                          DateFormat inputFormat =
                                              DateFormat("dd MMM yyyy");
                                          DateTime setUpdatedDate =
                                              inputFormat.parse(value);
                                          pickDate = setUpdatedDate;
                                        } else {
                                          return 'please select date';
                                        }

                                        if (dateTime.isBefore(DateTime.now()) &&
                                            !dateTime
                                                .isSameDate(DateTime.now())) {
                                          return 'correct date please';
                                        }
                                        return Validator.requiredValidator(
                                            estimatedDate?.text);
                                      },
                                    ),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 17, vertical: 20),
                                    child: Text(
                                      'Pick Up Address in UAE',
                                      style: TextStyle(
                                        color: AppColors.formsHintFontLight,
                                        fontSize: 14,
                                        fontFamily: 'notosan',
                                        fontWeight: FontWeight.w500,
                                        height: 0.11,
                                      ),
                                    ),
                                  ),
                                  SelectPlaceWidget(
                                    location: pickUpLocation,
                                    showingList: placesList,
                                    title: "Pickup Location",
                                    hintText: 'Place',
                                    newPlaceUrl: pickUpLocationUrl,
                                    type: "Shipping Export",
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: kPadding, vertical: 6),
                                    child: RebiInput(
                                      hintText: 'Pickup contact name'.tra,
                                      controller: pickUpContactName,
                                      keyboardType: TextInputType.text,
                                      textInputAction: TextInputAction.done,
                                      autoValidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      isOptional: false,
                                      color: AppColors.formsLabel,
                                      readOnly: false,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 13),
                                      obscureText: false,
                                      validator: (value) {
                                        return Validator.requiredValidator(
                                            pickUpContactName.text);
                                      },
                                    ),
                                  ),
                                  PhoneNumberFieldWidget(
                                      countryCode: pickUpCountryCode,
                                      phoneNumber: pickUpContactNumber),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: kPadding, vertical: 6),
                                    child: RebiInput(
                                      hintText: 'Number Of Horses'.tra,
                                      controller: numberOfHorses,
                                      keyboardType: TextInputType.number,
                                      textInputAction: TextInputAction.done,
                                      autoValidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      inputFormatters: [
                                        LengthLimitingTextInputFormatter(2),
                                        // Limit input to 2 characters
                                        FilteringTextInputFormatter.digitsOnly,
                                        // Only allow digits
                                      ],
                                      isOptional: false,
                                      color: AppColors.formsLabel,
                                      readOnly: false,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 13),
                                      obscureText: false,
                                      validator: (value) {
                                        return Validator.validateHorseNumber(
                                            numberOfHorses.text);
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 7, horizontal: kPadding),
                                    child: DropDownWidget(
                                      items: equipments,
                                      selected: selectedEquipment,
                                      onChanged: (equipment) {
                                        setState(() {
                                          selectedEquipment = equipment;
                                        });
                                      },
                                      validator: (value) {
                                        return Validator.requiredValidator(
                                            selectedEquipment);
                                      },
                                      hint: 'Equipment Tack',
                                    ),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: kPadding, vertical: 5),
                                    child: CustomDivider(),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: kPadding, vertical: 7),
                                    child: RebiInput(
                                      hintText: 'Exporting country'.tra,
                                      controller: exportingCountry,
                                      keyboardType: TextInputType.text,
                                      textInputAction: TextInputAction.done,
                                      autoValidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      isOptional: false,
                                      color: AppColors.formsLabel,
                                      readOnly: true,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 13),
                                      obscureText: false,
                                      validator: (value) {
                                        return Validator.countryCodeValidator(
                                            pickUpCountryCode.text);
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: kPadding,
                                        right: kPadding,
                                        bottom: 6),
                                    child: RebiInput(
                                      hintText: 'Drop Location'.tra,
                                      controller: dropLocation,
                                      keyboardType: TextInputType.text,
                                      textInputAction: TextInputAction.done,
                                      autoValidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      isOptional: false,
                                      color: AppColors.formsLabel,
                                      readOnly: false,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 13),
                                      obscureText: false,
                                      validator: (value) {
                                        return Validator.requiredValidator(
                                            dropLocation.text);
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: kPadding, vertical: 6),
                                    child: RebiInput(
                                      hintText: 'Drop contact name'.tra,
                                      controller: dropContactName,
                                      keyboardType: TextInputType.text,
                                      textInputAction: TextInputAction.done,
                                      autoValidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      isOptional: false,
                                      color: AppColors.formsLabel,
                                      readOnly: false,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 13),
                                      obscureText: false,
                                      validator: (value) {
                                        return Validator.requiredValidator(
                                            dropContactName.text);
                                      },
                                    ),
                                  ),
                                  PhoneNumberFieldWidget(
                                      countryCode: dropCountryCode,
                                      phoneNumber: dropContactNumber),
                                ],
                              ),
                              const SizedBox(
                                height: 14,
                              ),
                              const Spacer(),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: kPadding),
                                child: RebiButton(
                                    onPressed: () {
                                      phoneNumber = pickUpCountryCode.text +
                                          pickUpContactNumber.text;
                                      LocalStorageRepository local =
                                          LocalStorageRepository();

                                      local.editSpecificTrip(
                                          widget.trip.tripId,
                                          Trip(
                                            tripId: widget.trip.tripId,
                                            shippingEstimatedDate:
                                                estimatedDate!.text,
                                            exportingCountry:
                                                state.trip.exportingCountry,
                                            pickupLocation: pickUpLocation.text,
                                            pickupContactName:
                                                pickUpContactName.text,
                                            equipmentTask: selectedEquipment!,
                                            numberOfHorses:
                                                int.parse(numberOfHorses.text),
                                            importingCountry:
                                            state.trip.importingCountry,
                                            type: 'export',
                                            pickupCountryCode:
                                                pickUpCountryCode.text,
                                            pickupPhoneNumber:
                                                pickUpContactNumber.text,
                                            dropLocation: dropLocation.text,
                                            dropContactName:
                                                dropContactName.text,
                                            dropCountryCode:
                                                dropCountryCode.text,
                                            dropPhoneNumber:
                                                dropContactNumber.text,
                                            horses: widget.trip.horses,
                                          ));
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ChoseShippingHorseScreen(
                                                    isItFromEditing: true,
                                                    serviceModel: ShippingServiceModel(
                                                        pickupContactName:
                                                        pickUpContactName
                                                            .text,
                                                        equipment: selectedEquipment??state.trip.equipmentTask,

                                                        pickupLocation:
                                                        pickUpLocation
                                                            .text,
                                                        tripId: widget
                                                            .trip.tripId,
                                                        horsesNumber:
                                                        numberOfHorses
                                                            .text,
                                                        pickupContactNumber:
                                                        phoneNumber!,
                                                        shipmentEstimatedDate:
                                                        pickDate,
                                                        selectedCountry:
                                                        selectedCountryIso2 ??
                                                            state.trip.importingCountry,
                                                        serviceType:
                                                        'Export'),
                                                  )));
                                    },
                                    child: const Text("Next")),
                              ),
                              const SizedBox(
                                height: 30,
                              )
                            ],
                          );
                        }
                      }
                      return Container();
                    },
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  _onPressDeleteTrip(Trip trip, BuildContext context) {
    localHorseCubit.deleteTrip(DeleteTripSuccessfully(item: trip));
  }
}
