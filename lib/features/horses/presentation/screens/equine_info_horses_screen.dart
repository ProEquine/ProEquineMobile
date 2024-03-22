import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:proequine/core/constants/constants.dart';
import 'package:proequine/core/utils/rebi_message.dart';
import 'package:proequine/core/widgets/loading_widget.dart';
import 'package:proequine/features/horses/data/update_horse_request_model.dart';
import 'package:proequine/features/horses/domain/horse_cubit.dart';

import 'package:sizer/sizer.dart';

import '../../../../core/constants/colors/app_colors.dart';
import '../../../../core/constants/thems/app_styles.dart';
import '../../../../core/global_functions/global_statics_drop_down.dart';
import '../../../../core/utils/validator.dart';
import '../../../../core/widgets/custom_header.dart';
import '../../../../core/widgets/drop_down_menu_widget.dart';
import '../../../../core/widgets/rebi_button.dart';
import '../../../../core/widgets/user_stables_widget.dart';
import '../../../equine_info/presentation/widgets/disciplines_widget.dart';
import '../../data/get_user_horses_response_model.dart';

class EquineInfoHorsesScreen extends StatefulWidget {
  final Horse? horse;
  final int? stableId;
  final String? stableName;
  final String? horseCondition;
  final String? disciplineTitle;
  final int? disciplineId;
  final int? horseId;
  final int? userId;

  const EquineInfoHorsesScreen(
      {super.key,
      this.stableId,
      this.stableName,
      this.horseCondition,
      this.disciplineTitle,
      required this.horseId,
      this.disciplineId,
      this.horse, this.userId});

  @override
  State<EquineInfoHorsesScreen> createState() => _EquineInfoHorsesScreenState();
}

class _EquineInfoHorsesScreenState extends State<EquineInfoHorsesScreen> {
  late TextEditingController stable;
  late TextEditingController discipline;
  late TextEditingController disciplineId;

  TextEditingController stableName = TextEditingController();
  late TextEditingController stableId;
  TextEditingController stableLocation = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    selectedCondition = "Active";
    stable = TextEditingController(text: widget.stableName);
    discipline = TextEditingController(text: widget.disciplineTitle);
    stableId = TextEditingController(text: widget.stableId.toString());
    disciplineId = TextEditingController(text: widget.disciplineId.toString());
    selectedDiscipline = widget.disciplineTitle ?? '';
    super.initState();
  }

  String? selectedDiscipline;
  String? selectedStable;
  String? selectedCondition;

  String? selectedEmirate;
  bool isChooseToAddStable = false;
  HorseCubit cubit = HorseCubit();

  void changeToTrueValue() {
    setState(() {
      isChooseToAddStable = true;
    });
  }

  void changeToFalseValue() {
    setState(() {
      isChooseToAddStable = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    var myCubit = context.watch<HorseCubit>();
    // final themeCubit = ThemeCubitProvider.of(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(20.0.h),
        child: CustomHeader(
          title: "Equine Info",
          isThereBackButton: true,
        ),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(kPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Horse Stable ",
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: AppColors.formsHintFontLight,
                  fontSize: 14,
                  fontFamily: 'notosan',
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 7),
                child: UserStableWidget(
                  stableId: stableId,
                  stableName: stable,
                  userId: widget.userId!,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              // const Text(
              //   "Horse condition",
              //   textAlign: TextAlign.start,
              //   style: TextStyle(
              //     color: AppColors.formsHintFontLight,
              //     fontSize: 14,
              //     fontFamily: 'notosan',
              //     fontWeight: FontWeight.w500,
              //   ),
              // ),
              // Padding(
              //   padding: const EdgeInsets.symmetric(vertical: 7),
              //   child: DropDownWidget(
              //     items: conditions,
              //     selected: selectedCondition,
              //     onChanged: (condition) {
              //       setState(() {
              //         selectedCondition = condition;
              //       });
              //     },
              //     validator: (value) {
              //       return Validator.requiredValidator(selectedCondition);
              //     },
              //     hint: 'Condition',
              //   ),
              // ),
              // const SizedBox(
              //   height: 10,
              // ),
              const Text(
                "Horse Discipline ",
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: AppColors.formsHintFontLight,
                  fontSize: 14,
                  fontFamily: 'notosan',
                  fontWeight: FontWeight.w500,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 7),
                child: DisciplinesWidget(
                  discipline: discipline,
                  disciplineId: disciplineId,
                ),
              ),
              const Spacer(),
              Align(
                alignment: Alignment.bottomCenter,
                child: BlocConsumer<HorseCubit, HorseState>(
                  bloc: cubit,
                  listener: (context, state) {
                    if (state is UpdateHorseError) {
                      RebiMessage.error(msg: state.message!, context: context);
                    } else if (state is UpdateHorseSuccessfully) {
                      RebiMessage.success(
                          msg: "Equine Info updated Successfully", context: context);
                      myCubit.getAllHorses(limit: 1000);
                      Navigator.pop(context);
                      Navigator.pop(context);
                    }
                  },
                  builder: (context, state) {
                    if (state is UpdateHorseLoading) {
                      return const LoadingCircularWidget();
                    }
                    return RebiButton(
                      onPressed: () {
                        if ((stable.text.isNotEmpty &&
                                stable.text != 'Add Your Stable') ||
                            (selectedEmirate != null &&
                                    stableName.text.isNotEmpty &&
                                    stableLocation.text.isNotEmpty) &&
                                selectedCondition != null &&
                                discipline.text.isNotEmpty) {
                          _onPressUpdate();
                        } else {
                          RebiMessage.error(
                              msg: "Please fill all of the fields",
                              context: context);
                        }
                      },
                      child:  Text("Save", style: AppStyles.buttonStyle,),
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  _onPressUpdate() {
    cubit.updateHorse(
      UpdateHorseRequestModel(
        id: widget.horseId,
        name: widget.horse!.name,
        color: widget.horse!.color,
        dateOfBirth: widget.horse!.dateOfBirth,
        placeOfBirth: widget.horse!.placeOfBirth,
        breed: widget.horse!.breed,
        disciplineId: int.parse(disciplineId.text),
        stableId: int.parse(stableId.text),
        bloodLine: widget.horse!.bloodLine,
        image: widget.horse!.image,
        gender: widget.horse!.gender,
      ),
    );
  }
}
