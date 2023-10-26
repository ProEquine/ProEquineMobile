import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:proequine/core/constants/constants.dart';
import 'package:proequine/core/widgets/custom_error_widget.dart';
import 'package:proequine/features/equine_info/domain/equine_info_cubit.dart';
import 'package:proequine/features/equine_info/presentation/screens/remove_role_screen.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/constants/routes/routes.dart';
import '../../../../core/utils/Printer.dart';
import '../../../../core/widgets/custom_header.dart';
import '../../../../core/widgets/profile_list_tile_widget.dart';

class AllRolesScreen extends StatefulWidget {
  const AllRolesScreen({super.key});

  @override
  State<AllRolesScreen> createState() => _AllRolesScreenState();
}

class _AllRolesScreenState extends State<AllRolesScreen> {
  EquineInfoCubit cubit = EquineInfoCubit();

  @override
  void initState() {
    cubit.getUserRoles();
    super.initState();
  }

  @override
  void dispose() {
    cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final themeCubit = ThemeCubitProvider.of(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(20.h),
        child: CustomHeader(
          title: "Role",
          isThereBackButton: true,
          isThereChangeWithNavigate: false,
          isThereThirdOption: true,
          thirdOptionTitle: 'Add',
          onPressThirdOption: () {
            Navigator.pushNamed(context, addNewRole);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(kPadding),
          child: BlocBuilder<EquineInfoCubit, EquineInfoState>(
            bloc: cubit,
            builder: (context, state) {

              if (state is GetUserRolesSuccessful) {
                Print(state.model!.roles!.length);
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListView.builder(
                        itemCount: state.model!.roles!.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return ProfileListTileWidget(
                            title: state.model!.roles?[index],
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => RemoveRoleScreen(
                                          name: state.model!.roles![index],
                                          roleId: index)));
                            },
                            notificationList: false,
                            isThereNewNotification: false,
                          );
                        }),
                    const SizedBox(
                      height: 5,
                    ),
                  ],
                );
              } else if (state is GetUserRolesError) {
                return CustomErrorWidget(onRetry: () {
                  cubit.getUserRoles();
                });
              }return Container();
            },
          ),
        ),
      ),
    );
  }
}
