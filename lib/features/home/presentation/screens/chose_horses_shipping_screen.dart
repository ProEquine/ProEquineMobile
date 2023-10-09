import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proequine/core/utils/sharedpreferences/SharedPreferencesHelper.dart';
import 'package:proequine/core/widgets/divider.dart';
import 'package:proequine/core/widgets/rebi_button.dart';
import 'package:proequine/features/home/data/local_trip.dart';
import 'package:proequine/features/home/data/shipping_service_model.dart';
import 'package:proequine/features/home/domain/cubits/local_horse_cubit.dart';

import 'package:sizer/sizer.dart';
import 'package:uuid/uuid.dart';
import '../../../../core/constants/colors/app_colors.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/utils/Printer.dart';
import '../../../../core/utils/validator.dart';
import '../../../../core/widgets/custom_header.dart';
import '../../../../core/widgets/rebi_input.dart';
import '../../domain/repo/local_storage_repository.dart';
import '../widgets/horses_bottom_sheet.dart';
import 'confirm_horses_screen.dart';

class ChoseShippingHorseScreen extends StatefulWidget {
  final ShippingServiceModel? serviceModel;
  bool isItFromEditing = false;

  ChoseShippingHorseScreen(
      {Key? key, this.serviceModel, this.isItFromEditing = false})
      : super(key: key);

  @override
  State<ChoseShippingHorseScreen> createState() =>
      _ChoseShippingHorseScreenState();
}

class _ChoseShippingHorseScreenState extends State<ChoseShippingHorseScreen> {
  List<TextEditingController> newHorsesControllers = [];

  List<TextEditingController> horsesControllers = [];
  Map<String, String> horses = {};
  LocalHorseCubit localHorseCubit =
      LocalHorseCubit(localStorageRepository: LocalStorageRepository());
  LocalStorageRepository localStorageRepository = LocalStorageRepository();

  @override
  void initState() {
    super.initState();
    var controllersTexts = List<String>.generate(
        int.parse(widget.serviceModel!.horsesNumber),
        (counter) => "Select a horse");
    for (var str in controllersTexts) {
      var textEditingController = TextEditingController(text: str);
      horsesControllers.add(textEditingController);
    }

    var newHorsesText = List<String>.generate(
        int.parse(widget.serviceModel!.horsesNumber), (counter) => "");
    for (var str in newHorsesText) {
      var textEditingController = TextEditingController(text: str);
      newHorsesControllers.add(textEditingController);
    }
    AppSharedPreferences.firstTime = true;
    Print('AppSharedPreferences.getEnvType${AppSharedPreferences.getEnvType}');
    super.initState();

    horsesNumbers = int.parse(widget.serviceModel!.horsesNumber);
    Print(" Horses Numbers is $horsesNumbers");
  }

