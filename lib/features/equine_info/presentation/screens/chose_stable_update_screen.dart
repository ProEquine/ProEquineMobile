import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:proequine/core/constants/constants.dart';
import 'package:proequine/core/constants/thems/app_styles.dart';
import 'package:proequine/core/widgets/custom_error_widget.dart';
import 'package:proequine/core/widgets/loading_widget.dart';
import 'package:proequine/features/equine_info/domain/equine_info_cubit.dart';
import 'package:proequine/features/equine_info/presentation/screens/add_secondary_stable_screen.dart';
import 'package:proequine/features/equine_info/presentation/screens/update_main_stable_screen.dart';
import 'package:proequine/features/equine_info/presentation/screens/update_secondary_stable_screen.dart';

import 'package:sizer/sizer.dart';
import '../../../../core/widgets/custom_header.dart';
import '../../../../core/widgets/profile_two_lines_list_tile.dart';

class ChooseUpdateStableScreen extends StatefulWidget {
  const ChooseUpdateStableScreen({super.key});

  @override
  State<ChooseUpdateStableScreen> createState() =>
      _ChooseUpdateStableScreenState();
}

class _ChooseUpdateStableScreenState extends State<ChooseUpdateStableScreen> {
  EquineInfoCubit cubit = EquineInfoCubit();
  bool isThereAdd = true;

  @override
  Widget build(BuildContext context) {
    // final themeCubit = ThemeCubitProvider.of(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(20.h),
        child: CustomHeader(
          title: "Stables",
          isThereBackButton: true,
          isThereChangeWithNavigate: false,
          isThereThirdOption: isThereAdd,
          thirdOptionTitle: 'Add',
          onPressThirdOption: () {
            if (isThereAdd) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AddSecondaryStableScreen()));
            } else {}
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(kPadding),
          child: BlocConsumer<EquineInfoCubit, EquineInfoState>(
            bloc: cubit..getUserStables(),
            listener: (context, state) {
              // TODO: implement listener
            },
            builder: (context, state) {
              if (state is GetUserStablesLoading) {
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
              if (state is GetUserStablesSuccessful) {
                if (state.model!.stables!.isEmpty) {
                  isThereAdd = false;
                  return const Center(
                      child: Text(
                    "Waiting for confirm",
                    style: AppStyles.profileBlackTitles,
                  ));
                }
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 14),
                      child: Text(
                        "Main Stable",
                        style: AppStyles.profileTitles,
                        textAlign: TextAlign.start,
                      ),
                    ),
                    ProfileTwoLineListTile(
                      title: state.model!.stables![0].stableName,
                      subTitle:
                          '${state.model!.stables![0].stableCountry}, ${state.model!.stables![0].stableState}',
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UpdateMainStableScreen(
                                      mainStable:
                                          state.model!.stables![0].stableName!,
                                    )));
                      },
                      ableToEdit: true,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    state.model!.stables!.length > 1
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 14),
                                child: Text(
                                  "Secondary Stable",
                                  style: AppStyles.profileTitles,
                                  textAlign: TextAlign.start,
                                ),
                              ),
                              ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: state.model!.stables!.length - 1,
                                  itemBuilder: (context, index) {
                                    return ProfileTwoLineListTile(
                                      title: state.model!.stables![index + 1]
                                          .stableName,
                                      subTitle:
                                          '${state.model!.stables![index + 1].stableCountry}, ${state.model!.stables![index + 1].stableState}',
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    UpdateSecondaryStableScreen(
                                                      personStableId: state
                                                          .model!
                                                          .stables![index + 1]
                                                          .personStableId!,
                                                      secondaryStable: state
                                                          .model!
                                                          .stables![index + 1]
                                                          .stableName!,
                                                    )));
                                      },
                                      ableToEdit: true,
                                    );
                                  }),
                            ],
                          )
                        : const SizedBox(),
                  ],
                );
              } else if (state is GetUserStablesError) {
                return CustomErrorWidget(
                    errorMessage: state.message!,
                    onRetry: () {
                      cubit.getUserStables();
                    });
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }
}
