import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'package:proequine/core/constants/constants.dart';
import 'package:proequine/core/constants/thems/app_styles.dart';

import 'package:proequine/features/horses/presentation/widgets/document_widget.dart';
import 'package:proequine/features/horses/presentation/widgets/horse_card_document_widget.dart';
import 'package:proequine/features/horses/presentation/widgets/show_document_bottomsheet.dart';
import 'package:proequine/main.dart';

import 'package:sizer/sizer.dart';
import '../../../../core/global_functions/global_statics_drop_down.dart';
import '../../../../core/utils/Printer.dart';
import '../../../../core/utils/validator.dart';
import '../../../../core/widgets/custom_header.dart';
import '../../../../core/widgets/drop_down_menu_widget.dart';
import '../widgets/upload_file_widget.dart';

class HorseDocumentScreen extends StatefulWidget {
  const HorseDocumentScreen({super.key});

  @override
  State<HorseDocumentScreen> createState() => _HorseDocumentScreenState();
}

class _HorseDocumentScreenState extends State<HorseDocumentScreen> {
  final TextEditingController? docNumber = TextEditingController();
  final TextEditingController? docTitle = TextEditingController();
  final TextEditingController? docNotes = TextEditingController();
  late DateTime dateTime;

  var now = DateTime.now();
  int? firstDay = 1;
  int? firstMonth = 1;
  int? firstYear = 1;
  int? lastDay = 30;
  int? lastMonth = 1;
  int? lastYear = 1;
  final GlobalKey<FormState> _yearKey = GlobalKey<FormState>();
  final GlobalKey<FormState> dropDownKey = GlobalKey<FormState>();
  DateTime _selectedDay = DateTime.utc(2023);
  final DateTime _focusedDay = DateTime.now();
  final TextEditingController expiryDate = TextEditingController();
  final TextEditingController regDate = TextEditingController();
  final TextEditingController year = TextEditingController();
  late int _selectedYear;
  late TextEditingController _yearController;
  String? pdfTitle = '';

  @override
  void initState() {
    initializeDateFormatting();
    _yearController = TextEditingController(text: _selectedDay.year.toString());
    _selectedYear = _selectedDay.year;

    super.initState();
  }

  String? selectedCategory;

  String? selectedType;

