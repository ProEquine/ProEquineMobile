import 'package:flutter/material.dart';
import 'package:proequine/core/utils/extensions.dart';

import '../../../../core/constants/colors/app_colors.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/utils/Printer.dart';
import '../../../../core/utils/validator.dart';
import '../../../../core/widgets/divider.dart';
import '../../../../core/widgets/rebi_input.dart';
import 'hospital_bottom_sheet.dart';

class SelectPlaceWidget extends StatefulWidget {
  TextEditingController location = TextEditingController();

  SelectPlaceWidget({Key? key, required this.location}) : super(key: key);

  @override
  State<SelectPlaceWidget> createState() => _SelectPlaceWidgetState();
}

class _SelectPlaceWidgetState extends State<SelectPlaceWidget> {
  List<String> filteredEmirates = [
    'All',
    'AUD',
    'DXB',
    'SHJ',
    'AUJ',
    'UAQ',
    'RKT',
    'FJR',
  ];

  String getFullName(String abbreviation) {
    // Define a mapping between abbreviations and full names
    final Map<String, String> abbreviationMap = {
      'AUD': 'Abu Dhabi',
      'DXB': 'Dubai',
      'SHJ': 'Sharjah',
      'AUJ': 'Ajman',
      'UAQ': 'Quwain',
      'RKT': 'Ras Al Khaimah',
      'FJR': 'Fujairah',
    };

    return abbreviationMap[abbreviation] ?? abbreviation;
  }

  String? selectedPlace;

  String selectedFilter = 'All';
  String selected = 'All';
  List<String> filteredForList = [];
  TextEditingController search = TextEditingController();
  String query = '';
  List<String> showingList = [];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kPadding, vertical: 6),
      child: RebiInput(
        hintText: 'Pickup Location'.tra,
        controller: widget.location,
        keyboardType: TextInputType.name,
        textInputAction: TextInputAction.done,
        autoValidateMode: AutovalidateMode.onUserInteraction,
        isOptional: false,
        color: AppColors.formsLabel,
        onTap: () {
          List<String> filteredPlaces = [];
          if (places.containsKey(selectedFilter)) {
            Print("True");
            showHospitalsAndPlacesBottomSheet(
                context: context,
                title: "Select Place",
                content: SingleChildScrollView(
                  child: StatefulBuilder(builder: (context, setState) {
                    return Column(
                      children: [
                        RebiInput(
                          hintText: 'Search'.tra,
                          controller: search,
                          keyboardType: TextInputType.name,
                          textInputAction: TextInputAction.done,
                          isOptional: false,
                          color: AppColors.formsLabel,
                          onChanged: (value) {
                            setState(() {
                              query = value!;
                            });
                          },
                          readOnly: false,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 13),
                          obscureText: false,
                          validator: (value) {
                            return Validator.requiredValidator(search.text);
                          },
                        ),
                        const SizedBox(height: 10,),
                        SizedBox(
                          height: 25,
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: filteredEmirates.length,
                            itemBuilder: (context, index) {
                              bool isSelected =
                                  filteredEmirates[index] == selected;
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedFilter =
                                        getFullName(filteredEmirates[index]);
                                    selected = filteredEmirates[index];
                                    filteredPlaces =
                                        places[selectedFilter] ?? [''];
                                    filteredForList = filteredPlaces;
                                    showingList = filteredForList;
                                  });
                                  print(selectedFilter);
                                  print(filteredEmirates[index]);
                                  print(places[selectedFilter]);
                                  print('filteredPlaces$filteredPlaces');
                                },
                                child: Container(
                                  width: 70,
                                  // Adjust the width as needed
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  decoration: ShapeDecoration(
                                    color: isSelected
                                        ? AppColors.yellow
                                        : AppColors.backgroundColorLight,
                                    shape: RoundedRectangleBorder(
                                      side: const BorderSide(
                                          width: 0.50,
                                          color: AppColors.borderColor),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      filteredEmirates[index],
                                      style: TextStyle(
                                        color: isSelected
                                            ? AppColors.whiteLight
                                            : AppColors.yellow,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        StatefulBuilder(builder: (context, setState) {
                          final filteredSearchPlaces = filteredForList
                              .where((place) => place
                                  .toLowerCase()
                                  .contains(query.toLowerCase()))
                              .toList();

                          filteredPlaces = places[selectedFilter] ?? [];

                          if (search.text != '') {
                            setState(() {
                              showingList = filteredSearchPlaces;
                            });
                          } else {
                            setState(() {
                              filteredForList = filteredPlaces;
                              showingList = filteredForList;
                            });
                          }

                          Print('filteredPlaces from list$filteredPlaces');

                          if (showingList.isNotEmpty) {
                            return ListView.separated(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: showingList.length,
                              separatorBuilder: (context, index) {
                                return const CustomDivider();
                              },
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedPlace = showingList[index];

                                      widget.location.text = showingList[index];

                                      Navigator.pop(context);
                                      Print("Selected Place ${places[index]}");
                                      Print("Place Name $selectedPlace");
                                    });
                                  },
                                  child: ListTile(
                                    minVerticalPadding: 10,
                                    title: Text(showingList[index]),
                                  ),
                                );
                              },
                            );
                          } else {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Center(
                                  child: Text("Empty"),
                                ),
                              ],
                            );
                          }
                        }),
                      ],
                    );
                  }),
                ));
          } else {
            Print('false');
          }
        },
        readOnly: true,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
        obscureText: false,
        validator: (value) {
          return Validator.requiredValidator(widget.location.text);
        },
      ),
    );
  }
}
