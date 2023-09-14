import 'package:flutter/material.dart';
import 'package:proequine/core/constants/colors/app_colors.dart';
import 'package:proequine/core/constants/constants.dart';
import 'package:proequine/core/utils/extensions.dart';
import 'package:proequine/core/utils/rebi_message.dart';
import 'package:proequine/core/widgets/rebi_input.dart';
import 'package:proequine/features/home/data/media_service_model.dart';
import 'package:proequine/features/home/presentation/screens/media_summary_screen.dart';

import '../../../../core/global_functions/global_statics_drop_down.dart';
import '../../../../core/utils/Printer.dart';
import '../../../../core/utils/sharedpreferences/SharedPreferencesHelper.dart';
import '../../../../core/utils/validator.dart';
import '../../../../core/widgets/divider.dart';
import '../../../../core/widgets/drop_down_menu_widget.dart';
import '../../../../core/widgets/rebi_button.dart';
import '../../data/join_show_request_model.dart';
import '../widgets/horses_bottom_sheet.dart';
import 'chose_horses_shows_screen.dart';

class CreateMediaRequestScreen extends StatefulWidget {
  final String? type;
  final String? eventName;

  const CreateMediaRequestScreen({super.key, this.type, this.eventName});

  @override
  CreateMediaRequestScreenState createState() =>
      CreateMediaRequestScreenState();
}

