import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proequine/core/utils/Printer.dart';
import 'package:proequine/core/utils/rebi_message.dart';
import 'package:proequine/core/widgets/custom_error_widget.dart';
import 'package:proequine/core/widgets/rebi_button.dart';
import 'package:proequine/features/user/presentation/screens/choose_stable_screen.dart';
import '../../../../core/constants/colors/app_colors.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/constants/thems/app_styles.dart';
import '../../../../core/utils/sharedpreferences/SharedPreferencesHelper.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../../nav_bar/domain/navbar_cubit.dart';
import '../../data/interests_request_model.dart';
import '../../domain/user_cubit.dart';
import '../widgets/register_header.dart';
import '../widgets/selectable_type_container.dart';

class UserInfoScreen extends StatefulWidget {
  const UserInfoScreen({Key? key}) : super(key: key);

  @override
  State<UserInfoScreen> createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  final UserCubit cubit = UserCubit();
  List<bool> _isInterestsSelected = [];
  String? interest;

  final List<bool> _isUserTypeSelected = [false, false, false, false, false];
  String? userType;

  @override
  void initState() {
    _isInterestsSelected = List<bool>.generate(20, (counter) => false);
    cubit.getDisciplines();
    super.initState();
  }

  @override
  void dispose() {
    cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => BlocProvider.of<NavbarCubit>(context).onWillPop(context),
      child: Scaffold(
        body: SafeArea(
          child: Column(
                  children: [
                    RegistrationHeader(isThereBackButton: false),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: kPadding),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child:
                            Text("Equine Info", style: AppStyles.mainTitle),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                                "This can be anything you like and can be changed later, chose your Main discipline and role.",
                                style: AppStyles.descriptions),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text("What’s your discipline",
                                style: AppStyles.mainTitle2),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          BlocBuilder<UserCubit, UserState>(
                            bloc: cubit,
                            builder: (context, state) {
                              if(state is GetAllDisciplinesSuccessful){
                                return GridView.builder(
                                    itemCount: state.disciplines.length,
                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                    gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        childAspectRatio: (5 / 1.2),
                                        crossAxisSpacing: 10,
                                        mainAxisSpacing: 10,
                                        crossAxisCount: 2),
                                    itemBuilder: (context, index) {
                                      return SelectableTypeContainer(
                                        label:
                                        state.disciplines[index].disciplineTitle,
                                        index: index,
                                        isSelected: _isInterestsSelected[index],
                                        onSelected: (bool value) {
                                          _handleSelected(
                                              index, value, _isInterestsSelected);
                                          interest = state
                                              .disciplines[index].disciplineTitle
                                              .toString();
                                          Print("Selected type $interest");
                                        },
                                      );
                                    });
                              }
                              else if (state is GetAllDisciplinesError) {
                                return CustomErrorWidget(
                                  errorMessage: 'Oops! Something went wrong. Please try again.',
                                  onRetry: () {
                                    cubit.getDisciplines();
                                  },
                                );
                              }
                              return Container();

                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text("I’m", style: AppStyles.mainTitle2),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          GridView.count(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            crossAxisCount: 2,
                            childAspectRatio: (5 / 1.2),
                            mainAxisSpacing: 14,
                            crossAxisSpacing: 8,
                            children: [
                              SelectableTypeContainer(
                                label: 'Rider',
                                index: 0,
                                isSelected: _isUserTypeSelected[0],
                                onSelected: (bool value) {
                                  _handleSelected(
                                      0, value, _isUserTypeSelected);
                                  userType = 'Rider';
                                  Print("Selected type $userType");
                                },
                              ),
                              SelectableTypeContainer(
                                label: 'Owner',
                                index: 1,
                                isSelected: _isUserTypeSelected[1],
                                onSelected: (bool value) {
                                  _handleSelected(
                                      1, value, _isUserTypeSelected);
                                  userType = 'Owner';
                                  Print("Selected type $userType");
                                },
                              ),
                              SelectableTypeContainer(
                                label: 'Trainer',
                                index: 2,
                                isSelected: _isUserTypeSelected[2],
                                onSelected: (bool value) {
                                  _handleSelected(
                                      2, value, _isUserTypeSelected);
                                  userType = 'Trainer';
                                  Print("Selected type $userType");
                                },
                              ),
                              SelectableTypeContainer(
                                  label: 'Groom',
                                  index: 3,
                                  isSelected: _isUserTypeSelected[3],
                                  onSelected: (bool value) {
                                    _handleSelected(
                                        3, value, _isUserTypeSelected);
                                    userType = 'Groom';
                                  }),
                              SelectableTypeContainer(
                                label: 'Spectator',
                                index: 4,
                                isSelected: _isUserTypeSelected[4],
                                onSelected: (bool value) {
                                  _handleSelected(
                                      4, value, _isUserTypeSelected);
                                  userType = 'Spectator';
                                  Print("Selected type $userType");
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      child: _buildSelectTypeConsumer(),
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

  _buildSelectTypeConsumer() {
    return BlocConsumer<UserCubit, UserState>(
        bloc: cubit,
        builder: (context, state) {
          if (state is SelectInterestsLoading) {
            return const LoadingCircularWidget();
          }
          {
            return RebiButton(
              backgroundColor: interest != null && userType != null
                  ? AppColors.yellow
                  : AppColors.formsLabel,
              onPressed: () {
                if (userType != null && interest != null) {
                  _onPressConfirm();
                } else {
                  RebiMessage.error(
                      msg: 'Please select your interests & type',
                      context: context);
                }
              },
              child: const Text("Next"),
            );
          }
        },
        listener: (context, state) {
          if (state is SelectInterestsSuccessful) {
            AppSharedPreferences.typeSelected = true;
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const ChoseStableScreen()));
          } else if (state is SelectInterestsError) {
            RebiMessage.error(msg: state.message!, context: context);
          }
        });
  }

  _onPressConfirm() {
    return cubit
      ..interests(InterestsRequestModel(
        personId: int.parse(AppSharedPreferences.personId),
        discipline: interest,
        userType: userType,
      ));
  }

  void _handleSelected(int index, bool value, var _isSelected) {
    setState(() {
      for (int i = 0; i < _isSelected.length; i++) {
        _isSelected[i] = false;
      }
      _isSelected[index] = value;
    });
  }
}