  @override
  void dispose() {
    super.dispose();
    // dispose textEditingControllers to prevent memory leaks
    for (TextEditingController textEditingController in horsesControllers) {
      textEditingController.dispose();
    }
    for (TextEditingController textEditingController in newHorsesControllers) {
      textEditingController.dispose();
    }
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  int? horsesNumbers;
  List<String> horsesNames = [
    'Koki',
    'Metha',
    'Saqr',
    'Al-Naama',
    'Al-Moshahar',
    'Add New Horse',
    'sad',
    'sadsda',
    'ssadsad',
    'dsa'
  ];

  @override
  Widget build(BuildContext context) {
    var uuid = const Uuid();
    var v1 = uuid.v1(options: {
      'node': [0x01, 0x23, 0x45, 0x67, 0x89, 0xab],
      'clockSeq': 0x1234,
      'mSecs': DateTime.now().millisecondsSinceEpoch,
      'nSecs': 5678
    });
    List<bool> isChoseNewHorse = List<bool>.generate(
        int.parse(widget.serviceModel!.horsesNumber), (counter) => false);
    List<String> selectedHorse = List<String>.generate(
        int.parse(widget.serviceModel!.horsesNumber), (counter) => "");
    List<String> selectedGender = List<String>.generate(
        int.parse(widget.serviceModel!.horsesNumber), (counter) => "");
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(20.0.h),
        child: CustomHeader(
          title: "Shipping",
          isThereBackButton: true,
        ),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SizedBox(
            height: horsesNumbers! > 2 ? 120.h : 85.0.h,
            child: SingleChildScrollView(
              child: widget.isItFromEditing
                  ? BlocConsumer<LocalHorseCubit, LocalHorseState>(
                      bloc: localHorseCubit
                        ..getTrip(widget.serviceModel!.tripId),
                      listener: (context, state) {
                        // TODO: implement listener
                      },
                      builder: (context, state) {
                        if (state is GetTripSuccessfully) {
                          return Column(
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              ListView.separated(
                                  shrinkWrap: true,
                                  physics: const BouncingScrollPhysics(),
                                  separatorBuilder: (context, index) {
                                    return const CustomDivider();
                                  },
                                  itemCount: state.trip.numberOfHorses,
                                  itemBuilder: (context, currentIndex) {
                                    if (state.trip.horses.isNotEmpty) {
                                      horsesControllers[currentIndex].text =
                                          state.trip.horses[currentIndex]
                                              .horseName;
                                    } else {}

                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: kPadding),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 7),
                                            child: RebiInput(
                                              hintText: 'Select Your Horse',
                                              controller: horsesControllers[
                                                  currentIndex],
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
                                                    physics:
                                                        NeverScrollableScrollPhysics(),
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
                                                          selectedHorse[
                                                                  currentIndex] =
                                                              horsesNames[
                                                                  index];
                                                          horsesControllers[
                                                                      currentIndex]
                                                                  .text =
                                                              selectedHorse[
                                                                  currentIndex];

                                                          Navigator.pop(
                                                              context);
                                                          Print(
                                                              "Selected horse ${selectedHorse[currentIndex]}");
                                                          Print(
                                                              "Horse Name ${horsesNames[index]}");

                                                          if (selectedHorse[
                                                                  currentIndex] ==
                                                              'Add New Horse') {
                                                            isChoseNewHorse[
                                                                    currentIndex] =
                                                                true;
                                                            Print("true");
                                                          } else {
                                                            isChoseNewHorse[
                                                                    currentIndex] =
                                                                false;
                                                            Print("false");
                                                            // selectedHorse[index] =
                                                            //     horsesControllers[currentIndex]
                                                            //         .text;
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
                                                        horsesControllers[
                                                                currentIndex]
                                                            .text);
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }),
                              const SizedBox(
                                height: 20,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: kPadding,
                                ),
                                child: RebiButton(
                                  backgroundColor: AppColors.yellow,
                                  onPressed: () async {
                                    for (int i = 0;
                                        i <
                                            int.parse(widget
                                                .serviceModel!.horsesNumber);
                                        i++) {
                                      if (state.trip.horses.isEmpty) {
                                        await localStorageRepository
                                            .addHorseToTrip(
                                                widget.serviceModel!.tripId,
                                                Horse(
                                                    horseId: v1 + i.toString(),
                                                    horseName: selectedHorse[i],
                                                    color: '',
                                                    yearOfBirth: 2000,
                                                    gender: '',
                                                    bloodline: '',
                                                    breed: '',
                                                    discipline: '',
                                                    ownership: '',
                                                    staying: ''));
                                      } else {
                                        await localStorageRepository
                                            .editSpecificHorse(
                                                widget.serviceModel!.tripId,
                                                state.trip.horses[i].horseId,
                                                Horse(
                                                    horseId: state
                                                        .trip.horses[i].horseId,
                                                    horseName:
                                                        selectedHorse[i].isEmpty
                                                            ? state
                                                                .trip
                                                                .horses[i]
                                                                .horseName
                                                            : selectedHorse[i],
                                                    color: state
                                                        .trip.horses[i].color,
                                                    yearOfBirth: state.trip
                                                        .horses[i].yearOfBirth,
                                                    gender: state
                                                        .trip.horses[i].gender,
                                                    bloodline: state.trip
                                                        .horses[i].bloodline,
                                                    breed: state
                                                        .trip.horses[i].breed,
                                                    discipline: state.trip
                                                        .horses[i].discipline,
                                                    ownership: state.trip
                                                        .horses[i].ownership,
                                                    staying: state.trip
                                                        .horses[i].staying));
                                      }
                                    }

                                    if (context.mounted) {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ConfirmHorsesScreen(
                                                    horsesNames: selectedHorse,
                                                    isNewHorses:
                                                        isChoseNewHorse,
                                                    serviceModel:
                                                        widget.serviceModel,
                                                  )));
                                    }

                                    // Print("Selected horses $selectedHorse");
                                    // Print("Selected isChosen $isChoseNewHorse");
                                    // final theMap =
                                    //     Map.fromIterables(selectedHorse, selectedGender);
                                    // Print(theMap);
                                  },
                                  child: const Text("Next"),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                            ],
                          );
                        }
                        return Container();
                      },
                    )
                  : Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        StatefulBuilder(builder: (context, setState) {
                          return ListView.separated(
                              shrinkWrap: true,
                              physics: const BouncingScrollPhysics(),
                              separatorBuilder: (context, index) {
                                return const CustomDivider();
                              },
                              itemCount: horsesNumbers!,
                              itemBuilder: (context, currentIndex) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: kPadding),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 7),
                                        child: RebiInput(
                                          hintText: 'Select Your Horse',
                                          controller:
                                              horsesControllers[currentIndex],
                                          keyboardType: TextInputType.name,
                                          textInputAction: TextInputAction.done,
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
                                                physics:
                                                    NeverScrollableScrollPhysics(),
                                                itemCount: horsesNames.length,
                                                separatorBuilder:
                                                    (context, index) {
                                                  return const CustomDivider();
                                                },
                                                itemBuilder: (context, index) {
                                                  return GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        selectedHorse[
                                                                currentIndex] =
                                                            horsesNames[index];
                                                        horsesControllers[
                                                                    currentIndex]
                                                                .text =
                                                            selectedHorse[
                                                                currentIndex];

                                                        Navigator.pop(context);
                                                        Print(
                                                            "Selected horse ${selectedHorse[currentIndex]}");
                                                        Print(
                                                            "Horse Name ${horsesNames[index]}");
                                                      });
                                                      if (selectedHorse[
                                                              currentIndex] ==
                                                          'Add New Horse') {
                                                        setState(() {
                                                          isChoseNewHorse[
                                                                  currentIndex] =
                                                              true;
                                                          Print("true");
                                                        });
                                                      } else {
                                                        setState(() {
                                                          isChoseNewHorse[
                                                                  currentIndex] =
                                                              false;
                                                          Print("false");
                                                          // selectedHorse[index] =
                                                          //     horsesControllers[currentIndex]
                                                          //         .text;
                                                        });
                                                      }
                                                    },
                                                    child: ListTile(
                                                      title: Text(
                                                          horsesNames[index]),
                                                    ),
                                                  );
                                                },
                                              ),
                                            );
                                          },
                                          readOnly: true,
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 20, vertical: 13),
                                          obscureText: false,
                                          validator: (value) {
                                            return Validator.requiredValidator(
                                                horsesControllers[currentIndex]
                                                    .text);
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              });
                        }),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: kPadding,
                          ),
                          child: RebiButton(
                            backgroundColor: AppColors.yellow,
                            onPressed: () async {
                              for (int i = 0;
                                  i <
                                      int.parse(
                                          widget.serviceModel!.horsesNumber);
                                  i++) {
                                await localStorageRepository.addHorseToTrip(
                                    widget.serviceModel!.tripId,
                                    Horse(
                                        horseId: v1 + i.toString(),
                                        horseName: selectedHorse[i],
                                        color: '',
                                        yearOfBirth: 2000,
                                        gender: '',
                                        bloodline: '',
                                        breed: '',
                                        discipline: '',
                                        ownership: '',
                                        staying: ''));
                                Print(i);
                              }

                              if (context.mounted) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ConfirmHorsesScreen(
                                              horsesNames: selectedHorse,
                                              isNewHorses: isChoseNewHorse,
                                              serviceModel: widget.serviceModel,
                                            )));
                              }
                            },
                            child: const Text("Next"),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
