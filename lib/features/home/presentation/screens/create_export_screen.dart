import 'package:country_picker/country_picker.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:proequine/core/constants/colors/app_colors.dart';
import 'package:proequine/core/constants/constants.dart';
import 'package:proequine/core/utils/extensions.dart';
import 'package:proequine/core/widgets/phone_number_field_widget.dart';
import 'package:sizer/sizer.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/constants/routes/routes.dart';
import '../../../../core/constants/thems/app_styles.dart';
import '../../../../core/global_functions/global_statics_drop_down.dart';
import '../../../../core/utils/sharedpreferences/SharedPreferencesHelper.dart';
import '../../../../core/utils/validator.dart';
import '../../../../core/widgets/date_time_picker.dart';
import '../../../../core/widgets/divider.dart';
import '../../../../core/widgets/drop_down_menu_widget.dart';
import '../../../../core/widgets/rebi_button.dart';
import '../../../../core/widgets/rebi_input.dart';
import '../../../../core/widgets/verify_dialog.dart';
import '../../../manage_account/data/verify_email_route.dart';
import '../../data/local_trip.dart';
import '../../data/shipping_service_model.dart';
import '../../domain/cubits/local_horse_cubit.dart';
import '../../domain/repo/local_storage_repository.dart';
import '../widgets/select_place_widget.dart';
import 'chose_horses_shipping_screen.dart';

class CreateExportScreen extends StatefulWidget {
  bool isFromEditing = false;
  String? exportCountry;

  String? importCountry;

  DateTime? estimatedDate;

  CreateExportScreen({
    this.isFromEditing = false,
    this.exportCountry,
    this.importCountry,
    this.estimatedDate,
    super.key,
  });

  @override
  CreateExportScreenState createState() => CreateExportScreenState();
}

