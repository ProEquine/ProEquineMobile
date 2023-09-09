import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proequine/core/utils/Printer.dart';
import 'package:proequine/core/utils/rebi_message.dart';
import 'package:proequine/core/utils/sharedpreferences/SharedPreferencesHelper.dart';
import 'package:proequine/core/widgets/rebi_button.dart';
import 'package:proequine/features/user/presentation/screens/choose_stable_screen.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/constants/colors/app_colors.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/constants/thems/app_styles.dart';
import '../../../../core/widgets/custom_logo_widget.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../../nav_bar/domain/navbar_cubit.dart';
import '../../../nav_bar/presentation/screens/bottomnavigation.dart';
import '../../data/interests_request_model.dart';
import '../../domain/user_cubit.dart';
import '../widgets/register_header.dart';
import '../widgets/selectable_type_container.dart';

class EquineInfoScreen extends StatefulWidget {
  const EquineInfoScreen({Key? key}) : super(key: key);

  @override
  State<EquineInfoScreen> createState() => _EquineInfoScreenState();
}

class _EquineInfoScreenState extends State<EquineInfoScreen> {

  final UserCubit cubit = UserCubit();
  final List<bool> _isInterestsSelected = [false, false, false, false];
  String? interest;

  final List<bool> _isUserTypeSelected = [false, false, false, false,false];
  String? userType;

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
                      child: Text("Equine Info", style: AppStyles.mainTitle),
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
                      child: Text("What’s your discipline", style: AppStyles.mainTitle2),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    GridView.count(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      childAspectRatio: (5 / 1.2),
                      mainAxisSpacing: 14,
                      crossAxisSpacing: 8,
                      children: [
                        SelectableTypeContainer(
                          label: 'Show Jumping',
                          index: 0,
                          isSelected: _isInterestsSelected[0],
                          onSelected: (bool value) {
                            _handleSelected(0, value,_isInterestsSelected);
                            interest = 'Show Jumping';
                            Print("Selected type $interest");
                          },
                        ),
                        SelectableTypeContainer(
                          label: 'Racing',
                          index: 1,
                          isSelected: _isInterestsSelected[1],
                          onSelected: (bool value) {
                            _handleSelected(1, value,_isInterestsSelected);
                            interest = 'Racing';
                            Print("Selected type $interest");
                          },
                        ),
                        SelectableTypeContainer(
                          label: 'Dressage',
                          index: 2,
                          isSelected: _isInterestsSelected[2],
                          onSelected: (bool value) {
                            _handleSelected(2, value,_isInterestsSelected);
                            interest = 'Dressage';
                            Print("Selected type $interest");
                          },
                        ),
                        SelectableTypeContainer(
                          label: 'Endurance',
                          index: 3,
                          isSelected: _isInterestsSelected[3],
                          onSelected: (bool value) {
                            _handleSelected(3, value,_isInterestsSelected);
                            interest = 'Endurance';
                            Print("Selected type $interest");
                          },
                        ),
                      ],
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
                      physics: NeverScrollableScrollPhysics(),
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
                            _handleSelected(0, value,_isUserTypeSelected);
                            userType = 'Rider';
                            Print("Selected type $userType");
                          },
                        ),
                        SelectableTypeContainer(
                          label: 'Owner',
                          index: 1,
                          isSelected: _isUserTypeSelected[1],
                          onSelected: (bool value) {
                            _handleSelected(1, value,_isUserTypeSelected);
                            userType = 'Owner';
                            Print("Selected type $userType");
                          },
                        ),

                        SelectableTypeContainer(
                          label: 'Trainer',
                          index: 2,
                          isSelected: _isUserTypeSelected[2],
                          onSelected: (bool value) {
                            _handleSelected(2, value,_isUserTypeSelected);
                            userType = 'Trainer';
                            Print("Selected type $userType");
                          },
                        ),
                        SelectableTypeContainer(
                            label: 'Groom',
                            index: 3,
                            isSelected: _isUserTypeSelected[3],
                            onSelected: (bool value) {
                              _handleSelected(3, value,_isUserTypeSelected);
                              userType = 'Groom';
                            }),
                        SelectableTypeContainer(
                          label: 'Spectator',
                          index: 4,
                          isSelected: _isUserTypeSelected[4],
                          onSelected: (bool value) {
                            _handleSelected(4, value,_isUserTypeSelected);
                            userType = 'Spectator';
                            Print("Selected type $userType");
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
             Spacer(),
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
          } else if (state is SelectInterestsError) {
            RebiMessage.error(msg: state.message!,context: context);
          }
          {
            return RebiButton(
                backgroundColor:
                interest != null && userType!=null ? AppColors.yellow : AppColors.formsLabel,
                onPressed: () {
                  if (userType != null && interest !=null) {
                    _onPressConfirm();
                  } else {
                    RebiMessage.error(msg: 'Please select your interests & type',context: context);
                  }
                },
              child: const Text("Next"),);
          }
        },
        listener: (context, state) {
          // if (state is SelectInterestsSuccessful) {
          //   AppSharedPreferences.typeSelected = true;
          //   Navigator.push(context,
          //       MaterialPageRoute(builder: (context) => const BottomNavigation()));
          // } else if (state is SelectInterestsError) {
          //   RebiMessage.error(msg: state.message!,context: context);
          // }
        });
  }

  _onPressConfirm() {
    // return cubit
    //   ..interests(InterestsRequestModel(
    //     phoneNumber: AppSharedPreferences.userPhoneNumber,
    //     interest: interest,
    //     type: userType,
    //   ));
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const ChooseStableScreen()));
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
