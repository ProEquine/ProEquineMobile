import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proequine/core/utils/Printer.dart';
import 'package:proequine/core/utils/extensions.dart';
import 'package:proequine/core/utils/rebi_message.dart';
import 'package:proequine/core/widgets/custom_error_widget.dart';
import 'package:proequine/core/widgets/global_bottom_sheet.dart';
import 'package:proequine/core/widgets/loading_widget.dart';
import 'package:proequine/core/widgets/rebi_button.dart';
import 'package:proequine/features/associations/data/associate_horse_request_model.dart';
import 'package:proequine/features/associations/domain/associations_cubit.dart';
import 'package:proequine/features/associations/presentation/widgets/requests_association_widget.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/constants/colors/app_colors.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/constants/thems/app_styles.dart';
import '../../../../core/utils/validator.dart';
import '../../../../core/widgets/custom_header.dart';
import '../../../../core/widgets/divider.dart';
import '../../../../core/widgets/drop_down_menu_widget.dart';
import '../../../../core/widgets/rebi_input.dart';
import '../../../horses/data/get_user_horses_response_model.dart';
import '../widgets/associate_horse_details_widget.dart';

class HorseInvitesAssociations extends StatefulWidget {
  final String horseId;
  final Horse horseList;

  const HorseInvitesAssociations(
      {super.key, required this.horseId, required this.horseList});

  @override
  State<HorseInvitesAssociations> createState() =>
      _HorseInvitesAssociationsState();
}

class _HorseInvitesAssociationsState extends State<HorseInvitesAssociations> {
  final TextEditingController? userName = TextEditingController();
  final TextEditingController? associationType = TextEditingController();
  List<DropdownMenuItem<String>> role = [
    const DropdownMenuItem(
      value: "Owner",
      child: Text("Owner"),
    ),
    const DropdownMenuItem(
      value: "Rider",
      child: Text("Rider"),
    ),
    const DropdownMenuItem(
      value: "Groom",
      child: Text("Groom"),
    ),
    const DropdownMenuItem(
      value: "Trainer",
      child: Text("Trainer"),
    ),
  ];
  String? selectedRole;

  AssociationsCubit cubit = AssociationsCubit();

  @override
  void initState() {
    context.read<AssociationsCubit>().getRequestsAssociations();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var myCubit = context.watch<AssociationsCubit>();
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(20.h),
        child: CustomHeader(
          title: "${widget.horseList.name} Association",
          isThereBackButton: true,
          isThereChangeWithNavigate: false,
          isThereThirdOption: true,
          thirdOptionTitle: 'Add',
          onPressThirdOption: () {
            showGlobalBottomSheet(
                context: context,
                title: "${widget.horseList.name} Association",
                content: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 7),
                      child: RebiInput(
                        hintText: 'Username'.tra,
                        controller: userName,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.done,
                        isOptional: false,
                        color: AppColors.formsLabel,
                        readOnly: false,
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 13),
                        obscureText: false,
                        validator: (value) {
                          return Validator.requiredValidator(userName!.text);
                        },
                      ),
                    ),
                    StatefulBuilder(builder: (context, setState) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 7),
                        child: DropDownWidget(
                          items: role,
                          selected: selectedRole,
                          onChanged: (role1) {
                            setState(() {
                              selectedRole = role1;
                              Print('selected role $selectedRole');
                            });
                          },
                          validator: (value) {
                            // return Validator.requiredValidator(selectedNumber);
                          },
                          hint: 'Association Type',
                        ),
                      );
                    }),
                    const SizedBox(
                      height: 20,
                    ),
                    BlocConsumer(
                        bloc: cubit,
                        builder: (context, state) {
                          if (state is AssociateHorseLoading) {
                            return const LoadingCircularWidget();
                          }
                          return RebiButton(
                            onPressed: () {
                              _onPressAdd();
                            },
                            child: Text(
                              "Submit",
                              style: AppStyles.buttonStyle,
                            ),
                          );
                        },
                        listener: (context, state) {
                          if (state is AssociateHorseSuccessfully) {
                            myCubit.getInvitesAssociations();
                            Navigator.pop(context);
                          } else if (state is AssociateHorseError) {
                            RebiMessage.error(
                                msg: state.message!, context: context);
                          }
                        })
                  ],
                ));
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
              BlocBuilder<AssociationsCubit, AssociationsState>(
                builder: (context, state) {
                  if (state is GetRequestsAssociationsSuccessfully) {
                    if (state.model.count == 0) {
                      return const Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Center(
                            child: Text(
                              'Your horse has no Invites',
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
                          itemCount: state.model.count,
                          itemBuilder: (BuildContext context, int index) =>
                              GestureDetector(
                                onTap: () {
                                  final int associationId =
                                      state.model.rows![index].id!;
                                  showGlobalBottomSheet(
                                      context: context,
                                      title:
                                          "${state.model.rows![index].horse!.name!} Association",
                                      content: Column(
                                        children: [
                                          AssociateHorseDetailsWidget(
                                              title: "Stable",
                                              value: state.model.rows![index]
                                                      .horse!.stable?.name ??
                                                  ''),
                                          const CustomDivider(),
                                          AssociateHorseDetailsWidget(
                                              title: "Associated By",
                                              value: state.model.rows![index]
                                                  .fUser!.firstName!),
                                          CustomDivider(),
                                          AssociateHorseDetailsWidget(
                                              title: "Associated Role",
                                              value: state
                                                  .model.rows![index].type!),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          BlocConsumer<AssociationsCubit,
                                              AssociationsState>(
                                            bloc: cubit,
                                            listener: (context, state) {
                                              if (state
                                                  is CancelAssociateHorseSuccessfully) {
                                                RebiMessage.success(
                                                    msg: state.message,
                                                    context: context);
                                                myCubit
                                                    .getRequestsAssociations();
                                                Navigator.pop(context);
                                              } else if (state
                                                  is CancelAssociateHorseError) {
                                                RebiMessage.error(
                                                    msg: state.message!,
                                                    context: context);
                                              }
                                            },
                                            builder: (context, state) {
                                              if (state
                                                  is CancelAssociateHorseLoading) {
                                                return const LoadingCircularWidget(
                                                  isDeleteButton: true,
                                                );
                                              }
                                              return GestureDetector(
                                                onTap: () {
                                                  onPressCancel(associationId);
                                                },
                                                child: const Text(
                                                  'Disassociate',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: Color(0xFFFF0000),
                                                    fontSize: 16,
                                                    fontFamily: 'notosan',
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              );
                                            },
                                          )
                                        ],
                                      ));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: kPadding, vertical: 8),
                                  child: RequestAssociateWidget(
                                    role: state.model.rows![index].type,
                                    title: state
                                        .model.rows![index].tUser!.userName!,
                                    status: state.model.rows![index].status,
                                  ),
                                ),
                              ));
                    }
                  } else if (state is GetRequestsAssociationsError) {
                    return CustomErrorWidget(onRetry: () {
                      cubit.getRequestsAssociations();
                    });
                  } else if (state is GetRequestsAssociationsLoading) {
                    return LoadingCircularWidget();
                  }
                  return Container();
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  _onPressAdd() {
    cubit.createHorseAssociation(AssociateHorseRequestModel(
      horseId: int.parse(widget.horseId),
      userName: userName!.text,
      type: selectedRole,
    ));
  }

  onPressCancel(int id) {
    cubit.cancelHorseAssociation(id);
  }
}