  @override
  Widget build(BuildContext context) {
    // final themeCubit = ThemeCubitProvider.of(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(20.h),
        child: CustomHeader(
          title: "Horse Document",
          isThereBackButton: true,
          isThereChangeWithNavigate: false,
          isThereThirdOption: true,
          thirdOptionTitle: 'Add',
          onPressThirdOption: () {
            showDocumentBottomSheet(
              context: context,
              focusDay: _focusedDay,
              selectedDay: _selectedDay,
              selectedYear: _selectedYear,
              yearController: _yearController,
              yearKey: _yearKey,
              expiryDate: expiryDate,
              registrationDate: regDate,
              docTitle: docTitle!,
              docNumber: docNumber!,
              onTap: () {
                Print(expiryDate.text);
                Print(docTitle!.text);
                Print(docNumber!.text);
                Print(docNotes!.text);
                Print(regDate.text);
                Print(selectedType);
                Print(selectedCategory);
                Print(selectedCategory);
                Print(pdfTitle);
              },
              buttonTitle: 'Add',
              docNotes: docNotes!,
              dropDownWidget: StatefulBuilder(builder: (context, setState) {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 7),
                      child: DropDownWidget(
                        items: docCategories,
                        selected: selectedCategory,
                        onChanged: (category) {
                          setState(() {
                            selectedCategory = category!;
                          });
                        },
                        validator: (value) {
                          return Validator.requiredValidator(selectedCategory);
                        },
                        hint: 'Doc Category',
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 7),
                      child: DropDownWidget(
                        items: docType,
                        selected: selectedType,
                        onChanged: (type) {
                          setState(() {
                            selectedType = type!;
                          });
                        },
                        validator: (value) {
                          return Validator.requiredValidator(selectedType);
                        },
                        hint: 'Doc Type',
                      ),
                    ),
                  ],
                );
              }),
              uploadWidget: StatefulBuilder(builder: (context, setState) {
                uploadFile(String title) async {
                  FilePickerResult? result =
                      await FilePicker.platform.pickFiles(
                    type: FileType.custom,
                    allowedExtensions: ['pdf', 'doc'],
                  );

                  if (result != null) {
                    File file = File(result.files.single.path!);
                    String fileName = file.path.split('/').last;
                    String filePath = file.path;
                    setState(() {
                      if (title == 'pdfTitle') {
                        pdfTitle = fileName;
                      }

                      Print('file name $fileName');
                      Print('file name $filePath');
                      Print('title $title');
                    });
                  } else {
                    // User canceled the picker
                  }
                }

                return UploadFileWidget(
                  onPressUpload: () {
                    setState(() {
                      uploadFile('pdfTitle');
                    });
                  },
                  title: pdfTitle != '' ? pdfTitle : 'No file uploaded',
                );
              }),
              title: "Add Document",
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: kPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: HorseCardDocumentWidget(
                  age: '14',
                  gender: 'Mare',
                  breed: "Selle",
                  placeOfBirth: "Français",
                  horseName: 'Stormy',
                  discipline: "Show jumping",
                  isVerified: true,
                  horseStable: "Malath",
                  horseStatus: "Lame",
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  "Documents",
                  style: AppStyles.profileTitles,
                  textAlign: TextAlign.start,
                ),
              ),
              const SizedBox(
                height: 14,
              ),
              DocumentWidget(
                  title: "Import Permit",
                  date: "16/8/2024",
                  onTapDelete: () {
                    // setState(() {
                    //   Slidable.of(context)!.close();
                    // });
                  },
                  onTapEdit: () {
                    showDocumentBottomSheet(
                      context: context,
                      focusDay: _focusedDay,
                      selectedDay: _selectedDay,
                      selectedYear: _selectedYear,
                      yearController: _yearController,
                      yearKey: _yearKey,
                      expiryDate: expiryDate,
                      registrationDate: regDate,
                      docTitle: docTitle!,
                      docNumber: docNumber!,
                      onTap: () {
                        Print(expiryDate.text);
                        Print(docTitle!.text);
                        Print(docNumber!.text);
                        Print(docNotes!.text);
                        Print(regDate.text);
                        Print(selectedType);
                        Print(selectedCategory);
                        Print(selectedCategory);
                        Print(pdfTitle);
                      },
                      buttonTitle: 'Save',
                      docNotes: docNotes!,
                      dropDownWidget:
                          StatefulBuilder(builder: (context, setState) {
                        return Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 7),
                              child: DropDownWidget(
                                items: docCategories,
                                selected: selectedCategory,
                                onChanged: (category) {
                                  setState(() {
                                    selectedCategory = category!;
                                  });
                                },
                                validator: (value) {
                                  return Validator.requiredValidator(
                                      selectedCategory);
                                },
                                hint: 'Doc Category',
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 7),
                              child: DropDownWidget(
                                items: docType,
                                selected: selectedType,
                                onChanged: (type) {
                                  setState(() {
                                    selectedType = type!;
                                  });
                                },
                                validator: (value) {
                                  return Validator.requiredValidator(
                                      selectedType);
                                },
                                hint: 'Doc Type',
                              ),
                            ),
                          ],
                        );
                      }),
                      uploadWidget:
                          StatefulBuilder(builder: (context, setState) {
                        uploadFile(String title) async {
                          FilePickerResult? result =
                              await FilePicker.platform.pickFiles(
                            type: FileType.custom,
                            allowedExtensions: ['pdf', 'doc'],
                          );

                          if (result != null) {
                            File file = File(result.files.single.path!);
                            String fileName = file.path.split('/').last;
                            String filePath = file.path;
                            setState(() {
                              if (title == 'pdfTitle') {
                                pdfTitle = fileName;
                              }

                              Print('file name $fileName');
                              Print('file name $filePath');
                              Print('title $title');
                            });
                          } else {
                            // User canceled the picker
                          }
                        }

                        return UploadFileWidget(
                          onPressUpload: () {
                            setState(() {
                              uploadFile('pdfTitle');
                            });
                          },
                          title: pdfTitle != '' ? pdfTitle : 'No file uploaded',
                        );
                      }),
                      title: "Edit Document",
                    );
                  }),
              const SizedBox(
                height: 14,
              ),
              DocumentWidget(
                  title: "Health Certificate",
                  date: "16/8/2024",
                  onTapDelete: () {},
                  onTapEdit: () {}),
              const SizedBox(
                height: 14,
              ),
              DocumentWidget(
                  title: "Quarantine Certificate",
                  date: "16/8/2024",
                  onTapDelete: () {},
                  onTapEdit: () {}),
              const SizedBox(
                height: 14,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
