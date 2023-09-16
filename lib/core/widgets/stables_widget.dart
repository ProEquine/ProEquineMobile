import 'package:flutter/material.dart';
import 'package:proequine/core/utils/extensions.dart';

import '../../../../core/constants/colors/app_colors.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/utils/Printer.dart';
import '../../../../core/utils/validator.dart';
import '../../../../core/widgets/divider.dart';
import '../../../../core/widgets/rebi_input.dart';
import '../../features/home/presentation/widgets/hospital_bottom_sheet.dart';

class SelectStableWidget extends StatefulWidget {
  TextEditingController stable = TextEditingController();
  List<String> showingStablesList;
  VoidCallback? changeTrue;
  VoidCallback? changeFalse;

  SelectStableWidget(
      {Key? key,
        required this.stable,
        required this.showingStablesList,
        this.changeFalse,
        this.changeTrue,})
      : super(key: key);

  @override
  State<SelectStableWidget> createState() => _SelectStableWidgetState();
}

class _SelectStableWidgetState extends State<SelectStableWidget> {
  String? selectedStable;

  @override
  Widget build(BuildContext context) {
    return RebiInput(
      hintText: "Stable",
      controller: widget.stable,
      keyboardType: TextInputType.name,
      onChanged: (value){
        setState(() {

        });
      },
      textInputAction: TextInputAction.done,
      autoValidateMode: AutovalidateMode.onUserInteraction,
      isOptional: false,
      color: AppColors.formsLabel,
      onTap: () {
        showHospitalsAndPlacesBottomSheet(
          context: context,
          title: "Stables",
          content: SingleChildScrollView(
            child: StatefulBuilder(builder: (context, setState) {
              if (widget.showingStablesList.isNotEmpty) {
                return ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: widget.showingStablesList.length,
                  separatorBuilder: (context, index) {
                    return const CustomDivider();
                  },
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {

                        setState(() {
                          selectedStable = widget.showingStablesList[index];

                          widget.stable.text = widget.showingStablesList[index];
                          if(selectedStable=='Add Your Stable'){

                            Navigator.pop(context);
                            widget.changeTrue!;
                            Print(widget.changeTrue);
                          }else{
                            Navigator.pop(context);
                            widget.changeFalse!;
                            Print(widget.changeFalse);
                          }


                          Print("Selected stable ${stables[index]}");
                          Print("Stable Name $selectedStable");
                        });
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(widget.showingStablesList[index])
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
        return Validator.requiredValidator(widget.stable.text);
      },
    );
  }
}
