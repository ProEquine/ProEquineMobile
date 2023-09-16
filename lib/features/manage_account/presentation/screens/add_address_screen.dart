import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_country_state/flutter_country_state.dart';
import 'package:proequine/core/constants/constants.dart';
import 'package:proequine/core/utils/extensions.dart';
import 'package:proequine/core/utils/rebi_message.dart';
import 'package:proequine/core/widgets/divider.dart';
import 'package:proequine/core/widgets/global_bottom_sheet.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/constants/colors/app_colors.dart';
import '../../../../core/utils/Printer.dart';
import '../../../../core/utils/validator.dart';
import '../../../../core/widgets/custom_header.dart';
import '../../../../core/widgets/rebi_button.dart';
import '../../../../core/widgets/rebi_input.dart';
import 'package:intl/date_symbol_data_local.dart';

class AddAddressScreen extends StatefulWidget {
  const AddAddressScreen({super.key});

  @override
  State<AddAddressScreen> createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  late final TextEditingController city;
  late final TextEditingController address;
  late final TextEditingController code;
  late final TextEditingController country;
  late final TextEditingController state;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? selectedGender;
  String? selectedState;
  String? selectedCity;

  @override
  void initState() {
    initializeDateFormatting();
    city = TextEditingController();
    code = TextEditingController();
    address = TextEditingController();
    country = TextEditingController();
    state = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    address.dispose();
    code.dispose();
    city.dispose();
    country.dispose();
    state.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(20.h),
        child: CustomHeader(
          title: "Address",
          isThereBackButton: true,
          isThereChangeWithNavigate: false,
          isThereThirdOption: false,
        ),
      ),
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraint) {
            return Form(
              key: _formKey,
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraint.maxHeight),
                child: IntrinsicHeight(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.symmetric(horizontal: kPadding),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 7),
                              child: RebiInput(
                                hintText: 'Country'.tra,
                                controller: country,
                                keyboardType: TextInputType.name,
                                textInputAction: TextInputAction.done,
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
                                      onSelect: (Country selectedCountry) {
                                        country.text = selectedCountry.name;
                                        state.text = '';

                                        city.text = '';
                                        setState(() {
                                          Variables.country =
                                              selectedCountry.name;
                                        });
                                      });
                                },
                                autoValidateMode:
                                    AutovalidateMode.onUserInteraction,
                                isOptional: false,
                                color: AppColors.formsLabel,
                                readOnly: true,
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 13),
                                obscureText: false,
                                validator: (value) {},
                              ),
                            ),
                            Visibility(
                              visible: country.text == '' ? false : true,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 7),
                                child: country.text == 'United Arab Emirates'
                                    ? RebiInput(
                                        hintText: 'State'.tra,
                                        controller: state,
                                        keyboardType: TextInputType.name,
                                        textInputAction: TextInputAction.done,
                                        onTap: () {
                                          Print("States is ${Variables.state}");
                                          showModalBottomSheet(
                                            isScrollControlled: true,
                                            shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(40.0),
                                                topRight: Radius.circular(40.0),
                                              ),
                                            ),
                                            context: context,
                                            isDismissible: false,
                                            builder: (context) => SizedBox(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.8,
                                              child: StateDialog(
                                                stateHeaderStyle:
                                                    const TextStyle(
                                                        color: AppColors
                                                            .blackLight,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                style: const TextStyle(
                                                    color: AppColors.blackLight,
                                                    fontWeight:
                                                        FontWeight.w500),
                                                subStringStyle: const TextStyle(
                                                    color:
                                                        AppColors.blackLight),
                                                substringBackground:
                                                    AppColors.blackLight,
                                                selectedStateBackgroundColor:
                                                    AppColors
                                                        .backgroundColorLight,
                                                notSelectedStateBackgroundColor:
                                                    AppColors
                                                        .backgroundColorLight,
                                                onSelectedState: () {
                                                  setState(() {
                                                    state.text =
                                                        Variables.state;
                                                    city.text = '';
                                                    Print(
                                                        "choosed state ${state.text}");
                                                  });
                                                },
                                              ),
                                            ),
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
                                        validator: (value) {},
                                      )
                                    : RebiInput(
                                        hintText: 'State'.tra,
                                        controller: state,
                                        keyboardType: TextInputType.name,
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
                                              state.text);
                                        },
                                      ),
                              ),
                            ),
                            Visibility(
                              visible: state.text == '' ? false : true,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 7),
                                child: country.text == 'United Arab Emirates'
                                    ? RebiInput(
                                        hintText: 'City'.tra,
                                        controller: city,
                                        keyboardType: TextInputType.name,
                                        textInputAction: TextInputAction.done,
                                        isOptional: false,
                                        onTap: () {
                                          if (state.text.isNotEmpty &&
                                              cityData
                                                  .containsKey(state.text)) {
                                            List<String> citiesInEmirate =
                                                cityData[state.text]!;
                                            showGlobalBottomSheet(
                                                height: 75.0.h,
                                                context: context,
                                                title: "Select City",
                                                content: ListView.separated(
                                                  shrinkWrap: true,
                                                  physics:
                                                      NeverScrollableScrollPhysics(),
                                                  separatorBuilder:
                                                      (context, index) {
                                                    return CustomDivider();
                                                  },
                                                  itemCount:
                                                      citiesInEmirate.length,
                                                  itemBuilder:
                                                      (BuildContext context,
                                                          int index) {
                                                    return GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          city.text =
                                                              citiesInEmirate[
                                                                  index];
                                                        });
                                                        Navigator.pop(context);
                                                      },
                                                      child: ListTile(
                                                        title: Text(
                                                            citiesInEmirate[
                                                                index]),
                                                        // Add other ListTile properties as needed
                                                      ),
                                                    );
                                                  },
                                                ));
                                          } else {
                                            RebiMessage.error(
                                                msg:
                                                    "Please Select correct state",
                                                context: context);
                                          }
                                        },
                                        color: AppColors.formsLabel,
                                        readOnly: true,
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 20, vertical: 13),
                                        obscureText: false,
                                        validator: (value) {
                                          return Validator.requiredValidator(
                                              city.text);
                                        },
                                      )
                                    : RebiInput(
                                        hintText: 'City'.tra,
                                        controller: city,
                                        keyboardType: TextInputType.name,
                                        textInputAction: TextInputAction.done,
                                        isOptional: false,
                                        color: AppColors.formsLabel,
                                        readOnly: false,
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 20, vertical: 13),
                                        obscureText: false,
                                        validator: (value) {
                                          return Validator.requiredValidator(
                                              city.text);
                                        },
                                      ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 7),
                              child: RebiInput(
                                hintText: 'Address'.tra,
                                controller: address,
                                keyboardType: TextInputType.name,
                                textInputAction: TextInputAction.done,
                                isOptional: false,
                                color: AppColors.formsLabel,
                                readOnly: false,
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 13),
                                obscureText: false,
                                validator: (value) {
                                  return Validator.requiredValidator(
                                      address.text);
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.all(kPadding),
                        child: RebiButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate() &&
                                country.text.isNotEmpty &&
                                (selectedCity != null ||
                                    city.text.isNotEmpty) &&
                                (selectedState != null ||
                                    state.text.isNotEmpty)) {
                              Print("Saved");
                              Navigator.pop(context);
                            }else{
                              RebiMessage.error(msg: "Please fill all of the fields", context: context);
                            }
                          },
                          child: const Text(
                            "Add",
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
