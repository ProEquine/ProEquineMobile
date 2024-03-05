import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:proequine/core/constants/colors/app_colors.dart';

import 'package:proequine/core/constants/constants.dart';
import 'package:proequine/core/constants/thems/app_styles.dart';
import 'package:proequine/core/utils/rebi_message.dart';
import 'package:proequine/core/widgets/custom_error_widget.dart';
import 'package:proequine/core/widgets/loading_widget.dart';
import 'package:proequine/core/widgets/rebi_button.dart';
import 'package:proequine/features/horses/data/add_horse_document_request_model.dart';
import 'package:proequine/features/horses/data/edit_document_request_model.dart';
import 'package:proequine/features/horses/data/get_user_horses_response_model.dart';
import 'package:proequine/features/horses/domain/horse_cubit.dart';
import 'package:proequine/features/horses/presentation/screens/show_pdf_screen.dart';
import 'package:proequine/features/horses/presentation/widgets/document_widget.dart';
import 'package:proequine/features/horses/presentation/widgets/documents_loading_widget.dart';
import 'package:proequine/features/horses/presentation/widgets/horse_card_document_widget.dart';
import 'package:proequine/features/horses/presentation/widgets/show_document_bottomsheet.dart';

import 'package:sizer/sizer.dart';
import '../../../../core/global_functions/global_statics_drop_down.dart';
import '../../../../core/utils/Printer.dart';
import '../../../../core/utils/validator.dart';
import '../../../../core/widgets/custom_header.dart';
import '../../../../core/widgets/drop_down_menu_widget.dart';
import '../widgets/upload_file_widget.dart';
import 'edit_horse_screen.dart';

class HorseDocumentScreen extends StatefulWidget {
  final String horseId;
  final Horse horseList;

  const HorseDocumentScreen(
      {super.key, required this.horseId, required this.horseList});

  @override
  State<HorseDocumentScreen> createState() => _HorseDocumentScreenState();
}

class _HorseDocumentScreenState extends State<HorseDocumentScreen> {
  final TextEditingController? docNumber = TextEditingController();
  final TextEditingController? docTitle = TextEditingController();
  final TextEditingController? docNotes = TextEditingController();
  late DateTime dateTime;
  int? docId;

  var now = DateTime.now();
  int? firstDay = 1;
  int? firstMonth = 1;
  int? firstYear = 1;
  int? lastDay = 30;
  int? lastMonth = 1;
  int? lastYear = 1;
  final GlobalKey<FormState> _yearKey = GlobalKey<FormState>();
  final GlobalKey<FormState> dropDownKey = GlobalKey<FormState>();
  DateTime selectedRegisterDay = DateTime.utc(2023);
  DateTime selectedExpiryDay = DateTime.utc(2023);
  final DateTime _focusedDay = DateTime.now();
  final TextEditingController expiryDate = TextEditingController();
  final TextEditingController regDate = TextEditingController();
  final TextEditingController expiryDateInIso = TextEditingController();
  final TextEditingController registerDateInIso = TextEditingController();
  final TextEditingController year = TextEditingController();
  late int _selectedYear;
  late TextEditingController _yearController;
  String? pdfTitle = '';
  HorseCubit cubit = HorseCubit();
  String? filePath;
  String? editFilePath;
  String? fileName;

  @override
  void initState() {
    initializeDateFormatting();
    _yearController =
        TextEditingController(text: selectedRegisterDay.year.toString());
    _selectedYear = selectedRegisterDay.year;
    context
        .read<HorseCubit>()
        .getAllHorseDocuments(horseId: int.parse(widget.horseId), limit: 1000);

    super.initState();
  }

  String? selectedCategory;
  String? pdfLink;
  bool pdfSaved = false;
  bool editPdfSaved = true;
  String? ediPdfLink;

