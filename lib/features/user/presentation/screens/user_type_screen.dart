import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proequine/core/utils/Printer.dart';
import 'package:proequine/core/widgets/rebi_button.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/constants/colors/app_colors.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/constants/thems/app_styles.dart';
import '../../../../core/utils/rebi_message.dart';
import '../../../../core/utils/sharedpreferences/SharedPreferencesHelper.dart';
import '../../../../core/widgets/custom_logo_widget.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../../nav_bar/presentation/screens/bottomnavigation.dart';
import '../../data/interests_request_model.dart';
import '../../domain/user_cubit.dart';
import '../widgets/register_header.dart';
import '../widgets/selectable_type_container.dart';

class UserTypeScreen extends StatefulWidget {
  String? interest;
  String? phone;

  UserTypeScreen({Key? key, this.interest, this.phone}) : super(key: key);

  @override
  State<UserTypeScreen> createState() => _UserTypeScreenState();
}

class _UserTypeScreenState extends State<UserTypeScreen> {
  final UserCubit cubit = UserCubit();
  final List<bool> _isSelected = [false, false, false, false];
  String? userType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            RegistrationHeader(isThereBackButton: false),
            const CustomLogoWidget(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: kPadding),
              child: Column(
                children: [
                  SizedBox(
                    height: 11.h,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Great!, Are you  ",
                        style: AppStyles.registrationTitle),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  SelectableTypeContainer(
                    label: 'Rider',
                    index: 0,
                    isSelected: _isSelected[0],
                    onSelected: (bool value) {
                      _handleSelected(0, value);
                      userType = 'Rider';
                      Print("Selected type $userType");
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  SelectableTypeContainer(
                    label: 'Owner',
                    index: 1,
                    isSelected: _isSelected[1],
                    onSelected: (bool value) {
                      _handleSelected(1, value);
                      userType = 'Owner';
                      Print("Selected type $userType");
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  SelectableTypeContainer(
                    label: 'Groom',
                    index: 2,
                    isSelected: _isSelected[2],
                    onSelected: (bool value) {
                      _handleSelected(2, value);
                      userType = 'Groom';
                      Print("Selected type $userType");
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  SelectableTypeContainer(
                    label: 'Trainer',
                    index: 3,
                    isSelected: _isSelected[3],
                    onSelected: (bool value) {
                      _handleSelected(3, value);
                      userType = 'Trainer';
                      Print("Selected type $userType");
                    },
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
    );
  }

  void _handleSelected(int index, bool value) {
    setState(() {
      for (int i = 0; i < _isSelected.length; i++) {
        _isSelected[i] = false;
      }
      _isSelected[index] = value;
    });
  }

  _buildSelectTypeConsumer() {
    return BlocConsumer<UserCubit, UserState>(
        bloc: cubit,
        builder: (context, state) {
          if (state is SelectInterestsLoading) {
            return LoadingCircularWidget();
          } else if (state is SelectInterestsError) {
            RebiMessage.error(msg: state.message!);
          }
          {
            return RebiButton(
                backgroundColor:
                    userType != null ? AppColors.white : AppColors.formsLabel,
                onPressed: () {
                  if (userType != null) {
                    _onPressConfirm();
                  } else {
                    RebiMessage.error(msg: 'Please select your type');
                  }
                },
                child: const Text("Continue"));
          }
        },
        listener: (context, state) {
          if (state is SelectInterestsSuccessful) {
            AppSharedPreferences.typeSelected = true;
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => BottomNavigation()));
          } else if (state is SelectInterestsError) {
            RebiMessage.error(msg: state.message!);
          }
        });
  }

  _onPressConfirm() {
    return cubit
      ..interests(InterestsRequestModel(
        phoneNumber: widget.phone,
        interest: widget.interest,
        type: userType,
      ));
  }
}
