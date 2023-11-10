import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:proequine/core/constants/constants.dart';
import 'package:proequine/core/constants/thems/app_styles.dart';
import 'package:proequine/core/widgets/custom_error_widget.dart';
import 'package:proequine/core/widgets/loading_widget.dart';
import 'package:proequine/features/equine_info/domain/equine_info_cubit.dart';
import 'package:proequine/features/equine_info/presentation/screens/add_secondary_discipline_screen.dart';
import 'package:proequine/features/equine_info/presentation/screens/update_discipline_screen.dart';
import 'package:proequine/features/equine_info/presentation/screens/update_secondary_discipline_screen.dart';

import 'package:sizer/sizer.dart';
import '../../../../core/utils/Printer.dart';
import '../../../../core/widgets/custom_header.dart';
import '../../../../core/widgets/profile_two_lines_list_tile.dart';

class ChooseDisciplineScreen extends StatefulWidget {
  const ChooseDisciplineScreen({super.key});

  @override
  State<ChooseDisciplineScreen> createState() => _ChooseDisciplineScreenState();
}

class _ChooseDisciplineScreenState extends State<ChooseDisciplineScreen> {
  EquineInfoCubit cubit = EquineInfoCubit();

  @override
  Widget build(BuildContext context) {
    // final themeCubit = ThemeCubitProvider.of(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(20.h),
        child: CustomHeader(
          title: "Discipline",
          isThereBackButton: true,
          isThereChangeWithNavigate: false,
          isThereThirdOption: true,
          thirdOptionTitle: 'Add',
          onPressThirdOption: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        const AddSecondaryDisciplineScreen()));
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(kPadding),
          child: BlocConsumer<EquineInfoCubit, EquineInfoState>(
            bloc: cubit..getUserDiscipline(),
            listener: (context, state) {
              // TODO: implement listener
            },
            builder: (context, state) {
              if (state is GetUserDisciplineLoading) {
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: LoadingCircularWidget(),
                    )
                  ],
                );
              }
              if (state is GetUserDisciplineSuccessful) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 14),
                      child: Text(
                        "Main Discipline",
                        style: AppStyles.profileTitles,
                        textAlign: TextAlign.start,
                      ),
                    ),
                    ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: 1,
                        itemBuilder: (context, index) {
                          int mainDisciplineIndex = state.model!.disciplines!
                              .indexWhere(
                                  (stable) => stable.disciplinePriority == "Main");
                          if (mainDisciplineIndex != -1) {
                            Print(
                                "Index of main priority discipline: $mainDisciplineIndex");
                          } else {
                            Print("No discipline with 'main' priority found.");
                          }
                          return ProfileTwoLineListTile(
                            title: state.model!.disciplines![mainDisciplineIndex].disciplineTitle,
                            subTitle:
                                "National id: ${state.model!.disciplines![mainDisciplineIndex].nationalId ?? "Not Applicable"} \nFei ID: ${state.model!.disciplines![mainDisciplineIndex].feid ?? "Not Applicable"} ",
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          UpdateMainDiscipline(
                                            userDiscipline: state
                                                .model!
                                                .disciplines![mainDisciplineIndex]
                                                .disciplineTitle!,
                                            userFeId: state
                                                .model!
                                                .disciplines![mainDisciplineIndex]
                                                .feid??'',
                                            userNationalId: state
                                                .model!
                                                .disciplines![mainDisciplineIndex]
                                                .nationalId??'',
                                          )));
                            },
                            ableToEdit: true,
                          );
                        }),
                    state.model!.disciplines!.length > 1
                        ? Transform.translate(
                      offset:  Offset(0.0, -2.h
                      ),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 14),
                                  child: Text(
                                    "Secondary Discipline",
                                    style: AppStyles.profileTitles,
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                                ListView.builder(
                                    physics: const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount:
                                        state.model!.disciplines!.length - 1,
                                    itemBuilder: (context, index) {
                                      List secondaryDisciplines = state.model!.disciplines!.where((discipline) => discipline.disciplinePriority == "Secondary").toList();

                                      return ProfileTwoLineListTile(
                                        title: secondaryDisciplines[index]
                                            .disciplineTitle,
                                        subTitle:
                                            "National id : ${secondaryDisciplines[index].nationalId ?? ''} \nFei ID : ${secondaryDisciplines[index].feid ?? ''}",
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => UpdateSecondaryDisciplineScreen(
                                                      secondaryUserFeId:
                                                      secondaryDisciplines[index].feid
                                                                  .toString() ??
                                                              '',
                                                      secondaryUserNationalId: secondaryDisciplines[
                                                                  index]
                                                              .nationalId
                                                              .toString() ??
                                                          '',
                                                      personDisciplineId:secondaryDisciplines[index]
                                                          .personDisciplineId!
                                                          .toString(),
                                                      secondaryDiscipline:secondaryDisciplines[index]
                                                          .disciplineTitle!)));
                                        },
                                        ableToEdit: true,
                                      );
                                    }),
                              ],
                            ),
                        )
                        : const SizedBox(),
                  ],
                );
              } else if (state is GetUserDisciplineError) {
                return CustomErrorWidget(
                    errorMessage: state.message!, onRetry: () {});
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }
}
