import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:proequine/core/utils/extensions.dart';
import 'package:proequine/core/widgets/loading_widget.dart';
import 'package:proequine/features/user/domain/user_cubit.dart';

import '../../../../core/constants/colors/app_colors.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/utils/Printer.dart';
import '../../../../core/utils/validator.dart';
import '../../../../core/widgets/divider.dart';
import '../../../../core/widgets/rebi_input.dart';
import '../../features/home/presentation/widgets/hospital_bottom_sheet.dart';
import '../../features/user/data/get_stables_response_model.dart';

class SelectStableWidget extends StatefulWidget {
  TextEditingController stableName = TextEditingController();
  TextEditingController stableId = TextEditingController();
  List<String> showingStablesList;
  VoidCallback? changeTrue;
  VoidCallback? changeFalse;

  SelectStableWidget({Key? key,
    required this.stableName,
    required this.stableId,
    required this.showingStablesList,
    this.changeFalse,
    this.changeTrue,})
      : super(key: key);

  @override
  State<SelectStableWidget> createState() => _SelectStableWidgetState();
}

class _SelectStableWidgetState extends State<SelectStableWidget> {
  Stable? selectedStable;

  UserCubit cubit = UserCubit();

  @override
  Widget build(BuildContext context) {
    return RebiInput(
      hintText: "Stable",
      controller: widget.stableName,
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
          title: "Stables",
          content: BlocConsumer<UserCubit, UserState>(
            bloc: cubit..getStables(),
            listener: (context, state) {
              // TODO: implement listener
            },
            builder: (context, state) {
              if(state is GetStablesSuccessful){
                return SingleChildScrollView(
                  child: StatefulBuilder(builder: (context, setState) {
                    if (state.getStablesResponseModel.isNotEmpty) {
                      return ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: state.getStablesResponseModel.length,
                        separatorBuilder: (context, index) {
                          return const CustomDivider();
                        },
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedStable = state.getStablesResponseModel[index];
                                if (state.getStablesResponseModel[index].stableName ==
                                    'Add Your Stable') {
                                  widget.changeTrue!.call();
                                  Navigator.pop(context);
                                } else {
                                  widget.changeFalse!.call();
                                  Navigator.pop(context);

                                  // Print(widget.changeFalse);
                                }

                                widget.stableName.text =
                                state.getStablesResponseModel[index].stableName!;
                                widget.stableId.text =
                                state.getStablesResponseModel[index].stableId!.toString();


                                Print("Selected stable ${stables[index]}");
                                Print("Stable Name $selectedStable");
                              });
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(state.getStablesResponseModel[index].stableName!)
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
                            child: Text("No Places"),
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
        return Validator.requiredValidator(widget.stableName.text);
      },
    );
  }
}
