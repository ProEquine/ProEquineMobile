import 'package:flutter/material.dart';
import 'package:proequine/core/utils/extensions.dart';

import '../../../../core/constants/colors/app_colors.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/utils/Printer.dart';
import '../../../../core/utils/validator.dart';
import '../../../../core/widgets/divider.dart';
import '../../../../core/widgets/rebi_input.dart';
import '../../../user/presentation/widgets/selectable_type_container.dart';
import 'horses_bottom_sheet.dart';

class AddHorseContentWidget extends StatefulWidget {
  TextEditingController horsesController = TextEditingController();
  TextEditingController newHorsesController = TextEditingController();
  List<String> selectedHorses;
  List<String> selectedGenders;
  int? currentIndex;
  String? selectedHorse;
  String? selectedGender;
  bool isChoseNewHorse = false;

  AddHorseContentWidget(
      {Key? key,
      required this.newHorsesController,
      required this.horsesController,
      required this.selectedHorses,
      required this.selectedGenders,
      required this.selectedHorse,
      required this.isChoseNewHorse,
      required this.currentIndex,
      required this.selectedGender})
      : super(key: key);

  @override
  State<AddHorseContentWidget> createState() => _AddHorseContentWidgetState();
}

class _AddHorseContentWidgetState extends State<AddHorseContentWidget> {
  List<String> horsesNames = [
    'Koki',
    'Metha',
    'Saqr',
    'Al-Naama',
    'Al-Moshahar',
    'Add New Horse'
  ];
  final List<bool> _isGenderSelected = [false, false, false];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: kPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 7),
            child: RebiInput(
              hintText: 'Select Your Horse'.tra,
              controller: widget.horsesController,
              keyboardType: TextInputType.name,
              textInputAction: TextInputAction.done,
              autoValidateMode: AutovalidateMode.onUserInteraction,
              isOptional: false,
              color: AppColors.formsLabel,
              onTap: () {
                showHorsesBottomSheet(
                  context: context,
                  title: "Select Your horse",
                  content: ListView.separated(
                    shrinkWrap: true,
                    itemCount: horsesNames.length,
                    separatorBuilder: (context, index) {
                      return const CustomDivider();
                    },
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            widget.selectedHorse = horsesNames[index];
                            widget.horsesController.text =
                                widget.selectedHorse!;

                            Navigator.pop(context);
                          });
                          if (widget.selectedHorse == 'Add New Horse') {
                            setState(() {
                              widget.isChoseNewHorse = true;

                            });
                          } else {
                            setState(() {
                              widget.isChoseNewHorse = false;
                              widget.selectedHorses[widget.currentIndex!]=widget.horsesController.text;
                              widget.selectedGenders[widget.currentIndex!]='non';
                            });
                          }
                        },
                        child: ListTile(
                          title: Text(horsesNames[index]),
                        ),
                      );
                    },
                  ),
                );
              },
              readOnly: true,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
              obscureText: false,
              validator: (value) {
                return Validator.requiredValidator(
                    widget.horsesController.text);
              },
            ),
          ),
          Visibility(
            visible: widget.isChoseNewHorse,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 7),
              child: RebiInput(
                hintText: 'Horse Name'.tra,
                controller: widget.newHorsesController,
                scrollPadding: const EdgeInsets.only(bottom: 100),
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.done,
                onFieldSubmitted: (submited){
                  widget.selectedHorses[widget.currentIndex!]='New horse : ${widget.newHorsesController.text}';
                },
                autoValidateMode: AutovalidateMode.onUserInteraction,
                isOptional: false,
                onChanged: (value) {
                  setState(() {});
                },
                color: AppColors.formsLabel,
                readOnly: false,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
                obscureText: false,
                validator: (value) {
                  return Validator.requiredValidator(
                      widget.newHorsesController.text);
                },
              ),
            ),
          ),
          Visibility(
            visible: widget.isChoseNewHorse,
            child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 7.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 7,
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
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SelectableTypeContainer(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 35, vertical: 10),
                          label: 'Mare',
                          index: 0,
                          isSelected: _isGenderSelected[0],
                          onSelected: (bool value) {
                            _handleSelected(0, value, _isGenderSelected);
                            widget.selectedGender = 'Mare';
                            widget.selectedGenders[widget.currentIndex!]=widget.selectedGender!;
                            widget.selectedHorses[widget.currentIndex!]='New horse : ${widget.newHorsesController.text}';
                            Print("Selected gender ${widget.selectedGender}");
                          },
                        ),
                        SelectableTypeContainer(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 35, vertical: 10),
                          label: 'Gelding',
                          index: 1,
                          isSelected: _isGenderSelected[1],
                          onSelected: (bool value) {
                            _handleSelected(1, value, _isGenderSelected);
                            widget.selectedGender = 'Gelding';
                            widget.selectedGenders[widget.currentIndex!]=widget.selectedGender!;
                            widget.selectedHorses[widget.currentIndex!]='New horse : ${widget.newHorsesController.text}';
                            Print("Selected type ${widget.selectedGender}");
                          },
                        ),
                        SelectableTypeContainer(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 35, vertical: 10),
                          label: 'Stallion',
                          index: 2,
                          isSelected: _isGenderSelected[2],
                          onSelected: (bool value) {
                            _handleSelected(2, value, _isGenderSelected);
                            widget.selectedGender = 'Stallion';
                            widget.selectedGenders[widget.currentIndex!]=widget.selectedGender!;
                            widget.selectedHorses[widget.currentIndex!]='New horse : ${widget.newHorsesController.text}';
                            Print("Selected type ${widget.selectedGender}");
                          },
                        ),
                      ],
                    ),
                  ],
                )),
          ),
        ],
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
}
