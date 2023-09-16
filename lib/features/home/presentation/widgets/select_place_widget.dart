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
  final String title;
  List<String> showingList;

  SelectPlaceWidget(
      {Key? key,
      required this.location,
      required this.title,
      required this.showingList})
      : super(key: key);

  @override
  State<SelectPlaceWidget> createState() => _SelectPlaceWidgetState();
}

class _SelectPlaceWidgetState extends State<SelectPlaceWidget> {
  String? selectedPlace;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kPadding, vertical: 6),
      child: RebiInput(
        hintText: widget.title.tra,
        controller: widget.location,
        keyboardType: TextInputType.name,
        textInputAction: TextInputAction.done,
        autoValidateMode: AutovalidateMode.onUserInteraction,
        isOptional: false,
        color: AppColors.formsLabel,
        onTap: () {
          showHospitalsAndPlacesBottomSheet(
            context: context,
            title: "Select Place",
            content: SingleChildScrollView(
              child: StatefulBuilder(builder: (context, setState) {
                if (widget.showingList.isNotEmpty) {
                  return ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: widget.showingList.length,
                    separatorBuilder: (context, index) {
                      return const CustomDivider();
                    },
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedPlace = widget.showingList[index];

                            widget.location.text = widget.showingList[index];

                            Navigator.pop(context);
                            Print("Selected Place ${places[index]}");
                            Print("Place Name $selectedPlace");
                          });
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(widget.showingList[index])
                          ],
                        ),
                      );
                    },
                  );
                } else {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      SizedBox(
                        height: 100,
                      ),
                      Center(
                        child: Text("No Places"),
                      ),
                    ],
                  );
                }
              }),
            ),
          );
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
