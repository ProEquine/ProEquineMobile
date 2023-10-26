import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proequine/features/user/data/get_disiplines_response_model.dart';
import 'package:proequine/features/user/domain/user_cubit.dart';

import '../../../../core/constants/colors/app_colors.dart';
import '../../../../core/utils/Printer.dart';
import '../../../../core/utils/validator.dart';
import '../../../../core/widgets/divider.dart';
import '../../../../core/widgets/drop_down_menu_widget.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../../../core/widgets/rebi_input.dart';
import '../../../home/presentation/widgets/hospital_bottom_sheet.dart';
import '../../../user/data/get_stables_response_model.dart';

class DisciplinesWidget extends StatefulWidget {
  TextEditingController discipline = TextEditingController();
  TextEditingController disciplineId = TextEditingController();
   DisciplinesWidget({Key? key,required this.discipline,required this.disciplineId}) : super(key: key);

  @override
  State<DisciplinesWidget> createState() => _DisciplinesWidgetState();
}

class _DisciplinesWidgetState extends State<DisciplinesWidget> {
  AllDiscipline? selectedDiscipline;
  UserCubit cubit=UserCubit();
  @override
  Widget build(BuildContext context) {
    return RebiInput(
      hintText: "Discipline",
      controller: widget.discipline,
      keyboardType: TextInputType.name,
      onChanged: (value) {
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
          title: "Disciplines",
          content: BlocConsumer<UserCubit, UserState>(
            bloc: cubit..getDisciplines(),
            listener: (context, state) {
              // TODO: implement listener
            },
            builder: (context, state) {
              if(state is GetAllDisciplinesSuccessful){
                return SingleChildScrollView(
                  child: StatefulBuilder(builder: (context, setState) {
                    if (state.disciplines.isNotEmpty) {
                      return ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: state.disciplines.length,
                        separatorBuilder: (context, index) {
                          return const CustomDivider();
                        },
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedDiscipline = state.disciplines[index];
                                  Navigator.pop(context);
                                widget.discipline.text =
                                state.disciplines[index].disciplineTitle!;
                                widget.disciplineId.text =
                                    state.disciplines[index].disciplineId!.toString();


                                // Print("Selected stable ${stables[index]}");
                                Print("disipline Name ${selectedDiscipline!.disciplineTitle}");
                              });
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(state.disciplines[index].disciplineTitle!)
                              ],
                            ),
                          );
                        },
                      );
                    } else {
                      return const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 100,
                          ),
                          Center(
                            child: Text("No Disciplines"),
                          ),
                        ],
                      );
                    }
                  }),
                );
              }
              else if (state is GetStablesLoading){
                const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: LoadingCircularWidget(),
                    )
                  ],
                );
              }return const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: LoadingCircularWidget(),
                  )
                ],
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
        return Validator.requiredValidator(widget.discipline.text);
      },
    );
  }
}