  String? selectedType;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    // final themeCubit = ThemeCubitProvider.of(context);
    var myCubit = context.watch<HorseCubit>();
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
            expiryDate.text = '';
            docTitle?.text = '';
            docNotes?.text = '';
            docNumber?.text = '';
            docNotes?.text = '';
            regDate.text = '';
            selectedCategory = null;
            selectedType = null;
            pdfTitle = '';
            filePath = null;
            showDocumentBottomSheet(
              isItEditing: false,
              context: context,
              focusDay: _focusedDay,
              registrationDateInIso: registerDateInIso,
              expiryDateInIso: expiryDateInIso,
              selectedRegisterDay: selectedRegisterDay,
              selectedExpiredDay: selectedExpiryDay,
              selectedYear: _selectedYear,
              yearController: _yearController,
              yearKey: _yearKey,
              expiryDate: expiryDate,
              registrationDate: regDate,
              docTitle: docTitle!,
              docNumber: docNumber!,
              onTap: () {},
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
              button: BlocConsumer<HorseCubit, HorseState>(
                bloc: cubit,
                listener: (context, state) {
                  if (state is AddHorseDocumentError) {
                    RebiMessage.error(msg: state.message!, context: context);
                  } else if (state is AddHorseDocumentSuccessfully) {
                    RebiMessage.success(msg: state.message, context: context);
                    Navigator.pop(context);
                    myCubit.getAllHorseDocuments(
                        horseId: int.parse(widget.horseId), limit: 1000);
                  }
                },
                builder: (context, state) {
                  if (state is AddHorseDocumentLoading) {
                    return const LoadingCircularWidget();
                  }
                  return RebiButton(
                      onPressed: () {
                        selectedRegisterDay =
                            DateTime.parse(registerDateInIso.text);
                        selectedExpiryDay =
                            DateTime.parse(expiryDateInIso.text);
                        Print("register day ${registerDateInIso.text}");
                        Print("expiry day ${expiryDateInIso.text}");
                        if (selectedExpiryDay.isBefore(selectedRegisterDay)) {
                          RebiMessage.error(
                              msg: "Enter Correct Expiry Date",
                              context: context);
                        } else {
                          cubit.addHorseDocument(
                            CreateHorseDocumentsRequestModel(
                              docCategory: selectedCategory,
                              docExpiryDate: expiryDateInIso.text,
                              docNotes: docNotes!.text,
                              docNumber: docNumber!.text,
                              docRegistrationData: registerDateInIso.text,
                              docTitle: docTitle!.text,
                              docType: selectedType,
                              horseId: int.parse(widget.horseId),
                            ),
                          );
                        }
                      },
                      child: Text(
                        "Add",
                        style: AppStyles.buttonStyle,
                      ));
                },
              ),
              uploadWidget: StatefulBuilder(builder: (context, setState) {
                uploadFile(String title) async {
                  FilePickerResult? result =
                      await FilePicker.platform.pickFiles(
                    type: FileType.custom,
                    allowedExtensions: ['pdf', 'doc'],
                  );

                  if (result != null) {
                    File file = File(result.files.single.path!);
                    fileName = file.path.split('/').last;
                    filePath = file.path;
                    setState(() {
                      if (title == 'pdfTitle') {
                        pdfTitle = fileName;
                      }
                    });
                  } else {
                    // User canceled the picker
                  }
                }

                return BlocConsumer<HorseCubit, HorseState>(
                  bloc: cubit,
                  listener: (context, state) {
                    if (state is UploadFileSuccessful) {
                      isLoading = false;
                      pdfLink = state.fileUrl!.url!;
                      pdfSaved = true;
                    } else if (state is UploadFileError) {
                      RebiMessage.error(msg: state.message!, context: context);
                    } else if (state is UploadFileLoading) {
                      isLoading = true;
                    }
                  },
                  builder: (context, state) {
                    return UploadFileWidget(
                      isLoading: isLoading,
                      buttonTitle: pdfSaved
                          ? 'Change'
                          : pdfTitle == ''
                              ? 'Upload'
                              : 'Save',
                      onPressUpload: () {
                        if (pdfTitle != '' && pdfSaved == false) {
                          _onPressUploadFile();
                        } else {
                          setState(() {
                            uploadFile('pdfTitle');
                          });
                        }
                      },
                      onPressChange: () {
                        setState(() {
                          pdfSaved = false;
                          uploadFile('pdfTitle');
                        });
                      },
                      title: pdfTitle != '' ? pdfTitle : 'No file uploaded',
                    );
                  },
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
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditHorseScreen(
                        selectedColor: widget.horseList.color,
                        disciplineId: widget.horseList.disciplineId,
                        stableId: widget.horseList.stableId,
                        selectedGender: widget.horseList.gender,
                        selectedBreed: widget.horseList.breed,
                        selectedBloodLine: widget.horseList.bloodLine,
                        //Todo: handling age depending on birth of date
                        selectedYear: 1,
                        horseId: widget.horseList.id,
                        birthOfDate: widget.horseList.dateOfBirth,
                        horseName: widget.horseList.name,
                        placeOfBirth: widget.horseList.placeOfBirth,
                        image: widget.horseList.image ?? '',
                      ),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: HorseCardDocumentWidget(
                    age: widget.horseList.age.toString(),
                    gender: widget.horseList.gender ?? "Mare",
                    breed: widget.horseList.breed!,
                    placeOfBirth: widget.horseList.placeOfBirth!,
                    horseName: widget.horseList.name!,
                    discipline: widget.horseList.discipline!.title!,
                    isVerified: false,
                    horseStable: widget.horseList.stable!.name!,
                    horseStatus: widget.horseList.status!,
                  ),
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
              BlocBuilder<HorseCubit, HorseState>(
                builder: (context, state) {
                  if (state is GetHorsesDocumentsSuccessfully) {
                    if (state.count == 0) {
                      return const Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Center(
                            child: Text(
                              'Your horse has no documents',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xFF8B9299),
                                fontSize: 20,
                                fontFamily: 'notosan',
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ),
                        ],
                      );
                    } else {
                      return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: state.count,
                          itemBuilder: (context, index) {
                            if (state.documents.isEmpty) {
                              return const Text("Empty !, Add Some Documents");
                            } else {
                              DateTime date = DateFormat('yyyy-MM-dd')
                                  .parse(state.documents[index].docExpiryDate!);
                              String formattedDate =
                                  DateFormat('dd/MM/yyyy').format(date);
                              DateTime regisDate = DateFormat('yyyy-MM-dd')
                                  .parse(state
                                      .documents[index].docRegistrationData!);
                              String formattedRegDate =
                                  DateFormat('dd/MM/yyyy').format(regisDate);

                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 7.0),
                                child: GestureDetector(
                                  onTap: () async {
                                    await FileProcess.createPdf(
                                        state.documents[index].docAttachment!,
                                        state.documents[index].docTitle!);
                                    await FileProcess.downloadAndSavePdf(
                                        state.documents[index].docAttachment!);
                                  },
                                  child: DocumentWidget(
                                      title: state.documents[index].docTitle,
                                      date: formattedDate,
                                      onTapDelete: () {
                                        // setState(() {
                                        //   Slidable.of(context)!.close();
                                        // });
                                      },
                                      onTapEdit: () {
                                        pdfLink = state
                                            .documents[index].docAttachment!;
                                        docTitle?.text =
                                            state.documents[index].docTitle!;
                                        docNumber?.text =
                                            state.documents[index].docNumber!;
                                        selectedCategory=state.documents[index].docCategory!;
                                        registerDateInIso.text = state
                                            .documents[index]
                                            .docRegistrationData!;
                                        expiryDateInIso.text = state
                                            .documents[index].docExpiryDate!;
                                        selectedType =
                                            state.documents[index].docType!;
                                        docNotes!.text =
                                            state.documents[index].docNotes!;
                                        pdfTitle =
                                            state.documents[index].docTitle!;
                                        editFilePath = state
                                            .documents[index].docAttachment!;

                                        docId = state.documents[index].id;
                                        showDocumentBottomSheet(
                                          context: context,
                                          isItEditing: true,
                                          focusDay: _focusedDay,
                                          registrationDateInIso:
                                              registerDateInIso,
                                          expiryDateInIso: expiryDateInIso,
                                          selectedRegisterDay:
                                              selectedRegisterDay,
                                          selectedExpiredDay: selectedExpiryDay,
                                          selectedYear: _selectedYear,
                                          yearController: _yearController,
                                          yearKey: _yearKey,
                                          expiryDate: expiryDate,
                                          registrationDate: regDate,
                                          docTitle: docTitle!,
                                          docNumber: docNumber!,
                                          onTap: () {},
                                          buttonTitle: 'Save',
                                          docNotes: docNotes!,
                                          button: BlocConsumer<HorseCubit,
                                              HorseState>(
                                            bloc: cubit,
                                            listener: (context, state) {
                                              if (state
                                                  is EditHorseDocumentError) {
                                                RebiMessage.error(
                                                    msg: state.message!,
                                                    context: context);
                                              } else if (state
                                                  is EditHorseDocumentSuccessfully) {
                                                RebiMessage.success(
                                                    msg: state.message,
                                                    context: context);
                                                Navigator.pop(context);
                                                myCubit.getAllHorseDocuments(
                                                    horseId: int.parse(
                                                        widget.horseId),
                                                    limit: 1000);
                                              }
                                            },
                                            builder: (context, state) {
                                              if (state
                                                  is EditHorseDocumentLoading) {
                                                return const LoadingCircularWidget();
                                              }
                                              return RebiButton(
                                                  onPressed: () {
                                                    selectedRegisterDay =
                                                        DateTime.parse(
                                                            registerDateInIso
                                                                .text);
                                                    selectedExpiryDay =
                                                        DateTime.parse(
                                                            expiryDateInIso
                                                                .text);
                                                    if (selectedExpiryDay.isBefore(
                                                        selectedRegisterDay)) {
                                                      RebiMessage.error(
                                                          msg:
                                                              "Enter Correct Expiry Date",
                                                          context: context);
                                                    } else {
                                                      cubit.editHorseDocument(
                                                        EditHorseDocumentsRequestModel(
                                                            docCategory:
                                                                selectedCategory,
                                                            docExpiryDate:
                                                                expiryDateInIso
                                                                    .text,
                                                            docNotes:
                                                                docNotes!.text,
                                                            docNumber:
                                                                docNumber!.text,
                                                            docRegistrationData:
                                                                registerDateInIso
                                                                    .text,
                                                            docTitle:
                                                                docTitle!.text,
                                                            docType:
                                                                selectedType,
                                                            horseId: int.parse(
                                                                widget.horseId),
                                                            docAttachment:
                                                                pdfLink,
                                                            id: docId),
                                                      );
                                                    }
                                                  },
                                                  child: Text(
                                                    "Save",
                                                    style:
                                                        AppStyles.buttonStyle,
                                                  ));
                                            },
                                          ),
                                          dropDownWidget: StatefulBuilder(
                                              builder: (context, setState) {
                                            return Column(
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(vertical: 7),
                                                  child: DropDownWidget(
                                                    items: docCategories,
                                                    selected: selectedCategory,
                                                    onChanged: (category) {
                                                      setState(() {
                                                        selectedCategory =
                                                            category!;
                                                      });
                                                    },
                                                    validator: (value) {
                                                      return Validator
                                                          .requiredValidator(
                                                              selectedCategory);
                                                    },
                                                    hint: 'Doc Category',
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(vertical: 7),
                                                  child: DropDownWidget(
                                                    items: docType,
                                                    selected: selectedType,
                                                    onChanged: (type) {
                                                      setState(() {
                                                        selectedType = type!;
                                                      });
                                                    },
                                                    validator: (value) {
                                                      return Validator
                                                          .requiredValidator(
                                                              selectedType);
                                                    },
                                                    hint: 'Doc Type',
                                                  ),
                                                ),
                                              ],
                                            );
                                          }),
                                          removeWidget: BlocConsumer<HorseCubit,
                                              HorseState>(
                                            bloc: cubit,
                                            listener: (context, state) {
                                              if (state
                                                  is RemoveHorseDocumentError) {
                                                RebiMessage.error(
                                                    msg: state.message!,
                                                    context: context);
                                              } else if (state
                                                  is RemoveHorseDocumentSuccessfully) {
                                                RebiMessage.success(
                                                    msg: state.message,
                                                    context: context);
                                                Navigator.pop(context);
                                                myCubit.getAllHorseDocuments(
                                                    horseId: int.parse(
                                                        widget.horseId),
                                                    limit: 1000);
                                              }
                                            },
                                            builder: (context, state) {
                                              if (state
                                                  is RemoveHorseDocumentLoading) {
                                                return const LoadingCircularWidget(
                                                    isDeleteButton: true);
                                              }
                                              return GestureDetector(
                                                  onTap: () {
                                                    cubit.removeHorseDocument(
                                                        docId!);
                                                  },
                                                  child: const Text(
                                                    "Remove",
                                                    style: TextStyle(
                                                        color: AppColors.red),
                                                  ));
                                            },
                                          ),
                                          uploadWidget: StatefulBuilder(
                                              builder: (context, setState) {
                                            uploadFile(String title) async {
                                              FilePickerResult? result =
                                                  await FilePicker.platform
                                                      .pickFiles(
                                                type: FileType.custom,
                                                allowedExtensions: [
                                                  'pdf',
                                                  'doc'
                                                ],
                                              );

                                              if (result != null) {
                                                File file = File(
                                                    result.files.single.path!);
                                                String fileName =
                                                    file.path.split('/').last;
                                                filePath = file.path;
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

                                            return BlocConsumer<HorseCubit,
                                                HorseState>(
                                              bloc: cubit,
                                              listener: (context, state) {
                                                if (state
                                                    is UploadFileSuccessful) {
                                                  isLoading = false;
                                                  pdfLink = state.fileUrl!.url!;
                                                  editPdfSaved = true;
                                                } else if (state
                                                    is UploadFileError) {
                                                  RebiMessage.error(
                                                      msg: state.message!,
                                                      context: context);
                                                } else if (state
                                                    is UploadFileLoading) {
                                                  isLoading = true;
                                                }
                                              },
                                              builder: (context, state) {
                                                return UploadFileWidget(
                                                  isLoading: isLoading,
                                                  buttonTitle: editPdfSaved
                                                      ? 'Change'
                                                      : pdfTitle == ''
                                                          ? 'Upload'
                                                          : 'Save',
                                                  onPressUpload: () {
                                                    if (pdfTitle != '' &&
                                                        editPdfSaved == false) {
                                                      _onPressUploadFile();
                                                    } else {
                                                      setState(() {
                                                        uploadFile('pdfTitle');
                                                      });
                                                    }
                                                  },
                                                  onPressChange: () {
                                                    setState(() {
                                                      editPdfSaved = false;
                                                      uploadFile('pdfTitle');
                                                    });
                                                  },
                                                  title: pdfTitle != ''
                                                      ? pdfTitle
                                                      : 'No file uploaded',
                                                );
                                              },
                                            );
                                          }),
                                          title: "Edit Document",
                                        );
                                      }),
                                ),
                              );
                            }
                          });
                    }
                  } else if (state is GetHorsesDocumentsLoading) {
                    return const DocumentsLoadingWidget();
                  } else if (state is GetHorsesDocumentsError) {
                    return CustomErrorWidget(onRetry: () {
                      cubit.getAllHorseDocuments(
                          horseId: int.parse(widget.horseId), limit: 1000);
                    });
                  }
                  return Container(
                    color: Colors.red,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  _onPressUploadFile() {
    cubit.uploadFile(filePath!);
  }
}