class CreateExportScreenState extends State<CreateExportScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> checkBoxKey = GlobalKey<FormState>();
  TextEditingController pickUpLocation = TextEditingController();
  TextEditingController pickUpLocationUrl = TextEditingController();
  TextEditingController dropLocation = TextEditingController();
  TextEditingController notes = TextEditingController();
  TextEditingController pickUpContactName = TextEditingController();
  TextEditingController dropContactName = TextEditingController();
  TextEditingController dropContactNumber = TextEditingController();
  TextEditingController dropContactCountryCode =
      TextEditingController(text: "+971");

  TextEditingController numberOfHorses = TextEditingController();
  TextEditingController exportingCountry = TextEditingController();
  TextEditingController pickupCountry = TextEditingController();
  TextEditingController pickUpContactNumber = TextEditingController();
  TextEditingController pickUpCountryCode = TextEditingController(text: '+971');
  DateTime focusedDay = DateTime.now();
  TextEditingController? estimatedDate;


  late DateTime dateTime;
  late DateTime pickDate;

  Future<bool> checkVerificationStatus() async {
    if (AppSharedPreferences.getEmailVerified!) {
      return true;
    } else {
      await Future.delayed(
          const Duration(milliseconds: 50)); // Simulating an asynchronous call
      return false;
    }
  }

  String? selectedTrip;
  String? selectedEquipment;
  String? selectedCountryIso2;
  String? formatted;

  @override
  void initState() {
    checkVerificationStatus().then((verified) {
      if (!verified) {
        // If the account is not verified, show a dialog after a delay.
        Future.delayed(const Duration(milliseconds: 50), () {
          showUnverifiedAccountDialog(
            context: context,
            isThereNavigationBar: true,
            onPressVerify: () {
              Navigator.pushNamed(context, verifyEmail,
                  arguments: VerifyEmailRoute(
                      type: 'export',
                      email: AppSharedPreferences.userEmailAddress))
                  .then((value) {});
            },
          );
        });
      }
    });
    initializeDateFormatting();
    dateTime = DateTime.now();
    estimatedDate = TextEditingController();

    super.initState();
  }

  bool? isEmailVerified = false;
  DateTime? currentBackPressTime;
  String? phoneNumber;

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
  bool equipmentValue = false;
  LocalHorseCubit localHorseCubit =
      LocalHorseCubit(localStorageRepository: LocalStorageRepository());

  @override
  Widget build(BuildContext context) {
    var uuid = const Uuid();
    var v1 = uuid.v1(options: {
      'node': [0x01, 0x23, 0x45, 0x67, 0x89, 0xab],
      'clockSeq': 0x1234,
      'mSecs': DateTime.now().millisecondsSinceEpoch,
      'nSecs': 5678
    });
    isEmailVerified = ModalRoute.of(context)?.settings.arguments as bool?;
    isEmailVerified ??= false;
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text("Shipping Export",
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
        ),
        body: LayoutBuilder(builder: (context, constraint) {
          return Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraint.maxHeight),
                child: IntrinsicHeight(
                  child: Column(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Visibility(
                            visible: !widget.isFromEditing,
                            child: Padding(
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
                                contentPadding: const EdgeInsets.symmetric(
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
                                      !dateTime.isSameDate(DateTime.now())) {
                                    return 'correct date please';
                                  }
                                  return Validator.requiredValidator(
                                      estimatedDate?.text);
                                },
                              ),
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
                              contentPadding: const EdgeInsets.symmetric(
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
                              contentPadding: const EdgeInsets.symmetric(
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
                          Visibility(
                            visible: !widget.isFromEditing,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: kPadding, vertical: 7),
                              child: RebiInput(
                                hintText: 'Exporting country'.tra,
                                controller: exportingCountry,
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.done,
                                autoValidateMode:
                                    AutovalidateMode.onUserInteraction,
                                onTap: () {
                                  showCountryPicker(
                                      context: context,
                                      showPhoneCode: true,
                                      countryListTheme: CountryListThemeData(
                                        flagSize: 25,
                                        backgroundColor:
                                            AppColors.backgroundColorLight,
                                        textStyle: const TextStyle(
                                            fontSize: 16,
                                            color: AppColors.blackLight),
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
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(8)),
                                            borderSide: BorderSide(
                                              color: Color(0xFFDBD4C3),
                                              width: 0.50,
                                            ),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(8)),
                                            borderSide: BorderSide(
                                              color: Color(0xFFDBD4C3),
                                              width: 0.50,
                                            ),
                                          ),
                                        ),
                                      ),
                                      onSelect: (Country country) {
                                        exportingCountry.text = country.name;
                                        setState(() {
                                          selectedCountryIso2 =
                                              country.countryCode;
                                        });
                                      });
                                },
                                isOptional: false,
                                color: AppColors.formsLabel,
                                readOnly: true,
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 13),
                                obscureText: false,
                                validator: (value) {
                                  return Validator.countryCodeValidator(
                                      pickUpCountryCode.text);
                                },
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: kPadding, right: kPadding, bottom: 6),
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
                              contentPadding: const EdgeInsets.symmetric(
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
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 13),
                              obscureText: false,
                              validator: (value) {
                                return Validator.requiredValidator(
                                    dropContactName.text);
                              },
                            ),
                          ),
                          PhoneNumberFieldWidget(
                              countryCode: dropContactCountryCode,
                              phoneNumber: dropContactNumber),
                        ],
                      ),
                      const SizedBox(
                        height: 14,
                      ),
                      const Spacer(),
                      Padding(
                        padding:
                            const EdgeInsets.symmetric(horizontal: kPadding),
                        child: RebiButton(
                            onPressed: () {
                              phoneNumber = pickUpCountryCode.text +
                                  pickUpContactNumber.text;
                              if (widget.isFromEditing) {
                                DateFormat formatter =
                                    DateFormat('dd MMM yyyy');
                                formatted =
                                    formatter.format(widget.estimatedDate!);
                              }

                              localHorseCubit.createTrip(CreateTripSuccessfully(
                                  item: Trip(
                                tripId: v1,
                                shippingEstimatedDate: widget.isFromEditing
                                    ? formatted!
                                    : estimatedDate!.text,
                                exportingCountry: widget.isFromEditing
                                    ? widget.exportCountry!
                                    : selectedCountryIso2 ?? 'AE',
                                pickupLocation: pickUpLocation.text,
                                pickupContactName: pickUpContactName.text,
                                equipmentTask: selectedEquipment.toString(),
                                numberOfHorses: int.parse(numberOfHorses.text),
                                importingCountry: widget.isFromEditing
                                    ? widget.importCountry!
                                    : selectedCountryIso2 ?? "AE",
                                type: 'export',
                                pickupCountryCode: pickUpCountryCode.text,
                                pickupPhoneNumber: pickUpContactNumber.text,
                                dropLocation: dropLocation.text,
                                dropContactName: dropContactName.text,
                                dropCountryCode: dropContactCountryCode.text,
                                dropPhoneNumber: dropContactNumber.text,
                                horses: [],
                              )));
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ChoseShippingHorseScreen(
                                            serviceModel: ShippingServiceModel(
                                                pickupContactName:
                                                    pickUpContactName.text,
                                                pickupLocation:
                                                    pickUpLocation.text,
                                                horsesNumber:
                                                    numberOfHorses.text,
                                                pickupContactNumber:
                                                    pickUpContactNumber.text,
                                                shipmentEstimatedDate: pickDate,
                                                tripId: v1,
                                                notes: notes.text,
                                                equipment: selectedEquipment,
                                                selectedCountry:
                                                    widget.isFromEditing
                                                        ? widget.exportCountry!
                                                        : selectedCountryIso2 ??
                                                            "AE",
                                                serviceType: 'Export'),
                                          )));
                            },
                            child: Text("Next", style: AppStyles.buttonStyle,)),
                      ),
                      const SizedBox(
                        height: 30,
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