class CreateMediaRequestScreenState extends State<CreateMediaRequestScreen>
    with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController note = TextEditingController();

  List<TextEditingController> horseControllers = [];
  List<TextEditingController> classesControllers = [];
  List<String> selectedHorse = ['', '', '', '', '', ''];
  List<String> selectedClass = ['', '', '', '', '', ''];

  @override
  void initState() {
    super.initState();
    // Initialize text controllers for the initial number of horses
    for (int i = 0; i < 6; i++) {
      horseControllers.add(TextEditingController());
    }
    for (int i = 0; i < 6; i++) {
      classesControllers.add(TextEditingController());
    }
  }

  @override
  void dispose() {
    // Dispose of text controllers when the widget is disposed
    for (var controller in horseControllers) {
      controller.dispose();
    }
    for (var controller in classesControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  String? selectedNumber;
  List<String> horsesNames = [
    'Koki',
    'Metha',
    'Saqr',
    'Al-Naama',
    'Al-Moshahar',
    // 'Add New Horse'
  ];
  List<String> classes = [
    'A',
    'B',
    'C',
    'D',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("Media Services",
            style: TextStyle(
                fontSize: 17,
                fontFamily: "notosan",
                fontWeight: FontWeight.w600,
                color: AppSharedPreferences.getTheme == 'ThemeCubitMode.dark'
                    ? Colors.white
                    : AppColors.blackLight)),
        centerTitle: true,
        backgroundColor: AppSharedPreferences.getTheme == 'ThemeCubitMode.dark'
            ? Colors.transparent
            : AppColors.backgroundColorLight,
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: kPadding),
          child: Align(
              alignment: Alignment.centerLeft,
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.arrow_back_ios_new,
                  color: AppSharedPreferences.getTheme == 'ThemeCubitMode.dark'
                      ? Colors.white
                      : AppColors.backgroundColor,
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
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: kPadding, vertical: 6),
                          child: DropDownWidget(
                            items: mediaNumberOfHorses,
                            selected: selectedNumber,
                            onChanged: (numberSelected) {
                              setState(() {
                                selectedNumber = numberSelected;
                                Print('selectedNumber$selectedNumber');
                                while (horseControllers.length >
                                    int.parse(numberSelected!)) {
                                  horseControllers.removeLast();
                                  classesControllers.removeLast();
                                }
                                while (horseControllers.length <
                                    int.parse(numberSelected)) {
                                  horseControllers.add(TextEditingController());
                                  classesControllers
                                      .add(TextEditingController());
                                }
                              });
                            },
                            validator: (value) {
                              // return Validator.requiredValidator(selectedNumber);
                            },
                            hint: 'Number of horses',
                          ),
                        ),
                        if (selectedNumber != null)
                          for (int i = 0; i < int.parse(selectedNumber!); i++)
                            Visibility(
                              visible: selectedNumber != null ? true : false,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: kPadding),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          flex: 2,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 7, right: 4, left: 4),
                                            child: RebiInput(
                                              hintText: 'Select Your Horse',
                                              controller: horseControllers[i],
                                              keyboardType: TextInputType.name,
                                              textInputAction:
                                              TextInputAction.done,
                                              autoValidateMode: AutovalidateMode
                                                  .onUserInteraction,
                                              isOptional: false,
                                              color: AppColors.formsLabel,
                                              onTap: () {
                                                showHorsesBottomSheet(
                                                  context: context,
                                                  title: "Select Your horse",
                                                  content: ListView.separated(
                                                    shrinkWrap: true,
                                                    itemCount:
                                                    horsesNames.length,
                                                    separatorBuilder:
                                                        (context, index) {
                                                      return const CustomDivider();
                                                    },
                                                    itemBuilder:
                                                        (context, index) {
                                                      return GestureDetector(
                                                        onTap: () {
                                                          setState(() {
                                                            selectedHorse[i] =
                                                            horsesNames[
                                                            index];
                                                            horseControllers[i]
                                                                .text =
                                                            selectedHorse[
                                                            i];

                                                            Navigator.pop(
                                                                context);
                                                            Print(
                                                                "Selected horse ${selectedHorse[i]}");
                                                            Print(
                                                                "Horse Name ${horsesNames[index]}");
                                                          });
                                                          if (selectedHorse[
                                                          i] ==
                                                              'Add New Horse') {
                                                            setState(() {
                                                              Print("true");
                                                            });
                                                          } else {
                                                            setState(() {
                                                              Print("false");
                                                              // selectedHorse[index] =
                                                              //     horsesControllers[currentIndex]
                                                              //         .text;
                                                            });
                                                          }
                                                        },
                                                        child: ListTile(
                                                          title: Text(
                                                              horsesNames[
                                                              index]),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                );
                                              },
                                              readOnly: true,
                                              contentPadding:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 20,
                                                  vertical: 13),
                                              obscureText: false,
                                              validator: (value) {
                                                return Validator
                                                    .requiredValidator(
                                                    horseControllers[i]
                                                        .text);
                                              },
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 7, right: 4, left: 4),
                                            child: RebiInput(
                                              hintText: 'Class 1 , Class 2',
                                              controller: classesControllers[i],
                                              keyboardType: TextInputType.name,
                                              textInputAction:
                                              TextInputAction.done,
                                              autoValidateMode: AutovalidateMode
                                                  .onUserInteraction,
                                              isOptional: false,
                                              color: AppColors.formsLabel,
                                              readOnly: false,
                                              contentPadding:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 20,
                                                  vertical: 13),
                                              obscureText: false,
                                              validator: (value) {
                                                return Validator
                                                    .requiredValidator(
                                                    classesControllers[i]
                                                        .text);
                                              },
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 7, horizontal: kPadding),
                      child: RebiInput(
                        hintText: 'Notes'.tra,
                        controller: note,
                        keyboardType: TextInputType.multiline,
                        maxLines: 5,
                        textInputAction: TextInputAction.done,
                        autoValidateMode: AutovalidateMode.onUserInteraction,
                        isOptional: true,
                        readOnly: false,
                        contentPadding:
                        const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 13),
                        obscureText: false,
                        validator: (value) {
                          // return Validator.requiredValidator(note.text);
                        },
                      ),
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: kPadding),
                      child: RebiButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate() &&
                                selectedNumber != null) {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) =>
                                      MediaSummaryScreen(
                                        mediaServiceModel: MediaServiceModel(
                                          horsesNumber: selectedNumber!,
                                          eventName: widget.eventName!,
                                          serviceType: widget.type!,
                                          notes: note.text,
                                        ),
                                      )));
                            } else {
                              RebiMessage.error(
                                  msg: "please fill all fields correctly",
                                  context: context);
                            }
                          },
                          child: const Text("Next")),
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
    );
  }
}
