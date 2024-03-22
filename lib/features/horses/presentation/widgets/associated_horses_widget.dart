import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proequine/features/associations/domain/associations_cubit.dart';
import 'package:proequine/features/associations/presentation/widgets/invite_association_widget.dart';
import 'package:proequine/features/horses/presentation/screens/accepted_associated_horse_screen.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/widgets/custom_error_widget.dart';
import '../../../horses/presentation/widgets/empty_horses_widget.dart';
import '../../../horses/presentation/widgets/main_horses_loading_widget.dart';

class AssociatedHorsesWidget extends StatefulWidget {
  const AssociatedHorsesWidget({super.key});

  @override
  State<AssociatedHorsesWidget> createState() =>
      _AssociatedHorsesWidgetState();
}

class _AssociatedHorsesWidgetState extends State<AssociatedHorsesWidget> {
  @override
  void initState() {
    context.read<AssociationsCubit>().getInvitesAssociations('approved');
    super.initState();
  }

  AssociationsCubit cubit = AssociationsCubit();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: BlocBuilder<AssociationsCubit, AssociationsState>(
        // bloc: cubit,
        builder: (context, state) {
          if (state is GetInviteAssociationsSuccessfully) {
            if (state.invites.count == 0) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                      child: EmptyHorsesWidget(
                        associated: true,
                      ))
                ],
              );
            } else {
              return Column(
                children: [
                  GridView.builder(
                      gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                        mainAxisSpacing: 8,
                        childAspectRatio: 0.8,

                        crossAxisCount: 2, // Adjust the number of columns
                      ),
                      shrinkWrap: true,
                      primary: false,
                      itemCount: state.invites.count,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: kPadding, vertical: 10),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context) =>
                                      AssociatedHorseDetailsScreen(
                                        requestedHorseModel: state.invites.rows![index],
                                      )));
                            },
                            child: InviteAssociationWidget(
                              associateName: state
                                  .invites.rows![index].fUser!.firstName!,
                              associateRole: state.invites.rows![index].type!,
                              type: 'Approved',
                              age: state.invites.rows![index].horse!.age!
                                  .toString()??'1',
                              gender:
                              state.invites.rows![index].horse!.gender!,
                              breed: state.invites.rows![index].horse!.breed!,
                              horseName:
                              state.invites.rows![index].horse!.name!,
                              horsePic:
                              state.invites.rows![index].horse!.image ??
                                  '',
                              isVerified: true,
                              horseStable:
                              state.invites.rows![index].horse!.gender!,
                              horseStatus:
                              state.invites.rows![index].horse!.status!,
                            ),
                          ),
                        );
                      }),
                  const SizedBox(
                    height: 80,
                  ),
                ],
              );
            }
          }
          if (state is GetInviteAssociationsError) {
            return CustomErrorWidget(onRetry: () {
              cubit.getInvitesAssociations('approved');
            });
          } else if (state is GetInviteAssociationsLoading) {
            return const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(child: MainHorsesLoadingWidget()),
              ],
            );
          }
          return Container();
        },
      ),

    );
  }
}


