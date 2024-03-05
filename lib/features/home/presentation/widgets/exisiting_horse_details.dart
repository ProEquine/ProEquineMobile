import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proequine/features/home/domain/cubits/local_horse_cubit.dart';
import 'package:proequine/features/home/domain/repo/local_storage_repository.dart';
import '../../../../core/constants/colors/app_colors.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/constants/thems/app_styles.dart';
import '../../../../core/utils/Printer.dart';
import '../../../../core/utils/sharedpreferences/SharedPreferencesHelper.dart';
import '../../../../core/widgets/divider.dart';
import '../../../../core/widgets/rebi_button.dart';
import '../../data/local_trip.dart';

class ExistingHorseDetailsScreen extends StatefulWidget {
  final String horseId;
  final String tripId;
  final String title;
  final String name;
  final Horse horse;
  late final List<bool> ownerShip;
  late final List<bool> staying;

  ExistingHorseDetailsScreen({
    required this.horseId,
    required this.tripId,
    required this.name,
    required this.title,
    required this.ownerShip,
    required this.horse,
    required this.staying,
  });

  @override
  _ExistingHorseDetailsScreenState createState() =>
      _ExistingHorseDetailsScreenState();
}

class _ExistingHorseDetailsScreenState
    extends State<ExistingHorseDetailsScreen> {
  LocalHorseCubit localHorseCubit =LocalHorseCubit(localStorageRepository: LocalStorageRepository());

  String selectedOwner = '';
  String selectedStaying = '';

  @override
  void initState() {
    selectedStaying = widget.horse.staying;
    selectedOwner = widget.horse.ownership;

    super.initState();
  }
  LocalStorageRepository localStorageRepository=LocalStorageRepository();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LocalHorseCubit, LocalHorseState>(
      bloc: localHorseCubit,
  listener: (context, state) {
    // TODO: implement listener
  },
  builder: (context, state) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: SizedBox(
        child: Padding(
          padding: const EdgeInsets.only(
              top: kPadding, left: kPadding, right: kPadding),
          child: StatefulBuilder(builder: (context, setState) {
            return SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(
                        width: 20,
                      ),
                      Center(
                        child: Text(widget.title,
                            style: TextStyle(
                                fontSize: 17,
                                fontFamily: "notosan",
                                fontWeight: FontWeight.w600,
                                color: AppSharedPreferences.getTheme ==
                                        'ThemeCubitMode.dark'
                                    ? Colors.white
                                    : AppColors.blackLight)),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.close,
                          size: 18,
                          color: AppColors.yellow,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: kPadding,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Details",
                        style: AppStyles.summaryTitleStyle,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Name: ${widget.name}',
                        style: AppStyles.summaryDesStyle,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Padding(
                        padding: EdgeInsets.all(5.0),
                        child: CustomDivider(),
                      ),
                      Text(
                        "Ownership",
                        style: AppStyles.summaryTitleStyle,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedOwner = 'New Purchase';
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 45, vertical: 10),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: selectedOwner == 'New Purchase'
                                      ? AppColors.yellow
                                      : AppColors.borderColor,
                                ),
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(20.5),
                                    topRight: Radius.circular(20.5),
                                    bottomLeft: Radius.circular(20.5),
                                    bottomRight: Radius.circular(20.5)),
                                color: selectedOwner == 'New Purchase'
                                    ? AppColors.yellow
                                    : AppColors.backgroundColorLight,
                              ),
                              child: Text(
                                "New Purchase",
                                style: TextStyle(
                                  color: selectedOwner == 'New Purchase'
                                      ? AppColors.backgroundColorLight
                                      : AppColors.blackLight,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: "notosan",
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedOwner = 'Returning';
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 45, vertical: 10),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: selectedOwner == 'Returning'
                                      ? AppColors.yellow
                                      : AppColors.borderColor,
                                ),
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(20.5),
                                    topRight: Radius.circular(20.5),
                                    bottomLeft: Radius.circular(20.5),
                                    bottomRight: Radius.circular(20.5)),
                                color: selectedOwner == 'Returning'
                                    ? AppColors.yellow
                                    : AppColors.backgroundColorLight,
                              ),
                              child: Text(
                                "Returning",
                                style: TextStyle(
                                  color: selectedOwner == 'Returning'
                                      ? AppColors.backgroundColorLight
                                      : AppColors.blackLight,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: "notosan",
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Padding(
                        padding: EdgeInsets.all(5.0),
                        child: CustomDivider(),
                      ),
                      Text(
                        "Staying",
                        style: AppStyles.summaryTitleStyle,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedStaying = 'Permanent';
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 45, vertical: 10),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: selectedStaying == 'Permanent'
                                      ? AppColors.yellow
                                      : AppColors.borderColor,
                                ),
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(20.5),
                                    topRight: Radius.circular(20.5),
                                    bottomLeft: Radius.circular(20.5),
                                    bottomRight: Radius.circular(20.5)),
                                color: selectedStaying == 'Permanent'
                                    ? AppColors.yellow
                                    : AppColors.backgroundColorLight,
                              ),
                              child: Text(
                                "Permanent",
                                style: TextStyle(
                                  color: selectedStaying == 'Permanent'
                                      ? AppColors.backgroundColorLight
                                      : AppColors.blackLight,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: "notosan",
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedStaying = 'Temporary';
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 45, vertical: 10),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: selectedStaying == 'Temporary'
                                      ? AppColors.yellow
                                      : AppColors.borderColor,
                                ),
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(20.5),
                                    topRight: Radius.circular(20.5),
                                    bottomLeft: Radius.circular(20.5),
                                    bottomRight: Radius.circular(20.5)),
                                color: selectedStaying == 'Temporary'
                                    ? AppColors.yellow
                                    : AppColors.backgroundColorLight,
                              ),
                              child: Text(
                                "Temporary",
                                style: TextStyle(
                                  color: selectedStaying == 'Temporary'
                                      ? AppColors.backgroundColorLight
                                      : AppColors.blackLight,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: "notosan",
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      RebiButton(
                          onPressed: () async{

                     Print('widget.horseId${widget.horseId}');


                            if (selectedOwner.isNotEmpty &&
                                selectedStaying.isNotEmpty) {

                              await localStorageRepository.editSpecificHorse(
                                  widget.tripId,
                                  widget.horseId,
                                  Horse(
                                      horseId: widget.horse.horseId,
                                      horseName: widget.horse.horseName,
                                      color: 'color',
                                      yearOfBirth: 2000,
                                      gender: 'gender',
                                      bloodline: 'bloodline',
                                      breed: 'breed',
                                      discipline: 'discipline',
                                      ownership: selectedOwner,
                                      staying: selectedStaying));
                              if(context.mounted){
                                await localHorseCubit.getAllHorses(widget.tripId);
                                Navigator.pop(context,localHorseCubit.getAllHorses(widget.tripId));
                              }



                            }
                          },
                          child: Text("Save", style: AppStyles.buttonStyle,)),
                    ],
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  },
);
  }
}
